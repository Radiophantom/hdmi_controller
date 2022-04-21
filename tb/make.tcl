vlib work

vlog -sv ../hdmi_controller.sv \
         ../hdmi_controller_pkg.sv \
         top_tb.sv

vopt +acc -o top_tb_opt top_tb

vsim top_tb_opt

do wave.do

run -all
