module stop_logic (
    scl,
    sda,
    start_detected,
    stop_detected
);
    input scl;
    input sda;
    input start_detected;
    output stop_detected;
    reg detected;
    assign stop_detected = detected;
    always @(posedge sda or posedge start_detected) begin
        if(start_detected)begin
            detected <= 1'b0;
        end else begin
            if(scl)begin
                detected <= 1'b1;
            end
        end
    end
endmodule