module at24cxx (
    scl,
    sda,
);
    input scl;
    inout sda;
    input wp;//write protect
    input a2;
    input a1;
    input a0;
    localparam HIGH = 1'b1;
    localparam LOW  = 1'b0;
    //start detection circuit
    reg start_detect = scl & ~sda;
    reg stop_detect = scl sda;
    always @(posedge sda) begin
        
    end

    always @(negedge sda) begin
        
    end
    reg en;
    always @(sda) begin
        if (sda == HIGH) begin
            if (scl == HIGH) begin
                en = 1'b0;
            end else begin
                en = 1'b0;
            end
        end else begin
            if(scl == HIGH)begin
                en = 1'b1;
            end else begin
                en = 1'b0;
            end
        end
    end
endmodule