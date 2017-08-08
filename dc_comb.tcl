# For the synthesis process from step 10 to step 30 in the design flow tutorial,
# 	you can run the following script instead of set all the steps in the GUI.
# You are required to complete the script file as shown below.
# You can use the GUI to execute each step again and find the command for each step.
# After you finish this script, please put it under 'syn' folder
# You can use 
#		dc_shell -64bit -f dc.tcl
#	to run this script to avoid the tedious work in GUI.
# PLEASE use this script wisely.
# As you need to repeat the synthesis process several times,
# 	this script will help you save huge amount of time.

suppress_message {LINT-32 LINT-33}
sh mkdir WORK
define_design_lib WORK -path ./WORK

# scripts of step 10, enter all the files excpet testbench #change here
analyze -library WORK -format sverilog {../rtl/csd.v}

# scripts of step 11, the name should be the top instance name #change here
elaborate csd -architecture verilog -library DEFAULT -update

# scripts of step 12
link

# scripts of step 13
uplevel #0 check_design

# scripts of step 14, name can be arbitrary
# You can replce "cla16" globally here, and no need for change afterwards #change here
write -hierarchy -format ddc -output ../ddc/csd.ddc

# scripts of step 15: the input rising and falling transition delay is 0.01ns
change_selection [all_inputs]
set_drive [expr 0.01] [all_inputs]

# scripts of step 16: the output loading is 20fF
change_selection [all_outputs]
set_load [expr 0.02] [all_outputs]

# scripts of step 17, if there is a clock signal in your design, please append "{clk(or the name of the clock you use)}" at the end, time unit: ns
# Combination Logif Use this:
 create_clock -name "vclk" -period 2 -waveform { 1 2  }


# scripts of step 18: set input rising and falling delay range, here is 0ns
change_selection [all_inputs]
set_input_delay -clock vclk -add_delay  -max -rise 0 [all_inputs]
set_input_delay -clock vclk -add_delay -max -fall 0 [all_inputs]
set_input_delay -clock vclk -add_delay -min -rise 0 [all_inputs]
set_input_delay -clock vclk -add_delay  -min -fall 0 [all_inputs]

# scripts of step 19: set output rising and falling delay range, here is 0.05ns for all
change_selection [all_outputs]
set_output_delay -clock vclk -add_delay  -max -rise 0.05 [all_outputs]
set_output_delay -clock vclk -add_delay -max -fall 0.05 [all_outputs]
set_output_delay -clock vclk -add_delay -min -rise 0.05 [all_outputs]
set_output_delay -clock vclk -add_delay  -min -fall 0.05 [all_outputs]

# scripts of step 20: specify wire load constraint
set_wire_load_model -name 1K_hvratio_1_2 -library NangateOpenCellLibrary

# scripts of step 21: This is to specify the design should be speed oriented, if you want it to be area oriented, type: "set_max_area 0"
# set_max_delay 0 -from [all_inputs] -to [all_outputs]

# scripts of step 22: save the constrained design, changes the name here #change here
write -hierarchy -format ddc -output ../ddc/csd_constriant.ddc 

# scripts of step 23: Synthesize
compile -extract_map
# compile_ultra -exact_map

# scripts of step 24: save the synthesized design, changes the name here #change here
write -hierarchy -format ddc -output ../ddc/csd_synthesized.ddc

# scripts of step 26
report_timing >> ../rpt/timing.rpt
report_area >> ../rpt/area.rpt
report_power >> ../rpt/power.rpt
report_clock >> ../rpt/clock.rpt

# scripts of step 27 #change here
change_names -rule vhdl -hierarchy
write -format vhdl -hierarchy -output ../net/csd.vhd

# scripts of step 28 #change here
change_names -rules verilog -hierarchy
write -format verilog -hierarchy -output ../net/csd.v

# scripts of step 29 #change here
write_sdf ../net/csd.sdf

# scripts of step 30 #change here
write_sdc ../net/csd.sdc

quit
