module alt_vipcti130_Vid2IS_write_buffer
    #(parameter
        DATA_WIDTH = 20,
        NUMBER_OF_COLOUR_PLANES = 2,
        BPS = 10)
    (
    input wire rst,
    input wire clk,
    
    input wire convert,
    input wire hd_sdn,
    input wire early_eop,
    
    input wire wrreq_in,
    input wire [DATA_WIDTH-1:0] data_in,
    input wire packet_in,
    
    output wire wrreq_out,
    output wire [DATA_WIDTH-1:0] data_out,
    output wire packet_out);
    
reg [BPS-1:0] write_buffer_data[NUMBER_OF_COLOUR_PLANES-1:0];
reg [NUMBER_OF_COLOUR_PLANES-1:0] write_buffer_valid;
reg write_buffer_packet;

generate begin : write_buffer_generation
    genvar i;
    for(i = 0; i < NUMBER_OF_COLOUR_PLANES; i = i + 1) begin : write_buffer_generation_for_loop
        always @ (posedge rst or posedge clk) begin
            if(rst) begin
                write_buffer_data[i] <= {BPS{1'b0}};
                write_buffer_valid[i] <= 1'b0;
            end else begin
                if(wrreq_in && !early_eop) begin
                    if(!hd_sdn) begin
                        if(!convert) begin
                            // copy the ancilliary data into the Y (control packet copied as well
                            // but that won't affect anything)
                            write_buffer_data[i] <= data_in[BPS-1:0];
                            write_buffer_valid[i] <= 1'b1;
                        end else begin
                            if((i == 0) ? write_buffer_valid[i] == 0 || wrreq_out : write_buffer_valid[i] == 0 && write_buffer_valid[i-1] == 1) begin    // decide which part of the buffer to insert the sample
                                write_buffer_data[i] <= data_in[BPS-1:0]; 
                                write_buffer_valid[i] <= 1'b1;
                            end else begin
                                if(wrreq_out) begin
                                    write_buffer_valid[i] <= 1'b0;   // clear the buffer
                                end
                            end
                        end
                    end else begin
                        write_buffer_data[i] <= data_in[(i*BPS)+(BPS-1):(i*BPS)];
                        write_buffer_valid[i] <= 1'b1;
                    end
                end else begin
                    if(wrreq_out) begin
                        write_buffer_valid[i] <= 1'b0;   // clear the buffer
                    end
                end
            end
        end
        
        assign data_out[(i*BPS)+(BPS-1):(i*BPS)] = write_buffer_data[i];
    end
end endgenerate

always @ (posedge rst or posedge clk) begin
    if(rst) begin
        write_buffer_packet <= 1'b0;
    end else begin
        if(wrreq_in && !early_eop) begin
            if(!hd_sdn) begin
                if(packet_in) begin
                    write_buffer_packet <= 1'b1;
                end else if(wrreq_out) begin
                    write_buffer_packet <= 1'b0;
                end
            end else begin
                write_buffer_packet <= packet_in;
            end
        end else begin
            if(wrreq_out) begin
                write_buffer_packet <= 1'b0;
            end
        end
    end
end

assign wrreq_out = (&write_buffer_valid) | early_eop;
assign packet_out = write_buffer_packet | early_eop;

endmodule
