`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: HKUST
// Engineer: Charles JIANG
// 
// Create Date: 11.10.2018 23:13:10
// Design Name: 
// Module Name: 
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`include "define.vh"

module param_calc_testbench (
    parameter DATA_WIDTH_BIT = 512,
    parameter DATA_WIDTH_BYTE = 64
)();

localparam CLK_PERIOD   = 5.0;
localparam RST_TIME     = CLK_PERIOD * 3;

// signal lists ------------------------------------------------------------------
reg   clk, rst_n, done;
reg   [DATA_WIDTH_BIT-1:0]   data_a, data_b;
wire  [DATA_WIDTH_BIT-1:0]   data_out;

// clock and reset ---------------------------------------------------------------
initial begin
  clk = 0;
  forever #(CLK_PERIOD/2.0) clk = ~clk;
end

// reset profile
initial begin 
    rst_n = 0;
    done  = 0;
    #RST_TIME rst_n = 1;
end

// testbench --------------------------------------------------------------------
initial begin
    wait(rst_n == 1'b1); #CLK_PERIOD; @(posedge clk);







    #(CLK_PERIOD*10) @(posedge clk);
    done = 1'b1;
end

// display information -------------------------------------------------------
initial begin
    done = 0;
    wait(done == 1'b1); #CLK_PERIOD; @(negedge clk);
    $display("result after scaling is: ");
    for(i=0;i<8;i=i+1) begin
        $display("%f ",out_w[i]/2^15);
    end
    $display("\n");
    $finish;
end

// instantiation -----------------------------------------------------------------
top top_dut(
    .clk      (clk),
    .rst_n    (rst_n),
    .data_a   (data_a),
    .data_b   (data_b),
    .data_out (data_out)
);

endmodule
