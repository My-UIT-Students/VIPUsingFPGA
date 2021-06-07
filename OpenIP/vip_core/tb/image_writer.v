module ImageWriter (
    clock,
    reset,
    
    fifo_rdreq,
    fifo_data,
    fifo_empty,

    width,
    height,
    num_frame,
    media_type
);
parameter DWIDTH = 8;
parameter output_file = "/home/ryan/Documents/ce234/VIPUsingFPGA/OpenIP/tools/data/results/output.txt";
input    clock;
input    reset;

input [10:0] width;
input [10:0] height;
input [10:0] num_frame;
input media_type;

output  reg  fifo_rdreq;
input [DWIDTH-1:0]    fifo_data;
input fifo_empty;

reg [DWIDTH-1:0] data;
reg data_valid;
integer  file_output;
reg [15:0] pixel_cnt;
reg frame_cnt;

initial begin
    file_output = $fopen(output_file,"w");
end
always @(posedge clock or posedge reset) begin
    if(reset) begin
        // data_valid <= 1'b0;   
        fifo_rdreq <= 0;  
    end
    else begin
        if (fifo_empty==0) begin
            fifo_rdreq <= 1'b1;
            data_valid <= fifo_rdreq;
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
        pixel_cnt <= 1;
        frame_cnt <= 0;
    end
    else begin
        if(data_valid) begin
            // for write data to text
            
            pixel_cnt <= pixel_cnt + 1;
            // 
            if (pixel_cnt == 1 && frame_cnt == 0) begin
                // add header file
                $fwrite(file_output,"%d\n",media_type) ; // type
                $fwrite(file_output,"%d\n",width) ; // width
                $fwrite(file_output,"%d\n",height) ; // height
                $fwrite(file_output,"%d\n",num_frame) ; // numframe
            end

            // data <= fifo_data;        
            if (pixel_cnt == 100*100) begin
                frame_cnt <= frame_cnt + 1;
                pixel_cnt <= 0;
                $display("frame %d",frame_cnt);
            end
            if (frame_cnt < num_frame) begin               
                $fwrite(file_output,"%d\n",fifo_data[23:16]) ;
                $fwrite(file_output,"%d\n",fifo_data[15:8]) ;
                $fwrite(file_output,"%d\n",fifo_data[7:0]) ;
            end
            else begin
                $fclose(file_output);
                $display("writed file done");
                $finish;
            end
        end        
    end
end


endmodule