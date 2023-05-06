`default_nettype none
module avs_pwm (
    clk,
    reset_n,
    avs_s0_address,
    avs_s0_read,
    avs_s0_write,
    avs_s0_writedata,
    avs_s0_readdata,
    avs_s0_waitrequest,
    avs_s0_export_pwm_o
);
    input   clk;
    input   reset_n;
    input   [1:0] avs_s0_address;
    input         avs_s0_read;
    input         avs_s0_write;
    input  [31:0] avs_s0_writedata;
    output [31:0] avs_s0_readdata;
    output        avs_s0_waitrequest;
    output        avs_s0_export_pwm_o;
    //master no need to wait for read write operation
    assign        avs_s0_waitrequest = 1'b0;
    assign        avs_s0_readdata = readdata;
    //internal register
    reg [31:0]control;
    reg [31:0]period;
    reg [31:0]duty_cycle;

    always @(posedge clk or negedge reset_n) begin
        if(!reset_n)begin
            control     <= 0;
            period      <= 0;
            duty_cycle  <= 0;
        end else begin
            if(avs_s0_write)begin
                case (avs_s0_address)
                    0: control    <= avs_s0_writedata;
                    1: period     <= avs_s0_writedata;
                    2: duty_cycle <= avs_s0_writedata;
                    default:begin
                        control    <= 0;
                        period     <= 0;
                        duty_cycle <= 0;
                    end
                endcase
            end
        end
    end


    reg [31:0]readdata;
    always @(*) begin
        if(avs_s0_read)begin
            case (avs_s0_address)
                0: readdata = control;
                1: readdata = period;
                2: readdata = duty_cycle;
                default:readdata = 0; 
            endcase
        end else begin
            readdata = 0;
        end
    end

    pwm pwm_inst(
        .clk        (clk),
        .reset_n    (reset_n),
        .period     (period),
        .duty_cycle (duty_cycle),
        .pwm_o      (avs_s0_export_pwm_o)
    );
endmodule