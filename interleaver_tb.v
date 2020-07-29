module interleaver_tb();

reg clk;

wire [11:0] seq_out;
wire [11:0] encode_wr_addr;
wire [11:0] encode_rd_addr;
wire [11:0] encode_out;
wire [11:0] error_out;
wire [11:0] decode_wr_addr;
wire [11:0] decode_rd_addr;
wire [11:0] decode_out;
wire check_out;

initial  clk  = 1;
always #5 clk = ~clk;

interleaver  inter(
		.clk(clk),
		.seq_out(seq_out),
		.encode_wr_addr(encode_wr_addr),
		.encode_rd_addr(encode_rd_addr),
		.encode_out(encode_out),
		.error_out(error_out),
		.decode_wr_addr(decode_wr_addr),
		.decode_rd_addr(decode_rd_addr),
		.decode_out(decode_out),
		.check_out(check_out)
		);

endmodule
