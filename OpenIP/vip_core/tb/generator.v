module ImageGenerator (
    clock,
    reset,
    // fifo write bus
    fifo_full,
    fifo_data,
    fifo_wrreq
);
// paramenters
parameter DWIDTH = 24;
parameter input_file = "../resources/images/lena.txt";
//

//portmap
input clock;
input reset;

input fifo_full;
output [DWIDTH-1:0] fifo_data;

output reg fifo_wrreq;
integer file_in;

parameter READ_CFG_STATE = 0;
parameter WR_DATA_STATE = 1;
//
reg [15:0] pixel_cnt;
reg [10:0] width, height;
reg [DWIDTH-1:0] data_read;
reg [1:0] state;
//
assign fifo_data = data_read;
initial begin
  file_in <= $fopen(input_file,"r"); // Read image file    
end 
//
always @(posedge clock or posedge reset) begin
  if (reset) begin
      state <= 0;
  end
  else begin
      case (state)
          READ_CFG_STATE:
          begin
              $fscanf(file_in,"%d",width);
              $fscanf(file_in,"%d",height);
              $display("Read cfg done");
              state <= WR_DATA_STATE;
              pixel_cnt <= 1;
              fifo_wrreq <= 0;
              data_read <= 0;
          end
          WR_DATA_STATE:
          begin
                pixel_cnt <= pixel_cnt + 1;
                data_read <= pixel_cnt;
                fifo_wrreq <= 1;
                // $display("Read data");
          end
          default:
          begin
              $display("finishd");
          end 
      endcase

  end
end

endmodule