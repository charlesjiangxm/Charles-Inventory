################################################################################
# Filename: divider.constraints.tcl
# Author: ZHU Jingyang
# Email: jzhuak@connect.ust.hk
# Affiliation: Hong Kong University of Science and Technology
# -------------------------------------------------------------------------------
# This is the template constraint script for ELEC5160/EESM5020.
################################################################################

################################################################################
# Reg2reg constraint
################################################################################
# main clock
create_clock -period 98.000 -name clk -waveform {0.000 49.000} [get_ports clk]

# divided clock
create_generated_clock \
  -name gen_clk \
  -divide_by 48 \
  -source clk \
  [get_pins clk_div_inst/clk_out]

# clock transition
set_clock_transition 1 [get_clocks clk]
set_clock_uncertainty 1 [get_clocks clk]
set_propagated_clock [get_clocks clk]

################################################################################
# I/O Constraints
################################################################################
# create a virtual clock
create_clock -name vclk -period 98.000 -waveform {0.000 49.000}

# Input delay and output delay
set_input_delay -max 10.0 -clock vclk [remove_from_collection [all_inputs] [get_ports clk]]
set_output_delay -max 10.0 -clock vclk [all_outputs]

# Set driving stregth, e.g. 0.01 means rising and falling transition delay of all
# inputs are 0.01ns
# set_drive [expr 0.1] [all_inputs]

# Capacitance - set capacitive load on the output ports, e.g. 0.02 means 20fF
set_load [expr 0.05] [all_outputs]

# Input transition time on all inputs except clock
set_input_transition 1 [remove_from_collection [all_inputs] [get_ports clk]]
