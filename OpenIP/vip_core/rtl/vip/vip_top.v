module vip_top (
    clock,
    reset,
    //
    fifo_in_data  ,
    fifo_in_wrreq , 
    fifo_in_full  ,  
    //
    fifo_out_data  ,     
    fifo_out_rdreq ,    
    fifo_out_empty 
);
parameter DWIDTH = 24;
parameter DEPTH_WIDTH = 64;
//
input    clock;
input    reset;
    //
input [DWIDTH-1:0]	fifo_in_data;
input               fifo_in_wrreq;
output              fifo_in_full;  
//
output [DWIDTH-1:0] fifo_out_data  ;     
input    						fifo_out_rdreq ;  
output    					fifo_out_empty;
//------------------------------------------------------------------
wire [DWIDTH-1:0] data_din;
wire 							data_in_empty;
wire 							data_rdreq;
//------- write result to FIFO-----------------------------
wire [DWIDTH-1:0] data_out;
wire 							data_out_full;
wire 							data_out_wrreq;
//
fifo_24b fifo_in_inst(
	.clock(clock),
	.data(fifo_in_data),
	.wrreq(fifo_in_wrreq),
	.full(fifo_in_full),	

	.rdreq(data_rdreq),
	.empty(data_in_empty),
	.q(data_din)

	);
//
core core_inst(
    .clock(clock),
    .reset(reset),
    // FIFO READ
    .ff_rdata(data_din),
    .ff_rdreq(data_rdreq),
    .ff_empty(data_in_empty),
    // FIFO WRITE
    .ff_wdata(data_out),
    .ff_wrreq(data_out_wrreq),
    .ff_full(data_out_full)
);
//
fifo_24b fifo_out_inst(
	.clock(clock),
	
	.data(data_out),
	.wrreq(data_out_wrreq),
	.full(data_out_full),

	.rdreq(fifo_out_rdreq),	
	.empty(fifo_out_empty),
	.q(fifo_out_data)
	);
endmodule
