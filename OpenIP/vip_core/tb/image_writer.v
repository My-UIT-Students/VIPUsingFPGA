module ImageWriter (
    clock,
    reset,
    
    fifo_rdreq,
    fifo_data,
    fifo_empty
);
parameter DWIDTH = 8;
parameter output_file = "../resource/image/output.txt`";
input    clock;
input    reset;
    
output  reg  fifo_rdreq;
input [DWIDTH-1:0]    fifo_data;
input fifo_empty;

reg [DWIDTH-1:0] data;
reg data_valid;

always @(posedge clock or posedge reset) begin
    if(reset) begin
        data_valid <= 1'b0;   
        fifo_rdreq <= 0;  
    end
    else begin
        if (fifo_empty==0) begin
            fifo_rdreq <= 1'b1;
        end
        else begin
            fifo_rdreq <= 1'b0;
        end

    end
end
// wire data to text
always @(posedge clock or posedge reset) begin
    if(reset) begin
        data <= {DWIDTH{1'b0}};         
    end
    else begin
        if(data_valid) begin
            // for write data to text
            data <= fifo_data;         
        end        
    end
end


endmodule