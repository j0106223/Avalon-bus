module alt_vipcti131_Vid2IS_embedded_sync_extractor
    #(parameter 
        DATA_WIDTH = 20,
        BPS = 10,
        BASE = 0,
        GENERATE_ANC = 0)
    (
        input wire rst,
        input wire clk,
    
        // video
        input wire vid_locked,
        input wire vid_enable,
        input wire vid_hd_sdn,
        input wire [DATA_WIDTH-1:0] vid_data_in,
    
        // optional video ports
        output wire vid_f,
        output wire vid_v_sync,
        output wire vid_h_sync,
        output wire vid_datavalid,
        output wire vid_anc_valid,
        output wire [DATA_WIDTH-1:0] vid_data_out);

// TODO: compile this and fix any errors
        
// When using embedded syncs the h,v and f flags must be extracted from the
// BT656 stream and used to extract the active picture data.
wire trs;
wire anc_nxt, anc_nxt_sd, anc_nxt_hd;
reg [2:0] anc_state;
reg [7:0] data_count;
wire [7:0] data_count_next, data_count_next_sd, data_count_next_hd;
reg [DATA_WIDTH-1:0] vid_data0, vid_data1, vid_data2;
reg [3:0] wrreq_regs;
wire h_next, v_next, f_next;
wire h, v;
reg h_reg;
reg [3:0] f_delay, h_delay, v_delay;
wire [3:0] f_delay_nxt, h_delay_nxt, v_delay_nxt;

localparam ANC_IDLE         = 3'd0;
localparam ANC_DATA_FLAG_1  = 3'd1;
localparam ANC_DATA_FLAG_2  = 3'd2;
localparam ANC_DATA_FLAG_3  = 3'd3;
localparam ANC_DID          = 3'd4;
localparam ANC_SID          = 3'd5;
localparam ANC_DATA_COUNT   = 3'd6;
localparam ANC_USER_WORDS   = 3'd7;

assign vid_data_out = vid_data2;

assign trs = (vid_data2[BPS-1:0] == {BPS{1'b1}}) &
             (vid_data1[BPS-1:0] == {BPS{1'b0}}) &
             (vid_data0[BPS-1:0] == {BPS{1'b0}}) &
             vid_enable;
             
assign anc_nxt_sd = (vid_data1[BPS-1:0]    == {BPS{1'b0}}) &
                    (vid_data0[BPS-1:0]    == {BPS{1'b1}}) &
                    (vid_data_in[BPS-1:0]  == {BPS{1'b1}}) &
                    vid_enable;
assign data_count_next_sd = vid_data2[7:0];

assign anc_nxt_hd = (vid_data1[DATA_WIDTH-1:DATA_WIDTH-BPS]    == {BPS{1'b0}}) &
                    (vid_data0[DATA_WIDTH-1:DATA_WIDTH-BPS]    == {BPS{1'b1}}) &
                    (vid_data_in[DATA_WIDTH-1:DATA_WIDTH-BPS]  == {BPS{1'b1}}) &
                    vid_enable;
assign data_count_next_hd = vid_data2[(DATA_WIDTH-BPS)+7:DATA_WIDTH-BPS];

assign anc_nxt = (vid_hd_sdn) ? anc_nxt_hd : anc_nxt_sd;
assign data_count_next = (vid_hd_sdn) ? data_count_next_hd : data_count_next_sd;

assign vid_anc_valid = anc_state != ANC_IDLE && !vid_h_sync;
assign h_next = (trs) ? vid_data_in[BASE+4] : h_reg;
assign v_next = (trs) ? vid_data_in[BASE+5] : v_delay[0];
assign f_next = (trs) ? vid_data_in[BASE+6] : f_delay[0];
assign h_delay_nxt = (trs) ? 4'b1111 : {h_delay[2:0], h_next};
assign v_delay_nxt = (trs) ? {4{v_next}} : {v_delay[2:0], v_next};
assign f_delay_nxt = (trs) ? {4{f_next}} : {f_delay[2:0], f_next};
assign h = h_delay_nxt[3];
assign v = v_delay_nxt[3];
assign vid_f = f_delay_nxt[3];
assign vid_h_sync = h;
assign vid_v_sync = v;
assign vid_datavalid = ~h & ~v;
assign count_cycle = vid_enable;
assign last_sample = (v_next && ~v_delay[0]) || (anc_state == ANC_DATA_FLAG_3 && ~anc_nxt);

always @ (posedge rst or posedge clk) begin
    if(rst) begin
        vid_data0 <= {DATA_WIDTH{1'b0}};
        vid_data1 <= {DATA_WIDTH{1'b0}};
        vid_data2 <= {DATA_WIDTH{1'b0}};
        
        h_reg <= 1'b0;
        h_delay <= 4'b000;
        v_delay <= 4'b000;
        f_delay <= 4'b000;
        
        anc_state <= ANC_IDLE;
        data_count <= 8'd0;
    end else begin
        vid_data0 <= (vid_enable) ? vid_data_in  : vid_data0;
        vid_data1 <= (vid_enable) ? vid_data0 : vid_data1;
        vid_data2 <= (vid_enable) ? vid_data1 : vid_data2;
        
        h_reg <= h_next;
        if(vid_enable) begin
            h_delay <= h_delay_nxt;
            v_delay <= v_delay_nxt;
            f_delay <= f_delay_nxt;
        end
        
        if(vid_locked) begin
            if(vid_enable) begin
                case(anc_state)
                    ANC_IDLE: begin
                        if(anc_nxt && !h_next && GENERATE_ANC == 1)
                            anc_state <= ANC_DATA_FLAG_1;
                    end
                    ANC_DATA_FLAG_1: begin
                        anc_state <= ANC_DATA_FLAG_2;
                    end
                    ANC_DATA_FLAG_2: begin
                        anc_state <= ANC_DATA_FLAG_3;
                    end
                    ANC_DATA_FLAG_3: begin
                        anc_state <= ANC_DID;
                    end
                    ANC_DID: begin
                        anc_state <= ANC_SID;
                    end
                    ANC_SID: begin
                        anc_state <= ANC_DATA_COUNT;
                    end
                    ANC_DATA_COUNT: begin
                        data_count <= data_count_next;
                        anc_state <= ANC_USER_WORDS;
                    end
                    ANC_USER_WORDS: begin
                        if(data_count == 8'd0 || !vid_v_sync)
                            if(anc_nxt)
                                anc_state <= ANC_DATA_FLAG_1;
                            else
                                anc_state <= ANC_IDLE;
                        else if(!vid_h_sync)
                              data_count <= data_count - 8'd1;
                    end
                endcase
            end
        end else begin
            anc_state <= ANC_IDLE;
        end
    end
end

endmodule
