module serial_mux (
    
);
    input [2:0] y;
    input [7:0] data_i;
    output data_o;
    assign data_o = data_i[y];
    
endmodule