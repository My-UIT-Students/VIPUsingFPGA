
module top_tb;

parameter DWIDTH = 24;

reg clock;
reg reset;
/*------------- clock generator --------------------*/
initial begin
    #5 clock =1;
    #1 forever #1 clock = !clock;
end
/*---------------- RESET --------------------------*/
initial begin
  #4 reset = 0;
  #5 reset = 1;
  #8 reset = 0;  
end
//

wire [DWIDTH-1:0] data_in;
wire data_wrreq;
wire data_full;
//
wire [DWIDTH-1:0] data_out;
wire data_rdreq;
wire data_empty;

// DATA GENERATOR / READ AND TEXT IMAGE FILE
ImageGenerator image_read_inst (
    .clock(clock),
    .reset(reset),
    // fifo write bu(te bu)s
    .fifo_full(data_full),
    .fifo_data(data_in),
    .fifo_wrreq(data_wrreq)
   
);
//
vip_top vip_ins(
    .clock(clock),
    .reset(reset),
    //
    .fifo_in_data  (data_in),
    .fifo_in_wrreq (data_wrreq), 
    .fifo_in_full  (data_full),  
    //
    .fifo_out_data  (data_out),     
    .fifo_out_rdreq (data_rdreq),    
    .fifo_out_empty (data_empty)
);
//
// ImageGenerator image_read_inst
ImageWriter #(.DWIDTH(DWIDTH)) ImageWriter_inst  (
    .clock(clock),
    .reset(reset),    
    .fifo_rdreq(data_rdreq),
    .fifo_data(data_out),
    .fifo_empty(data_empty)
);
endmodule