module page_buffer (
    
);
    input addr_load;
    input [63:0] page_data_i;
    output [63:0] page_data_o;
    output data_o;
    reg [7:0]page_data[0:7];
    reg [7:0] data [0:7];
    assign data_o = data[col];
    input [2:0] col;
    assign page_data_o = {
                        page_data[7],
                        page_data[6],
                        page_data[5],
                        page_data[4],
                        page_data[3],
                        page_data[2],
                        page_data[1],
                        page_data[0]
                        };
    always @(posedge scl) begin
        if(addr_load)begin

        end
        if(store)begin
            data[i] = shift_reg;
        end
    end
    always @() begin
        
    end
    always @(col) begin
        case(col)
            3'd0:data = page_data_i[7:0];
            3'd1:data = page_data_i[15:8];
            3'd2:data = page_data_i[23:16];
            3'd3:data = page_data_i[31:24];
            3'd4:data = page_data_i[39:32];
            3'd5:data = page_data_i[47:40];
            3'd6:data = page_data_i[55:48];
            3'd7:data = page_data_i[63:56];
        endcase
    end
    assign data_o = data;
endmodule