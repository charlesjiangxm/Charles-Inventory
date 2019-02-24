# This is a contraint file for synthesize sequential circuit
# -fall is for falling edge, we're not synchrnous on the failling edge, so no need for it
# by default, set_input_delay means rising edge

# sequantial logic
create_clock -period 4.000 -name clk -waveform {0.000 2.000} [get_ports clk]
set_input_delay -clock clk -add_delay  -max -rise 0.1 [all_inputs]
set_input_delay -clock clk -add_delay -min -rise 0.05 [all_inputs]

# combinational logic
create_clock -name "vclk" -period 4 -waveform { 2 4  }
set_input_delay -clock vclk -add_delay  -max -rise 0.  [all_inputs]
set_input_delay -clock vclk -add_delay -min -rise 0   [all_inputs]


