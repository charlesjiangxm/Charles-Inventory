# This is a contraint file for synthesize sequential circuit

create_clock -period 4.000 -name clk -waveform {0.000 2.000} [get_ports clk]

set_input_delay -clock clk -add_delay  -max -rise 0.1 [all_inputs]
#set_input_delay -clock clk -add_delay -max -fall 0.2 [all_inputs]
set_input_delay -clock clk -add_delay -min -rise 0.1 [all_inputs]
#set_input_delay -clock clk -add_delay  -min -fall 0.5 [all_inputs]

#set_output_delay -clock clk -add_delay  -max -rise 0.5 [all_outputs]
#set_output_delay -clock clk -add_delay -max -fall 0.5 [all_outputs]
#set_output_delay -clock clk -add_delay -min -rise 0.5 [all_outputs]
#set_output_delay -clock clk -add_delay  -min -fall 0.5 [all_outputs]
