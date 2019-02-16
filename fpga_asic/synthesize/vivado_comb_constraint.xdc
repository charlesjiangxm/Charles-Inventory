create_clock -name "vclk" -period 4 -waveform { 2 4  }

set_input_delay -clock vclk -add_delay  -max -rise 0  [all_inputs]
set_input_delay -clock vclk -add_delay -max -fall 0   [all_inputs]
set_input_delay -clock vclk -add_delay -min -rise 0   [all_inputs]
set_input_delay -clock vclk -add_delay  -min -fall 0  [all_inputs]

set_output_delay -clock vclk -add_delay  -max -rise 0 [all_outputs]
set_output_delay -clock vclk -add_delay -max -fall 0  [all_outputs]
set_output_delay -clock vclk -add_delay -min -rise 0  [all_outputs]
set_output_delay -clock vclk -add_delay  -min -fall 0 [all_outputs]
