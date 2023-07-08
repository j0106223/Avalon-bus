module CY7C67200_IF(	//	HOST Side
					iDATA,
					oDATA,
					iADDR,           //for HPI register selection  
					iRD_N,
					iWR_N,
					iCS_N,
					iRST_N,
					iCLK,
					oINT,
					//	CY7C67200 Side
//					OTG_ID,          //HPI mode selection(host or peripheral)
					HPI_DATA,
					HPI_ADDR,
					HPI_RD_N,
					HPI_WR_N,
					HPI_CS_N,
					HPI_RST_N,
					HPI_INT
//					I2C_SCL,         //I2C interface
//					I2C_SDA
			   	);
//=====================================
//             PORT Declaration
//=====================================					
//	HOST Side
input        [31:0]  	iDATA;  //input data from nios 
input	       [1:0]	   iADDR;  //address for sel for HPI interface
input			            iRD_N;  //read enable
input		               iWR_N;  //write enable
input			            iCS_N;  //chip sel
input			            iRST_N; //reset 
input			            iCLK;   //clk
output       [31:0]   	oDATA;  //read data from EZO
output		    	      oINT;   //

//	ISP1362 Side
//output                  OTG_ID;
inout      	[15:0]   	HPI_DATA;
output   	[1:0]	      HPI_ADDR;
output		        	   HPI_RD_N;
output			         HPI_WR_N;
output			         HPI_CS_N;
output			         HPI_RST_N;
input			            HPI_INT;
//output                        I2C_SCL;
//inout                         I2C_SDA;
//=====================================
//             reg/wire Declaration
//=====================================	
//wire	    	[1:0]	      HPI_ADDR;
//wire				         HPI_RD_N;
//wire				         HPI_WR_N;
//wire				         HPI_CS_N;
//wire		  [15:0]       TMP_DATA;
//wire	     [15:0]       oDATA;
//wire				         oINT;




assign	HPI_DATA	=	(iRST_N & ~HPI_CS_N & ~HPI_WR_N & HPI_RD_N)	?	iDATA[15:0] : 16'hzzzz;
assign	oDATA	   =	{16'h0000, HPI_DATA};

assign	oINT 			=	HPI_INT;
assign	HPI_ADDR 	=	iADDR;
assign	HPI_RD_N 	=	iRD_N;
assign	HPI_WR_N		=	iWR_N;
assign	HPI_CS_N		=	iCS_N;
assign	HPI_RST_N	=	iRST_N;


//always@(posedge iCLK or negedge iRST_N)
//begin
//	if(!iRST_N)
//	begin
//		TMP_DATA	<=	0;
//		HPI_ADDR	<=	0;
//		HPI_RD_N	<=	1;
//		HPI_WR_N	<=	1;
//		HPI_CS_N	<=	1;
//		TMP_DATA	<=	0;
//		oDATA		<=	0;
//		oINT	   <=	0;
//	end
//	else
//	begin
//		oDATA		<=	{16'h0000,HPI_DATA};
//		oINT 		<=	HPI_INT;
//
//		TMP_DATA	<=	iDATA[15:0];
//		HPI_ADDR 	<=	iADDR[1:0];
//		HPI_RD_N 	<=	iRD_N;
//		HPI_WR_N	<=	iWR_N;
//		HPI_CS_N	<=	iCS_N;
//	end
//end


endmodule

