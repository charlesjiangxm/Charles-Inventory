// ---------------------------------------------------
// Description: General Purpose testbench
// ---------------------------------------------------
`timescale 1 ns / 1 ps
module testbench;

// Modify your clk period here, unit: ns
localparam CLK_PERIOD = 1;

// Modify your parameters here
parameter		N = 4;

// Modify your ports here
reg				clk;          // system clock
reg				rst_n;          // system reset
reg	[N-1:0]		request;      // request
wire [N-1:0]	grant;         // grant
	
RoundRobinArbiter #(
	.N		(4)
) uut
(
	.clk			(clk),           
	.rst_n			(rst_n),            
	.request		(request),
	.grant			(grant)
);

// CLk initial block
initial begin
	clk = 1'b0;
	forever #(CLK_PERIOD/2.0) begin
	clk = ~clk;
	end
end

// rst_n initial block
initial begin
	rst_n = 1'b1;
	#(CLK_PERIOD*3);
	rst_n = 1'b0;
end

// data initial block
initial begin
	request = 3'd0;
	# 100
	request = 3'd1;
	# 100
	request = 3'd2;
	# 100
	request = 3'd3;
	# 100
	request = 3'd4;	
	# 100
	request = 3'd5;
	# 100
	request = 3'd6;
	# 100
	request = 3'd7;
	$stop;
end

endmodule
