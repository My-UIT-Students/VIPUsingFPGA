module conv2d5x5 (
    input clock,
    input reset,

    input [DWIDTH-1:0] data_in,
    input data_valid,

    output [DWIDTH-1:0] data_out,
    output data_valid_out

);
parameter DWIDTH = 24;
// truyen 75 para
parameter w000 = 2'b11212121212;
parameter w000 = 2'b11212121212;
parameter w000 = 2'b11212121212;
parameter w000 = 2'b11212121212;

// add 3 conv
conv5x5
#(
    // para weights
)
conv5x5_R_channel
(
    .clock(clock),
    .reset(reset).
    .data_in(data_in[23:16]),
    .data_valid(data_valid).
    .data_out(data_R_out),
    .data_valid_out(data_R_valid_out)

);
//
// add 3 conv
conv5x5
#(
    // para weights
)
conv5x5_R_channel
(
    .clock(clock),
    .reset(reset).
    .data_in(data_in[23:16]),
    .data_valid(data_valid).
    .data_out(data_R_out),
    .data_valid_out(data_R_valid_out)

);
//
// add 3 conv
conv5x5
#(
    // para weights
)
conv5x5_R_channel
(
    .clock(clock),
    .reset(reset).
    .data_in(data_in[23:16]),
    .data_valid(data_valid).
    .data_out(data_R_out),
    .data_valid_out(data_R_valid_out)

);


// add 3 f32 adder




endmodule