`timescale 1ns / 1ps
// ------------------------------------------------------------------------------------------------
// Projects: LDPC Derate Matching
// Creation: Charles
// Creation Date: 8/14 2018
// Version: v1.0
// Content:
//      Create the file
// ------------------------------------------------------------------------------------------------
`include "define.vh"

module one_hot_enc(
    input   wire    [`D_WIDTH_LOG2-1:0] decimal_in,
    output  wire    [`DATA_WIDTH-1:0]   one_hot_out
    );
    
for(genvar i=0; i<`DATA_WIDTH; i=i+1) begin: one_hot_encode
    assign one_hot_out[i] = (decimal_in == i) ? 1'b1 : 1'b0;
end
    
endmodule
