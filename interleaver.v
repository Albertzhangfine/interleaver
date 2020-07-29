
module interleaver(clk,seq_out,encode_wr_addr,encode_rd_addr,encode_out,error_out,decode_wr_addr,decode_rd_addr,decode_out,check_out);

input clk;
output [11:0] seq_out;
output [11:0] encode_wr_addr;
output [11:0] encode_rd_addr;
output [11:0] encode_out;

output [11:0] error_out;

output [11:0] decode_wr_addr;
output [11:0] decode_rd_addr;
output [11:0] decode_out;

output check_out;

seq_gen seq_gen(
		          .clk(clk),
		          .seq_out(seq_out)	
		          );
 
encode_addr_creat encode_addr(
	         	               .clk(clk),
		                        .wr_addr(encode_wr_addr),
		                        .rd_addr(encode_rd_addr)
		                        );

ram_2048 ram_2048_1(
	                 .clk(clk),
	                 .data_in(seq_out),
	                 .wr_addr(encode_wr_addr),
	                 .rd_addr(encode_rd_addr),
	                 .data_out(encode_out)
	                 );
error_gen error_gen(
			.clk(clk),
			.data_in(encode_out),
			.data_out(error_out)
			);
			
decode_addr_creat decode_addr(
	                         	.clk(clk),
		                        .wr_addr(decode_wr_addr),
		                        .rd_addr(decode_rd_addr)
		                        );

ram_2048 ram_2048_2(
	                 .clk(clk),
	                 .data_in(error_out),
	                 .wr_addr(decode_wr_addr),
	                 .rd_addr(decode_rd_addr),
	                 .data_out(decode_out)
	                 );
						  
error_check error_check(
							.clk(clk),
							.data_in(decode_out),
							.check_out(check_out)
							);

endmodule


module seq_gen(clk,seq_out);

input clk;
output [11:0] seq_out;
reg [11:0] seq_out;
initial seq_out='d0;

