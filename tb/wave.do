onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top_tb/DUT/clk_i
add wave -noupdate /top_tb/DUT/en_i
add wave -noupdate /top_tb/DUT/rst_i
add wave -noupdate /top_tb/DUT/data_o
add wave -noupdate /top_tb/DUT/de_o
add wave -noupdate /top_tb/DUT/hsync_o
add wave -noupdate /top_tb/DUT/vsync_o
add wave -noupdate /top_tb/DUT/r_pix_value_cnt
add wave -noupdate /top_tb/DUT/g_pix_value_cnt
add wave -noupdate /top_tb/DUT/b_pix_value_cnt
add wave -noupdate /top_tb/DUT/data
add wave -noupdate /top_tb/DUT/de
add wave -noupdate /top_tb/DUT/de_enable
add wave -noupdate /top_tb/DUT/hsync
add wave -noupdate -radix unsigned /top_tb/DUT/hsync_cnt
add wave -noupdate /top_tb/DUT/hsync_end_stb
add wave -noupdate /top_tb/DUT/hsync_start_stb
add wave -noupdate /top_tb/DUT/vsync
add wave -noupdate -radix unsigned /top_tb/DUT/vsync_cnt
add wave -noupdate /top_tb/DUT/vsync_end
add wave -noupdate /top_tb/DUT/vsync_start
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {15 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {390 ns} {404 ns}
