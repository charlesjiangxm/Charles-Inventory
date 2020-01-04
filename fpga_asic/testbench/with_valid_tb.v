`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: HKUST
// Engineer: Charles JIANG
// 
// Create Date: 04.01.2020 10:41:12
// Design Name: 
// Module Name: with_valid_tb
// Project Name: 
// Target Devices: All
// Tool Versions: Vivado 2019.2
// Description: Valid signal needs to be assigned depends on rst_n signal. Do not
//              use initial block to assign value to it, else the timing delay 
//              will be different from the real word situation.
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module with_valid_tb;

localparam CLK_PERIOD   = 5.0;
localparam RST_TIME     = CLK_PERIOD * 7;
localparam PROCESS_TIME = CLK_PERIOD * 100;

// nets -------------------------------------------------------------------------
reg                                         clk;
reg                                         rst_n;
reg                                         valid;
wire                                        out_valid;

// clk and rst_n and valid -------------------------------------------------------
initial begin
    clk = 1;
    forever #(CLK_PERIOD/2.0) clk = ~clk;
end

initial begin
    rst_n = 0;
    #RST_TIME rst_n = 1;
end

always@(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        valid   <= 0;
    end else begin
        valid   <= 1;
    end
end

// data --------------------------------------------------------------------------
// data assignment
initial begin
    // assign initial value to data here

end

// processing time control
initial begin
    if(valid) begin
        #PROCESS_TIME;
        $finish;
    end
end

// instantiate -------------------------------------------------------------------
Instance    instance(
    .clk        (),
    .valid      (),
    .out_valid  ()
);

endmodule
