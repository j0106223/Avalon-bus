
module  bar(
input [11:0]CounterY,
output L_5,
output L_6,
output L_7,
output M_1,
output M_2,
output M_3,
output M_4,
output M_5,
output M_6,
output M_7,
output H_1,
output H_2,
output H_3,
output H_4,
output H_5
);

wire [11:0]ydeta=30;
wire [11:0]yd_t =ydeta+2;
assign L_5= ((CounterY>=(yd_t*0)) && ( CounterY<=(yd_t*1)) )?1:0;
assign L_6= ((CounterY>=(yd_t*1)) && ( CounterY<=(yd_t*2)) )?1:0;  
assign L_7= ((CounterY>=(yd_t*2)) && ( CounterY<=(yd_t*3)) )?1:0;  
assign M_1= ((CounterY>=(yd_t*3)) && ( CounterY<=(yd_t*4)) )?1:0;  
assign M_2= ((CounterY>=(yd_t*4)) && ( CounterY<=(yd_t*5)) )?1:0;  
assign M_3= ((CounterY>=(yd_t*5)) && ( CounterY<=(yd_t*6)) )?1:0;  
assign M_4= ((CounterY>=(yd_t*6)) && ( CounterY<=(yd_t*7)) )?1:0;  
assign M_5= ((CounterY>=(yd_t*7)) && ( CounterY<=(yd_t*8)) )?1:0;  
assign M_6= ((CounterY>=(yd_t*8)) && ( CounterY<=(yd_t*9)) )?1:0;  
assign M_7= ((CounterY>=(yd_t*9)) && ( CounterY<=(yd_t*10)) )?1:0;  
assign H_1= ((CounterY>=(yd_t*10)) && ( CounterY<=(yd_t*11)) )?1:0;  
assign H_2= ((CounterY>=(yd_t*11)) && ( CounterY<=(yd_t*12)) )?1:0;  
assign H_3= ((CounterY>=(yd_t*12)) && ( CounterY<=(yd_t*13)) )?1:0;  
assign H_4= ((CounterY>=(yd_t*13)) && ( CounterY<=(yd_t*14)) )?1:0;  
assign H_5= ((CounterY>=(yd_t*14)) && ( CounterY<=(yd_t*15)) )?1:0;  

endmodule