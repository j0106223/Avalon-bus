module alt_vipcti130_Vid2IS_sync_polarity_convertor(
    input rst,
    input clk,
    
    input sync_in,
    input datavalid,
    output sync_out);

wire datavalid_negedge;
reg datavalid_reg;
wire needs_invert_nxt;
reg needs_invert;
wire invert_sync_nxt;
reg invert_sync;

assign datavalid_negedge = datavalid_reg & ~datavalid;
assign needs_invert_nxt = (datavalid & sync_in) | needs_invert;
assign invert_sync_nxt = (datavalid_negedge) ? needs_invert_nxt : invert_sync;

always @ (posedge rst or posedge clk) begin
    if(rst) begin
        datavalid_reg <= 1'b0;
        needs_invert <= 1'b0;
        invert_sync <= 1'b0;
    end else begin
        datavalid_reg <= datavalid;
        needs_invert <= needs_invert_nxt & ~datavalid_negedge;
        invert_sync <= invert_sync_nxt;
    end
end

assign sync_out = sync_in ^ invert_sync_nxt;

endmodule
