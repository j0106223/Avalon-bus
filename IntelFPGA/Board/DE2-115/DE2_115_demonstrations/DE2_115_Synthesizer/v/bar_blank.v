module bar_blank(
input [11:0]CounterY,
output Hu4,
output Hu2,
output Hu1,
output Mu6,
output Mu5,
output Mu4,
output Mu2,
output Mu1,
output Lu6,
output Lu5,
output Lu4
);

wire [11:0]bydeta=30;
wire [11:0]byd_t =bydeta+2;

assign Hu4=((CounterY>=(15+byd_t*0)) && ( CounterY<=(15+byd_t*1)))?1:0;//+4
assign Hu2=((CounterY>=(15+byd_t*2)) && ( CounterY<=(15+byd_t*3)))?1:0;//+2
assign Hu1=((CounterY>=(15+byd_t*3)) && ( CounterY<=(15+byd_t*4)))?1:0;//+1
assign Mu6=((CounterY>=(15+byd_t*5)) && ( CounterY<=(15+byd_t*6)))?1:0;//6
assign Mu5=((CounterY>=(15+byd_t*6)) && ( CounterY<=(15+byd_t*7)))?1:0;//5
assign Mu4=((CounterY>=(15+byd_t*7)) && ( CounterY<=(15+byd_t*8)))?1:0;//4
assign Mu2=((CounterY>=(15+byd_t*9)) && ( CounterY<=(15+byd_t*10)))?1:0;//2
assign Mu1=((CounterY>=(15+byd_t*10)) &&( CounterY<=(15+byd_t*11)))?1:0;//1
assign Lu6=((CounterY>=(15+byd_t*12)) &&( CounterY<=(15+byd_t*13)))?1:0;//-6
assign Lu5=((CounterY>=(15+byd_t*13)) &&( CounterY<=(15+byd_t*14)))?1:0;//-5
assign Lu4=((CounterY>=(15+byd_t*14)) &&( CounterY<=(15+byd_t*15)))?1:0;//-4

endmodule