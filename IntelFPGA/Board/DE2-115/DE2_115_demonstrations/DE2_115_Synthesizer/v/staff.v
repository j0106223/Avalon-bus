module staff(
	input VGA_CLK,
	input [7:0]scan_code1,
	input [7:0]scan_code2,
	input [7:0]scan_code3,
	input [7:0]scan_code4,
	output vga_sync,	
	output vga_h_sync,
	output vga_v_sync,
	output inDisplayArea,	
	output vga_R,
	output vga_G, 
	output vga_B,
	output [15:0]sound1,
	output [15:0]sound2,
	output [15:0]sound3,
	output [15:0]sound4,
	output sound_off1,
	output sound_off2,
	output sound_off3,
	output sound_off4
);
	assign  vga_sync=1;	

//////SoundOff Key///////
	assign sound_off1=(scan_code1==8'hf0)?0:1;
	assign sound_off2=(scan_code2==8'hf0)?0:1;
	assign sound_off3=(scan_code3==8'hf0)?0:1;
	assign sound_off4=(scan_code4==8'hf0)?0:1;

///////640X480 VGA-Timing-generater///////

	wire [11:0] CounterX;
	wire [11:0] CounterY;
	vga_time_generator vga0(
		.pixel_clk(VGA_CLK),
		.h_disp   (640),
		.h_fporch (16),
		.h_sync   (96), 
		.h_bporch (48),
		.v_disp   (480),
		.v_fporch (10),
		.v_sync   (2),
		.v_bporch (33),
		.vga_hs   (vga_h_sync),
		.vga_vs   (vga_v_sync),
		.vga_blank(inDisplayArea),
		.CounterY(CounterY),
		.CounterX(CounterX) 
	);

/////////Channel-1 Trigger////////
	wire L_5_tr=(scan_code1==8'h1c)?1:0;//-5
	wire L_6_tr=(scan_code1==8'h1b)?1:0;//-6		
	wire L_7_tr=(scan_code1==8'h23)?1:0;//-7		
	wire M_1_tr=(scan_code1==8'h2b)?1:0;//1		
	wire M_2_tr=(scan_code1==8'h34)?1:0;//2		
	wire M_3_tr=(scan_code1==8'h33)?1:0;//3		
	wire M_4_tr=(scan_code1==8'h3b)?1:0;//4		
	wire M_5_tr=(scan_code1==8'h42)?1:0;//5		
	wire M_6_tr=(scan_code1==8'h4b)?1:0;//6		
	wire M_7_tr=(scan_code1==8'h4c)?1:0;//7		
	wire H_1_tr=(scan_code1==8'h52)?1:0;//+1		
	wire H_2_tr=0;//+2
	wire H_3_tr=0;//+3
	wire H_4_tr=0;//+4
	wire H_5_tr=0;//+5
	wire Hu4_tr=0;//((!get_gate) && (scan_code==8'h15))?1:0;//+#4
	wire Hu2_tr=0;//((!get_gate) && (scan_code==8'h1d))?1:0;//+#2
	wire Hu1_tr=(scan_code1==8'h5b)?1:0;//+#1
	wire Mu6_tr=(scan_code1==8'h4d)?1:0;//#6
	wire Mu5_tr=(scan_code1==8'h44)?1:0;//#5
	wire Mu4_tr=(scan_code1==8'h43)?1:0;//#4
	wire Mu2_tr=(scan_code1==8'h35)?1:0;//#2
	wire Mu1_tr=(scan_code1==8'h2c)?1:0;//#1
	wire Lu6_tr=(scan_code1==8'h24)?1:0;//-#6
	wire Lu5_tr=(scan_code1==8'h1d)?1:0;//-#5
	wire Lu4_tr=(scan_code1==8'h15)?1:0;//-#4

	assign sound1=(    //channel-1 frequency
		(Lu4_tr)?400  :(
		(L_5_tr)?423  :(
		(Lu5_tr)?448  :(
		(L_6_tr)?475  :(
		(Lu6_tr)?503  :(
		(L_7_tr)?533  :(
		(M_1_tr)?565  :(
		(Mu1_tr)?599  :(
		(M_2_tr)?634  :(
		(Mu2_tr)?672  :(
		(M_3_tr)?712  :(
		(M_4_tr)?755  :(
		(Mu4_tr)?800  :(
		(M_5_tr)?847  :(
		(Mu5_tr)?897  :(
		(M_6_tr)?951  :(
		(Mu6_tr)?1007 :(
		(M_7_tr)?1067 :(
		(H_1_tr)?1131 :(
		(Hu1_tr)?1198 :1
		)))))))))))))))))))
	);

/////////Channel-2 Trigger////////
	wire L2_5_tr=(scan_code2==8'h1c)?1:0;//-5
	wire L2_6_tr=(scan_code2==8'h1b)?1:0;//-6		
	wire L2_7_tr=(scan_code2==8'h23)?1:0;//-7		
	wire M2_1_tr=(scan_code2==8'h2b)?1:0;//1		
	wire M2_2_tr=(scan_code2==8'h34)?1:0;//2		
	wire M2_3_tr=(scan_code2==8'h33)?1:0;//3		
	wire M2_4_tr=(scan_code2==8'h3b)?1:0;//4		
	wire M2_5_tr=(scan_code2==8'h42)?1:0;//5		
	wire M2_6_tr=(scan_code2==8'h4b)?1:0;//6		
	wire M2_7_tr=(scan_code2==8'h4c)?1:0;//7		
	wire H2_1_tr=(scan_code2==8'h52)?1:0;//+1		
	wire H2_2_tr=0;//+2
	wire H2_3_tr=0;//+3
	wire H2_4_tr=0;//+4
	wire H2_5_tr=0;//+5
	wire H2u4_tr=0;//((!get_gate) && (scan_code==8'h15))?1:0;//+#4
	wire H2u2_tr=0;//((!get_gate) && (scan_code==8'h1d))?1:0;//+#2
	wire H2u1_tr=(scan_code2==8'h5b)?1:0;//+#1
	wire M2u6_tr=(scan_code2==8'h4d)?1:0;//#6
	wire M2u5_tr=(scan_code2==8'h44)?1:0;//#5
	wire M2u4_tr=(scan_code2==8'h43)?1:0;//#4
	wire M2u2_tr=(scan_code2==8'h35)?1:0;//#2
	wire M2u1_tr=(scan_code2==8'h2c)?1:0;//#1
	wire L2u6_tr=(scan_code2==8'h24)?1:0;//-#6
	wire L2u5_tr=(scan_code2==8'h1d)?1:0;//-#5
	wire L2u4_tr=(scan_code2==8'h15)?1:0;//-#4

	assign sound2=(     //channel-2 frequency
		(L2u4_tr)?400  :(
		(L2_5_tr)?423  :(
		(L2u5_tr)?448  :(
		(L2_6_tr)?475  :(
		(L2u6_tr)?503  :(
		(L2_7_tr)?533  :(
		(M2_1_tr)?565  :(
		(M2u1_tr)?599  :(
		(M2_2_tr)?634  :(
		(M2u2_tr)?672  :(
		(M2_3_tr)?712  :(
		(M2_4_tr)?755  :(
		(M2u4_tr)?800  :(
		(M2_5_tr)?847  :(
		(M2u5_tr)?897  :(
		(M2_6_tr)?951  :(
		(M2u6_tr)?1007 :(
		(M2_7_tr)?1067 :(
		(H2_1_tr)?1131 :(
		(H2u1_tr)?1198 :1
		)))))))))))))))))))
	);

/////////Channel-3 Trigger////////
	wire L3_5_tr=(scan_code3==8'h1c)?1:0;//-5
	wire L3_6_tr=(scan_code3==8'h1b)?1:0;//-6		
	wire L3_7_tr=(scan_code3==8'h23)?1:0;//-7		
	wire M3_1_tr=(scan_code3==8'h2b)?1:0;//1		
	wire M3_2_tr=(scan_code3==8'h34)?1:0;//2		
	wire M3_3_tr=(scan_code3==8'h33)?1:0;//3		
	wire M3_4_tr=(scan_code3==8'h3b)?1:0;//4		
	wire M3_5_tr=(scan_code3==8'h42)?1:0;//5		
	wire M3_6_tr=(scan_code3==8'h4b)?1:0;//6		
	wire M3_7_tr=(scan_code3==8'h4c)?1:0;//7		
	wire H3_1_tr=(scan_code3==8'h52)?1:0;//+1		
	wire H3_2_tr=0;//+2
	wire H3_3_tr=0;//+3
	wire H3_4_tr=0;//+4
	wire H3_5_tr=0;//+5
	wire H3u4_tr=0;//((!get_gate) && (scan_code==8'h15))?1:0;//+#4
	wire H3u2_tr=0;//((!get_gate) && (scan_code==8'h1d))?1:0;//+#2
	wire H3u1_tr=(scan_code3==8'h5b)?1:0;//+#1
	wire M3u6_tr=(scan_code3==8'h4d)?1:0;//#6
	wire M3u5_tr=(scan_code3==8'h44)?1:0;//#5
	wire M3u4_tr=(scan_code3==8'h43)?1:0;//#4
	wire M3u2_tr=(scan_code3==8'h35)?1:0;//#2
	wire M3u1_tr=(scan_code3==8'h2c)?1:0;//#1
	wire L3u6_tr=(scan_code3==8'h24)?1:0;//-#6
	wire L3u5_tr=(scan_code3==8'h1d)?1:0;//-#5
	wire L3u4_tr=(scan_code3==8'h15)?1:0;//-#4

	assign sound3=(		//channel-3 frequency
		(L3u4_tr)?400  :(
		(L3_5_tr)?423  :(
		(L3u5_tr)?448  :(
		(L3_6_tr)?475  :(
		(L3u6_tr)?503  :(
		(L3_7_tr)?533  :(
		(M3_1_tr)?565  :(
		(M3u1_tr)?599  :(
		(M3_2_tr)?634  :(
		(M3u2_tr)?672  :(
		(M3_3_tr)?712  :(
		(M3_4_tr)?755  :(
		(M3u4_tr)?800  :(
		(M3_5_tr)?847  :(
		(M3u5_tr)?897  :(
		(M3_6_tr)?951  :(
		(M3u6_tr)?1007 :(
		(M3_7_tr)?1067 :(
		(H3_1_tr)?1131 :(
		(H3u1_tr)?1198 :1
		)))))))))))))))))))
	);

/////////Channel-4 Trigger////////
	wire L4_5_tr=(scan_code4==8'h1c)?1:0;//-5
	wire L4_6_tr=(scan_code4==8'h1b)?1:0;//-6		
	wire L4_7_tr=(scan_code4==8'h23)?1:0;//-7		
	wire M4_1_tr=(scan_code4==8'h2b)?1:0;//1		
	wire M4_2_tr=(scan_code4==8'h34)?1:0;//2		
	wire M4_3_tr=(scan_code4==8'h33)?1:0;//3		
	wire M4_4_tr=(scan_code4==8'h3b)?1:0;//4		
	wire M4_5_tr=(scan_code4==8'h42)?1:0;//5		
	wire M4_6_tr=(scan_code4==8'h4b)?1:0;//6		
	wire M4_7_tr=(scan_code4==8'h4c)?1:0;//7		
	wire H4_1_tr=(scan_code4==8'h52)?1:0;//+1		
	wire H4_2_tr=0;//+2
	wire H4_3_tr=0;//+3
	wire H4_4_tr=0;//+4
	wire H4_5_tr=0;//+5
	wire H4u4_tr=0;//((!get_gate) && (scan_code==8'h15))?1:0;//+#4
	wire H4u2_tr=0;//((!get_gate) && (scan_code==8'h1d))?1:0;//+#2
	wire H4u1_tr=(scan_code4==8'h5b)?1:0;//+#1
	wire M4u6_tr=(scan_code4==8'h4d)?1:0;//#6
	wire M4u5_tr=(scan_code4==8'h44)?1:0;//#5
	wire M4u4_tr=(scan_code4==8'h43)?1:0;//#4
	wire M4u2_tr=(scan_code4==8'h35)?1:0;//#2
	wire M4u1_tr=(scan_code4==8'h2c)?1:0;//#1
	wire L4u6_tr=(scan_code4==8'h24)?1:0;//-#6
	wire L4u5_tr=(scan_code4==8'h1d)?1:0;//-#5
	wire L4u4_tr=(scan_code4==8'h15)?1:0;//-#4

	assign sound4=(  //channel-4 frequency
		(L3u4_tr)?400  :(
		(L3_5_tr)?423  :(
		(L3u5_tr)?448  :(
		(L3_6_tr)?475  :(
		(L3u6_tr)?503  :(
		(L3_7_tr)?533  :(
		(M3_1_tr)?565  :(
		(M3u1_tr)?599  :(
		(M3_2_tr)?634  :(
		(M3u2_tr)?672  :(
		(M3_3_tr)?712  :(
		(M3_4_tr)?755  :(
		(M3u4_tr)?800  :(
		(M3_5_tr)?847  :(
		(M3u5_tr)?897  :(
		(M3_6_tr)?951  :(
		(M3u6_tr)?1007 :(
		(M3_7_tr)?1067 :(
		(H3_1_tr)?1131 :(
		(H3u1_tr)?1198 :1
		)))))))))))))))))))
	);

///////////White Key///////////
	wire L_5;
	wire L_6;
	wire L_7;
	wire M_1;
	wire M_2;
	wire M_3;
	wire M_4;
	wire M_5;
	wire M_6;
	wire M_7;
	wire H_1;
	wire H_2;
	wire H_3;
	wire H_4;
	wire H_5;
	bar_white bar1(
 		.CounterY(CounterY),
 		.L_5(L_5),
 		.L_6(L_6),
 		.L_7(L_7),
 		.M_1(M_1),
 		.M_2(M_2),
 		.M_3(M_3),
 		.M_4(M_4),
 		.M_5(M_5),
 		.M_6(M_6),
 		.M_7(M_7),
 		.H_1(H_1),
 		.H_2(H_2),
 		.H_3(H_3),
 		.H_4(H_4),
 		.H_5(H_5)
	);
	wire [11:0]ydeta=30;
	wire [11:0]yd_t =ydeta+2;
	wire [11:0]y_org=(
		(H_5)?yd_t*0:( //+5
		(H_4)?yd_t*1:( //+4
		(H_3)?yd_t*2:( //+3
		(H_2)?yd_t*3:( //+2
		(H_1)?yd_t*4:( //+1
		(M_7)?yd_t*5:( //7
		(M_6)?yd_t*6:( //6
		(M_5)?yd_t*7:( //5
		(M_4)?yd_t*8:( //4
		(M_3)?yd_t*9:( //3
		(M_2)?yd_t*10:(//2
		(M_1)?yd_t*11:(//1
		(L_7)?yd_t*12:(//-7
		(L_6)?yd_t*13:(//-6
		(L_5)?yd_t*14:yd_t*14//-5		
		))))))))))))))
	);

/////////White-key play////////
	wire [11:0]white_x=(
		((L4_5_tr|L3_5_tr|L2_5_tr|L_5_tr)&&(L_5))?110:(
		((L4_6_tr|L3_6_tr|L2_6_tr|L_6_tr)&&(L_6))?110:(
		((L4_7_tr|L3_7_tr|L2_7_tr|L_7_tr)&&(L_7))?110:(
		((M4_1_tr|M3_1_tr|M2_1_tr|M_1_tr)&&(M_1))?110:(
		((M4_2_tr|M3_2_tr|M2_2_tr|M_2_tr)&&(M_2))?110:(
		((M4_3_tr|M3_3_tr|M2_3_tr|M_3_tr)&&(M_3))?110:(
		((M4_4_tr|M3_4_tr|M2_4_tr|M_4_tr)&&(M_4))?110:(
		((M4_5_tr|M3_5_tr|M2_5_tr|M_5_tr)&&(M_5))?110:(
		((M4_6_tr|M3_6_tr|M2_6_tr|M_6_tr)&&(M_6))?110:(
		((M4_7_tr|M3_7_tr|M2_7_tr|M_7_tr)&&(M_7))?110:(
		((H4_1_tr|H3_1_tr|H2_1_tr|H_1_tr)&&(H_1))?110:(
		((H4_2_tr|H3_2_tr|H2_2_tr|H_2_tr)&&(H_2))?110:(
		((H4_3_tr|H3_3_tr|H2_3_tr|H_3_tr)&&(H_3))?110:(
		((H4_4_tr|H3_4_tr|H2_4_tr|H_4_tr)&&(H_4))?110:(	
		((H4_5_tr|H3_5_tr|H2_5_tr|H_5_tr)&&(H_5))?110:100
		))))))))))))))
	);	

////////White-key display//////				
	wire white_bar;
	bar_big b0(
		.org_y(y_org),
		.bar_space(white_bar),
		.org_x(0),
		.x(CounterX),
		.y(CounterY),
		.line_x(white_x),
		.line_y(ydeta)
	);


////////Blank key/////////
	wire Hu4;
	wire Hu2;
	wire Hu1;
	wire Mu6;
	wire Mu5;
	wire Mu4;
	wire Mu2;
	wire Mu1;
	wire Lu6;
	wire Lu5;
	wire Lu4;
	bar_blank bar_blank1(
		.CounterY(CounterY),
		.Hu4(Hu4),
		.Hu2(Hu2),
		.Hu1(Hu1),
		.Mu6(Mu6),
		.Mu5(Mu5),
		.Mu4(Mu4),
		.Mu2(Mu2),
		.Mu1(Mu1),
		.Lu6(Lu6),
		.Lu5(Lu5),
		.Lu4(Lu4)
	);
	wire [11:0]bydeta=30;
	wire [11:0]byd_t =bydeta+2;
	wire [11:0]by_org=(
		(Hu4)?15+byd_t*0:( //+5
		(Hu2)?15+byd_t*2:( //+3
		(Hu1)?15+byd_t*3:( //+2
		(Mu6)?15+byd_t*5:( //7
		(Mu5)?15+byd_t*6:( //6
		(Mu4)?15+byd_t*7:( //5
		(Mu2)?15+byd_t*9:( //3
		(Mu1)?15+byd_t*10:(//2
		(Lu6)?15+byd_t*12:(//-7
		(Lu5)?15+byd_t*13:(//-6
		(Lu4)?15+byd_t*14:15+byd_t*14//-5
		))))))))))
		);
		
/////////Blank-key play////////
	wire [11:0] blank_x	=(
		((H4u4_tr|H3u4_tr|H2u4_tr|Hu4_tr)&&(Hu4))?60:(
		((H4u2_tr|H3u2_tr|H2u2_tr|Hu2_tr)&&(Hu2))?60:(		
		((H4u1_tr|H3u1_tr|H2u1_tr|Hu1_tr)&&(Hu1))?60:(		
		((M4u6_tr|M3u6_tr|M2u6_tr|Mu6_tr)&&(Mu6))?60:(		
		((M4u5_tr|M3u5_tr|M2u5_tr|Mu5_tr)&&(Mu5))?60:(		
		((M4u4_tr|M3u4_tr|M2u4_tr|Mu4_tr)&&(Mu4))?60:(		
		((M4u2_tr|M3u2_tr|M2u2_tr|Mu2_tr)&&(Mu2))?60:(		
		((M4u1_tr|M3u1_tr|M2u1_tr|Mu1_tr)&&(Mu1))?60:(		
		((L4u6_tr|L3u6_tr|L2u6_tr|Lu6_tr)&&(Lu6))?60:(		
		((L4u5_tr|L3u5_tr|L2u5_tr|Lu5_tr)&&(Lu5))?60:(		
		((L4u4_tr|L3u4_tr|L2u4_tr|Lu4_tr)&&(Lu4))?60:50
		))))))))))
	);	
			
////////Blank-key display//////
	wire blank_bar;
	bar_big b2(
		.org_y(by_org),
		.bar_space(blank_bar),
		.org_x(0),
		.x(CounterX),
		.y(CounterY),
		.line_x(blank_x),
		.line_y(ydeta)
	);

/////////VGA data out///////
	wire bar_key =~blank_bar &  white_bar;
	assign	vga_R = bar_key & inDisplayArea;
	assign	vga_G = bar_key & inDisplayArea;
	assign	vga_B = bar_key & inDisplayArea;

endmodule