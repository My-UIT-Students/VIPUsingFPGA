onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /top_tb/image_read_inst/clock
add wave -noupdate -radix unsigned /top_tb/image_read_inst/reset
add wave -noupdate -radix unsigned /top_tb/image_read_inst/fifo_full
add wave -noupdate -radix unsigned /top_tb/image_read_inst/fifo_data
add wave -noupdate -radix unsigned /top_tb/image_read_inst/fifo_wrreq
add wave -noupdate -radix unsigned /top_tb/image_read_inst/file_in
add wave -noupdate -radix unsigned /top_tb/image_read_inst/pixel_cnt
add wave -noupdate -radix unsigned /top_tb/image_read_inst/frame_counter
add wave -noupdate -radix unsigned /top_tb/image_read_inst/width
add wave -noupdate -radix unsigned /top_tb/image_read_inst/height
add wave -noupdate -radix unsigned /top_tb/image_read_inst/num_frame
add wave -noupdate -radix unsigned /top_tb/image_read_inst/data_read
add wave -noupdate -radix unsigned /top_tb/image_read_inst/media_type
add wave -noupdate -radix unsigned /top_tb/image_read_inst/state
add wave -noupdate -radix unsigned /top_tb/image_read_inst/data_r
add wave -noupdate -radix unsigned /top_tb/image_read_inst/data_g
add wave -noupdate -radix unsigned /top_tb/image_read_inst/data_b
add wave -noupdate -radix unsigned /top_tb/ImageWriter_inst/clock
add wave -noupdate -radix unsigned /top_tb/ImageWriter_inst/reset
add wave -noupdate -radix unsigned /top_tb/ImageWriter_inst/fifo_rdreq
add wave -noupdate -radix unsigned /top_tb/ImageWriter_inst/fifo_data
add wave -noupdate -radix unsigned /top_tb/ImageWriter_inst/fifo_empty
add wave -noupdate -radix unsigned /top_tb/ImageWriter_inst/data
add wave -noupdate -radix unsigned /top_tb/ImageWriter_inst/data_valid
add wave -noupdate -radix unsigned /top_tb/ImageWriter_inst/file_output
add wave -noupdate -radix unsigned /top_tb/ImageWriter_inst/pixel_cnt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {20 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {16 ps} {48 ps}
