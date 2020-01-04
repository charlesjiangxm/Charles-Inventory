module mem_wiring #(
    parameter   IN_WIDTH     = 32,  
    parameter   OUT_WIDTH    = 256
) (
    input   wire  [`DATA_WIDTH*IN_WIDTH-1:0]            in_data,
    output  wire  [`DATA_WIDTH*OUT_WIDTH-1:0]           out_data
    );

genvar g;

wire    [`DATA_WIDTH-1:0]   in_data_w       [IN_WIDTH-1:0];
wire    [`DATA_WIDTH-1:0]   out_data_w      [OUT_WIDTH-1:0];

// vector to mem
for (g = 0; g < IN_WIDTH; g = g + 1) begin: wire_w
    assign in_data_w[g] = in_data[`DATA_WIDTH*(g) +: `DATA_WIDTH];
end

// mem to vector
for (g = 0; g < OUT_WIDTH; g = g + 1) begin: wire_output
    assign out_data[`DATA_WIDTH*(g) +: `DATA_WIDTH] = out_data_w[g];
end

endmodule 