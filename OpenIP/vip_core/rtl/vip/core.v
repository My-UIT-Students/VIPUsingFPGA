module core (
    clock,
    reset,
    // FIFO READ
    ff_rdata,
    ff_rdreq,
    ff_empty,
    // FIFO WRITE
    ff_wdata,
    ff_wrreq,
    ff_full
);
//
parameter DWIDTH = 24;
//
input   clock;
input   reset;
// FIFO READ
input [DWIDTH-1:0] ff_rdata;
output reg   ff_rdreq;
input ff_empty;
// FIFO WRITE
output [DWIDTH-1:0]   ff_wdata;
output              ff_wrreq;
input               ff_full;
//
wire start;
assign start = (ff_empty == 0 && ff_full==0);

reg data_valid_in;
//
reg [DWIDTH-1:0]    data_out;
reg data_valid_out;
//

// assign ff_rdreq = start;
assign ff_wdata = data_out;
assign ff_wrreq = data_valid_out;

always @(posedge clock or posedge reset) begin
    if(reset) begin
        ff_rdreq <= 1'b0;
    end
    else begin
        ff_rdreq <= start;
    end
end

always @(posedge clock or posedge reset) begin
    if(reset) begin
        data_valid_in <= 1'b0;     
    end
    else begin
        if (ff_rdreq==1) begin
            data_valid_in <= 1'b1;
        end
        else begin
            data_valid_in <= 1'b0;
        end

    end
end
// Example for 1 clk
always @(posedge clock or posedge reset) begin
    if(reset) begin
        data_out <= {DWIDTH{1'b0}};
        data_valid_out <= 1'b0;     
    end
    else begin
        if(data_valid_in) begin
            data_out <= ff_rdata;
            data_valid_out <= 1'b1;
        end
        else begin
            data_valid_out <= 1'b0;
        end
    end
end

endmodule