always@(posedge clk)
begin
	if(seq_out =='d280)
		seq_out <='d1;
	else
		seq_out <=seq_out +1;
end
endmodule  

//encode address creat
//wr_addr:write address
//rd_addr:read address
//clk:clock
module encode_addr_creat(clk,wr_addr,rd_addr);

input clk;
output [11:0] wr_addr;
output [11:0] rd_addr;

reg [3:0] count ;
reg [10:0] count_num;
reg [10:0]bi;
reg [10:0]bn;
reg [10:0]an;
reg [10:0]ai;
reg [10:0] a1;
reg [10:0] a2;
reg [10:0] a3;
reg [10:0] a4;
reg [10:0] a5;
reg [10:0] a6;
reg [10:0] a7;
reg [10:0] row;
reg [10:0] column;

initial count=1;
initial count_num=0;
initial a1=0;
initial a2=0;
initial a3=0;
initial a4=0;
initial a5=0;
initial a6=0;
initial a7=0;
initial row=0;
initial column=0;

//always@(posedge clk)
//begin
	//if(count==6'd7)
	//	count<=1;
//end

always@(posedge clk)
begin
	case (count)
		'd1 : begin bi<='d1;bn<='d0;          //第一通道
				 if(a1=='d40) begin
				 count<=2;
				 a1<='d0;
				 end
				 else begin
				 a1<=a1+1;
				 ai<=a1;
				 end
				 
				 end    
		'd2 : begin bi<='d2;bn<='d35;        //第二通道
             if(a2=='d40)begin
				 count<=3;
				 a2<='d0;
				 end
             else begin
				 a2<=a2+1;	
				 ai<=a2;
				 end
				 
             end
		'd3 : begin bi<='d3;bn<='d77;        //第三通道
             if(a3=='d40) begin
				 count<=4;
				 a3<='d0;
				 end 
             else begin
				 a3<=a3+1;
				 ai<=a3;
				 end
				 
             end	
		'd4 : begin bi<='d4;bn<='d119;       //第四通道
             if(a4=='d40) begin
				 count<=5;
				 a4<='d0;
				 end 
             else begin
				 a4<=a4+1;
				 ai<=a4;
             end
				 end
		'd5 : begin bi<='d5;bn<='d154;       //第五通道
             if(a5=='d40) begin
				 count<=6;
				 a5<='d0;
				 end 
             else begin
				 a5<=a5+1;
				 ai<=a5;
             end
				 end
		'd6 : begin bi<='d6;bn<='d196;      //第六通道
             if(a6=='d40) begin
				 count<=7;
				 a6<='d0;
				 end 
             else begin
				 a6<=a6+1;
				 ai<=a6;
             end
				 
				 end
		'd7 : begin bi<='d7;bn<='d238;      //第七通道
             if(a7=='d40) begin
				 count<=1;
				 a7<='d0;
				 end 
             else begin
				 a7<=a7+1; 
				 ai<=a7;
             end
				 end
	endcase
	
	
	
	if(count_num<279)
		count_num<=count_num+1;
	else
		count_num<=0;
	
	
	an=count_num;
	
	
//	an<=(bi-1)*40+ai;
	
	
//	if(count_num=='d41)begin
//		an <='d39;end
//	if(count_num=='d81)begin
//		an <='d79;end
//	if(count_num=='d121)begin
//		an <='d119;end
//	if(count_num=='d161)begin
//		an <='d159;end
//	if(count_num=='d201)begin
//		an <='d199;end
//	if(count_num=='d241)begin
//		an <='d239;end
//	if(count_num=='d280)begin
//		an <='d279;end
	
	 
		 if(an<'d7) begin
		 row='d0;
		 column=an;end
		 if(an<'d14&&an>='d7)begin
		 row='d1;
		 column=an-row*7;end
		 if(an<'d21&&an>='d14)begin
		 row='d2;
		 column=an-row*7;end
		 if(an<'d28&&an>='d21)begin
		 row='d3;
		 column=an-row*7;end
		 if(an<'d35&&an>='d28)begin
		 row='d4;
		 column=an-row*7;end
		 if(an<'d42&&an>='d35)begin
		 row='d5;
		 column=an-row*7;end
		 if(an<'d49&&an>='d42)begin
		 row='d6;
		 column=an-row*7;end
		 if(an<'d56&&an>='d49)begin
		 row='d7;
		 column=an-row*7;end
		 if(an<'d63&&an>='d56)begin
		 row='d8;
		 column=an-row*7;end
		 if(an<'d70&&an>='d63)begin
		 row='d9;
		 column=an-row*7;end
		 if(an<'d77&&an>='d70)begin
		 row='d10;
		 column=an-row*7;end
		 if(an<'d84&&an>='d77)begin
		 row='d11;
		 column=an-row*7;end
		 if(an<'d91&&an>='d84)begin
		 row='d12;
		 column=an-row*7;end
		 if(an<'d98&&an>='d91)begin
		 row='d13;
		 column=an-row*7;end
		 if(an<'d105&&an>='d98)begin
		 row='d14;
		 column=an-row*7;end
		 if(an<'d112&&an>='d105)begin
		 row='d15;
		 column=an-row*7;end
		 if(an<'d119&&an>='d112)begin
		 row='d16;
		 column=an-row*7;end
		 if(an<'d126&&an>='d119)begin
		 row='d17;
		 column=an-row*7;end
		 if(an<'d133&&an>='d126)begin
		 row='d18;
		 column=an-row*7;end
		 if(an<'d140&&an>='d133)begin
		 row='d19;
		 column=an-row*7;end
		 if(an<'d147&&an>='d140)begin
		 row='d20;
		 column=an-row*7;end
		 if(an<'d154&&an>='d147)begin
		 row='d21;
		 column=an-row*7;end
		 if(an<'d161&&an>='d154)begin
		 row='d22;
		 column=an-row*7;end
		 if(an<'d168&&an>='d161)begin
		 row='d23;
		 column=an-row*7;end
		 if(an<'d175&&an>='d168)begin
		 row='d24;
		 column=an-row*7;end
		 if(an<'d182&&an>='d175)begin
		 row='d25;
		 column=an-row*7;end
		 if(an<'d189&&an>='d182)begin
		 row='d26;
		 column=an-row*7;end
		 if(an<'d196&&an>='d189)begin
		 row='d27;
		 column=an-row*7;end
		 if(an<'d1203&&an>='d196)begin
		 row='d28;
		 column=an-row*7;end
		 if(an<'d210&&an>='d203)begin
		 row='d29;
		 column=an-row*7;end
		 if(an<'d217&&an>='d210)begin
		 row='d30;
		 column=an-row*7;end
		 if(an<'d224&&an>='d217)begin
		 row='d31;
		 column=an-row*7;end
		 if(an<'d231&&an>='d224)begin
		 row='d32;
		 column=an-row*7;end
		 if(an<'d238&&an>='d231)begin
		 row='d33;
		 column=an-row*7;end
		 if(an<'d245&&an>='d238)begin
		 row='d34;
		 column=an-row*7;end
		 if(an<'d252&&an>='d245)begin
		 row='d35;
		 column=an-row*7;end
		 if(an<'d259&&an>='d252)begin
		 row='d36;
		 column=an-row*7;end
		 if(an<'d266&&an>='d259)begin
		 row='d37;
		 column=an-row*7;end
		 if(an<'d273&&an>='d266)begin
		 row='d38;
		 column=an-row*7;end
		 if(an>='d273)begin
		 row='d39;
		 column=an-row*7;end
	
end

assign wr_addr=an;

assign rd_addr=column*40+row;

endmodule  


module ram_2048(clk,data_in,wr_addr,rd_addr,data_out);

input clk;
input [11:0] data_in;
input [11:0] wr_addr;
input [11:0] rd_addr;
output [11:0] data_out;

reg [11:0] wr_addr_t;
reg [11:0] mem [2047:0]; 
reg [11:0] data_out;

always@(posedge clk)
begin

	if(wr_addr==rd_addr)
		data_out <=data_in;
	else
	   begin
      mem[wr_addr]<=data_in;
		data_out <=mem[rd_addr];	
	   end
end
endmodule





module error_gen(clk,data_in,data_out);
input clk;
input [11:0] data_in;

//reg [11:0] data;
output [11:0] data_out;

reg [10:0] count_num;
reg [11:0] data_out;
initial count_num=0;
always@(posedge clk)
begin
	if(count_num<279)
		count_num<=count_num+1;
	else
		count_num<=0;
	
	if (count_num>10&&count_num<=20)
	    data_out<=data_in+'d300;
	 else
		 data_out<=data_in;
		 

end
endmodule  




module error_check(clk,data_in,check_out);

input clk;
input [11:0] data_in;

//reg [11:0] data;
output check_out;

reg check_out;
initial check_out=0;

always@(posedge clk)
begin
	if(data_in>280)
		check_out<='d1;
	else
		check_out<='d0;
	
end

endmodule  





//wr_addr:write address
//rd_addr:read address
//clk:clock

module decode_addr_creat(clk,wr_addr,rd_addr);

input clk;
output [11:0] wr_addr;
output [11:0] rd_addr;

reg [3:0] count;
reg [10:0] count_num;
reg [10:0] bi;
reg [10:0] an;
reg [10:0] ai;
reg [10:0] a1;
reg [10:0] a2;
reg [10:0] a3;
reg [10:0] a4;
reg [10:0] a5;
reg [10:0] a6;
reg [10:0] a7;
reg [10:0] row;
reg [10:0] column;


initial count=1;
initial count_num=0;
initial a1=0;
initial a2=0;
initial a3=0;
initial a4=0;
initial a5=0;
initial a6=0;
initial a7=0;
initial row=0;
initial column=0;

//always@(posedge clk)
//begin
//	if(count==4'd7)
//		count<=1;
//  else
//		count<=count+1;
//end

always@(posedge clk)
begin
//	case(count)
//		4'd1 :begin bi<='d7; an<=8'd241;     //第七通道
//             if(a1=='d39) begin
//				 count<=2;
//				 a1<='d0;
//				 end 
//             else begin
//				 a1<=a1+1; 
//				 ai<=a1;
//             end
//				 end
//		4'd2 : begin bi<='d6; an<=8'd201;      //第六通道
//             if(a2=='d39) begin
//				 count<=3;
//				 a2<='d0;
//				 end 
//             else begin
//				 a2<=a2+1;
//				 ai<=a2;
//             end
//				 end
//		4'd3 : begin bi<='d5; an<=8'd161;      //第五通道
//             if(a3=='d39) begin
//				 count<=4;
//				 a3<='d0;
//				 end 
//             else begin
//				 a3<=a3+1;
//				 ai<=a3;
//             end
//				 end
//		4'd4 : begin bi<='d4; an<=8'd121;      //第四通道
//             if(a4=='d39) begin
//				 count<=5;
//				 a4<='d0;
//				 end 
//             else begin
//				 a4<=a4+1;
//				 ai<=a4;
//             end
//				 end
//		4'd5 : begin bi<='d3; an<=8'd81;       //第三通道
//             if(a5=='d39) begin
//				 count<=6;
//				 a5<='d0;
//				 end 
//             else begin
//				 a5<=a5+1;
//				 ai<=a5;
//				 end
//             end	
//		4'd6 : begin bi<='d2;an<=8'd41;        //第二通道
//             if(a6=='d39)begin
//				 count<=7;
//				 a6<='d0;
//				 end
//             else begin
//				 a6<=a6+1;	
//				 ai<=a6;
//				 end
//             end
//		4'd7 : begin bi<='d1; an<='d1;         //第一通道
//				 if(a7=='d39) begin
//				 count<=1;
//				 a7<='d0;
//				 end
//				 else begin
//				 a7<=a7+1;
//				 ai<=a7;
//				 end
//				 end 
//	endcase


	if(count_num<279)
		count_num<=count_num+1;
	else
		count_num<=0;

	an=count_num;

	
	 if(an<'d7) begin
		 row='d0;
		 column=an;end
		 if(an<'d14&&an>='d7)begin
		 row='d1;
		 column=an-row*7;end
		 if(an<'d21&&an>='d14)begin
		 row='d2;
		 column=an-row*7;end
		 if(an<'d28&&an>='d21)begin
		 row='d3;
		 column=an-row*7;end
		 if(an<'d35&&an>='d28)begin
		 row='d4;
		 column=an-row*7;end
		 if(an<'d42&&an>='d35)begin
		 row='d5;
		 column=an-row*7;end
		 if(an<'d49&&an>='d42)begin
		 row='d6;
		 column=an-row*7;end
		 if(an<'d56&&an>='d49)begin
		 row='d7;
		 column=an-row*7;end
		 if(an<'d63&&an>='d56)begin
		 row='d8;
		 column=an-row*7;end
		 if(an<'d70&&an>='d63)begin
		 row='d9;
		 column=an-row*7;end
		 if(an<'d77&&an>='d70)begin
		 row='d10;
		 column=an-row*7;end
		 if(an<'d84&&an>='d77)begin
		 row='d11;
		 column=an-row*7;end
		 if(an<'d91&&an>='d84)begin
		 row='d12;
		 column=an-row*7;end
		 if(an<'d98&&an>='d91)begin
		 row='d13;
		 column=an-row*7;end
		 if(an<'d105&&an>='d98)begin
		 row='d14;
		 column=an-row*7;end
		 if(an<'d112&&an>='d105)begin
		 row='d15;
		 column=an-row*7;end
		 if(an<'d119&&an>='d112)begin
		 row='d16;
		 column=an-row*7;end
		 if(an<'d126&&an>='d119)begin
		 row='d17;
		 column=an-row*7;end
		 if(an<'d133&&an>='d126)begin
		 row='d18;
		 column=an-row*7;end
		 if(an<'d140&&an>='d133)begin
		 row='d19;
		 column=an-row*7;end
		 if(an<'d147&&an>='d140)begin
		 row='d20;
		 column=an-row*7;end
		 if(an<'d154&&an>='d147)begin
		 row='d21;
		 column=an-row*7;end
		 if(an<'d161&&an>='d154)begin
		 row='d22;
		 column=an-row*7;end
		 if(an<'d168&&an>='d161)begin
		 row='d23;
		 column=an-row*7;end
		 if(an<'d175&&an>='d168)begin
		 row='d24;
		 column=an-row*7;end
		 if(an<'d182&&an>='d175)begin
		 row='d25;
		 column=an-row*7;end
		 if(an<'d189&&an>='d182)begin
		 row='d26;
		 column=an-row*7;end
		 if(an<'d196&&an>='d189)begin
		 row='d27;
		 column=an-row*7;end
		 if(an<'d1203&&an>='d196)begin
		 row='d28;
		 column=an-row*7;end
		 if(an<'d210&&an>='d203)begin
		 row='d29;
		 column=an-row*7;end
		 if(an<'d217&&an>='d210)begin
		 row='d30;
		 column=an-row*7;end
		 if(an<'d224&&an>='d217)begin
		 row='d31;
		 column=an-row*7;end
		 if(an<'d231&&an>='d224)begin
		 row='d32;
		 column=an-row*7;end
		 if(an<'d238&&an>='d231)begin
		 row='d33;
		 column=an-row*7;end
		 if(an<'d245&&an>='d238)begin
		 row='d34;
		 column=an-row*7;end
		 if(an<'d252&&an>='d245)begin
		 row='d35;
		 column=an-row*7;end
		 if(an<'d259&&an>='d252)begin
		 row='d36;
		 column=an-row*7;end
		 if(an<'d266&&an>='d259)begin
		 row='d37;
		 column=an-row*7;end
		 if(an<'d273&&an>='d266)begin
		 row='d38;
		 column=an-row*7;end
		 if(an>='d273)begin
		 row='d39;
		 column=an-row*7;end


end

assign wr_addr=column*40+row;
assign rd_addr=an;

endmodule  