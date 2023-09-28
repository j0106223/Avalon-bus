module start_logic (
    scl,
    sda,
    start_detected
);
    input scl;
    input sda;
    output start_detected;
    reg detected;

    assign start_detected = detected;
    always @(negedge sda or posedge scl) begin
        if(scl)begin
            detected <= 1'b0;
        end else begin
            detected <= 1'b1;
        end
    end
endmodule