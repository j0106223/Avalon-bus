module start_stop_logic (
    scl,
    sda,
    start_detected,
    stop_detected
);
    input scl;
    input sda;
    output start_detected;
    output stop_detected;
    start_logic start_logic_inst(
        .scl            (scl),
        .sda            (sda),
        .start_detected (start_detected)
    );
    stop_logic stop_logic_inst(
        .scl            (scl),
        .sda            (sda),
        .start_detected (start_detected),
        .stop_detected  (stop_detected)
    );
endmodule