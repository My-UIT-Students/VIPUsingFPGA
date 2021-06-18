onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /top_tb/vip_ins/core_inst/start
add wave -noupdate -radix unsigned /top_tb/vip_ins/core_inst/clock
add wave -noupdate -radix unsigned /top_tb/vip_ins/core_inst/reset
add wave -noupdate -radix unsigned /top_tb/vip_ins/core_inst/ff_rdata
add wave -noupdate -radix unsigned /top_tb/vip_ins/core_inst/ff_rdreq
add wave -noupdate -radix unsigned /top_tb/vip_ins/core_inst/ff_empty
add wave -noupdate -radix unsigned /top_tb/vip_ins/core_inst/ff_wdata
add wave -noupdate -radix unsigned /top_tb/vip_ins/core_inst/ff_wrreq
add wave -noupdate -radix unsigned /top_tb/vip_ins/core_inst/ff_full
add wave -noupdate -radix unsigned /top_tb/vip_ins/core_inst/start
add wave -noupdate -radix unsigned /top_tb/vip_ins/core_inst/data_valid_in
add wave -noupdate -radix unsigned /top_tb/vip_ins/core_inst/data_out
add wave -noupdate -radix unsigned /top_tb/vip_ins/core_inst/data_valid_out
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
