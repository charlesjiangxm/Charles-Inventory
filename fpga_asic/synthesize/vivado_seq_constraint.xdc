# This is a contraint file for synthesize sequential circuit

create_clock -period 4.000 -name clk -waveform {0.000 2.000} [get_ports clk]

# -fall is for falling edge, we're not synchrnous on the failling edge, so no need for it
# by default, set_input_delay means rising edge
set_input_delay -clock clk -add_delay  -max -rise 0.1 [all_inputs]
#set_input_delay -clock clk -add_delay -max -fall 0.2 [all_inputs]
set_input_delay -clock clk -add_delay -min -rise 0.1 [all_inputs]
#set_input_delay -clock clk -add_delay  -min -fall 0.5 [all_inputs]

# no need for setting up the output delay for report setup and hold slack
#set_output_delay -clock clk -add_delay  -max -rise 0.5 [all_outputs]
#set_output_delay -clock clk -add_delay -max -fall 0.5 [all_outputs]
#set_output_delay -clock clk -add_delay -min -rise 0.5 [all_outputs]
#set_output_delay -clock clk -add_delay  -min -fall 0.5 [all_outputs]
