module bar_big(
input [11:0]x,
input [11:0]y,

input [11:0]org_x,
input [11:0]org_y,
input [11:0]line_x,
input [11:0]line_y,
output bar_space
);

assign bar_space=(
(x>=org_x) && (x<=(org_x+line_x)) &&
(y>=org_y) && (y<=(org_y+line_y)) 
)?1:0;


endmodule