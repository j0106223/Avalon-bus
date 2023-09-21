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

    //device address comparator
    reg [6:0] get_addr;
    wire addr_compare_success;
    always @(posedge scl) begin
        get_addr <= {get_addr[6:1], sda};    
    end
    assign addr_compare_success = (addr_compare) & (get_addr == device_id);
endmodule