module ImageGenerator (
    clock,
    reset,
  
    width,
    height,
    num_frame,
    media_type,
    // fifo write bus
    fifo_full,
    fifo_data,
    fifo_wrreq
);
// paramenters
parameter DWIDTH = 24;
parameter input_file = "/home/ryan/Documents/ce234/VIPUsingFPGA/OpenIP/tools/data/images/golang.png.txt";
//

//portmap
input clock;
input reset;
input fifo_full;

output [DWIDTH-1:0] fifo_data;
output reg fifo_wrreq;
output reg [10:0] width, height,num_frame;
output reg media_type;

integer file_in;

parameter READ_CFG_STATE = 0;
parameter WR_DATA_STATE = 1;
//
reg [15:0] pixel_cnt, frame_counter;

reg [DWIDTH-1:0] data_read;
reg [1:0] state;

//
assign fifo_data = data_read;
initial begin
  file_in <= $fopen(input_file,"r"); // Read image file    
end 
//
reg [7:0] data_r;
reg [7:0] data_g;
reg [7:0] data_b;

always @(posedge clock or posedge reset) begin
  if (reset) begin
      state <= 0;
  end
  else begin
      case (state)
          READ_CFG_STATE:
          begin
              $fscanf(file_in,"%d",media_type); // 0: video, 1: image
              $fscanf(file_in,"%d",width);
              $fscanf(file_in,"%d",height);
              $fscanf(file_in,"%d",num_frame);
              $display("width=%d",width);
              $display("height=%d",height);
              $display("num_frame=%d",num_frame);
              $display("Read cfg done");
              pixel_cnt <= 0;
              frame_counter <= 0;
              state <= WR_DATA_STATE;
              pixel_cnt <= 1;
              fifo_wrreq <= 0;
              data_read <= 0;
          end
          WR_DATA_STATE:
          begin
                pixel_cnt <= pixel_cnt + 1;

                // data_read <= pixel_cnt; 
                $fscanf(file_in,"%d",data_r);
                $fscanf(file_in,"%d",data_g);
                $fscanf(file_in,"%d",data_b);
                data_read <= {data_r,data_g,data_b};

                // $display("pixel_cnt=%d",pixel_cnt);
                fifo_wrreq <= 1;
                if (pixel_cnt == width * height) begin
                    frame_counter <=  frame_counter +1;
                    pixel_cnt <= 0;
                    $display("start frame=%d",frame_counter);
                    if (frame_counter == num_frame) begin
                        $display("end frame");
                        // $finish;
                    end
                end                
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