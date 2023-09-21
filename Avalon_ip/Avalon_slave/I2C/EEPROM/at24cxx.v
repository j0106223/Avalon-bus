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
    localparam rom_byte_size = 128;
    //start detection circuit
    reg start_detect = scl & ~sda;
    reg stop_detect = scl sda;
    reg [7:0] eeprom [0:rom_byte_size-1];
    wire x_dec;
    wire y_dec;
    always @(posedge xxx) begin
        eeprom[x_dec] <= xxx;
    end
    wire [7:0] rdata_byte;
    wire rdata_bit;
    assign rdata_byte = eeprom[x_dec];
    assign rdata_bit = rdata_byte[y_dec]
    //serial mux
    always @* begin
        case(y_dec)

        endcase
    end

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