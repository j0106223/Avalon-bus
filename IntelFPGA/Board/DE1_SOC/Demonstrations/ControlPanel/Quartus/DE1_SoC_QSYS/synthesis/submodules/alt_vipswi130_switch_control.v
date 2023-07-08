module alt_vipswi130_switch_control
    #(parameter
        AV_ADDRESS_WIDTH = 5,
        AV_DATA_WIDTH = 16,
        NO_INPUTS = 4,
        NO_OUTPUTS = 4,
        NO_SYNCS = 4)
    (
    input   wire                              rst,
    input   wire                              clk,
    
    // control
    input   wire [AV_ADDRESS_WIDTH-1:0]       av_address,
    input   wire                              av_read,
    output  reg  [AV_DATA_WIDTH-1:0]          av_readdata,
    input   wire                              av_write,
    input   wire [AV_DATA_WIDTH-1:0]          av_writedata,
    
    // internal
    output  wire                              enable,
    output  reg  [(NO_INPUTS*NO_OUTPUTS)-1:0] select,
    input   wire [NO_SYNCS-1:0]             synced);

reg master_enable;
reg output_switch;
reg [NO_INPUTS-1:0] output_control[NO_OUTPUTS-1:0];
wire global_synced;

always @ (posedge clk or posedge rst) begin
    if(rst) begin
        master_enable <= 1'b0;
        output_switch <= 1'b0;
        av_readdata <= {AV_DATA_WIDTH{1'b0}};
    end else begin
        if(av_write) begin
            master_enable <= (av_address == 0) ? av_writedata[0] : master_enable;
        end
        
        output_switch <= (av_write && av_address == 2) ? av_writedata[0] : output_switch & ~global_synced;
        
        if(av_read) begin
            case(av_address)
                0: av_readdata <= {{AV_DATA_WIDTH-1{1'b0}}, master_enable};
                2: av_readdata <= {{AV_DATA_WIDTH-1{1'b0}}, output_switch};
                default: av_readdata <= {{AV_DATA_WIDTH-1{1'b0}}, !global_synced};
            endcase
        end
        
    end
end

generate
    genvar i;
    for(i = 0; i < NO_OUTPUTS; i=i+1) begin : control_loop
        always @ (posedge clk or posedge rst) begin
            if(rst) begin
                output_control[i] <= {NO_INPUTS{1'b0}};
                select[(i*NO_INPUTS)+NO_INPUTS-1:(i*NO_INPUTS)] <= {NO_INPUTS{1'b0}};
            end else begin
                if(av_write && av_address == i + 3) begin
                    output_control[i] <= av_writedata[NO_INPUTS-1:0];
                end
                
                if(global_synced) begin
                    select[(i*NO_INPUTS)+NO_INPUTS-1:(i*NO_INPUTS)] <= output_control[i];
                end
            end
        end
    end
endgenerate

assign global_synced = &synced;
assign enable = master_enable & ~output_switch;

endmodule
