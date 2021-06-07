module featuremap0 (
    input clock,
    input reset,

    input [DWIDTH-1:0] data_in,
    input data_valid,

    output [DWIDTH-1:0] data_out,
    output data_valid_out
);

conv2d5x5 #(
    .w000(),
) 
conv2d5x5_ist
(
    .clock(clock),
    .reset(reset).
    .data_in(data_in),
    .data_valid(data_valid).
    .data_out(data_out),
    .data_valid_out(data_valid_out)

);

endmodule