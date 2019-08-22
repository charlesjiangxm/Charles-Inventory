# This is a contraint file for synthesize sequential circuit
# -fall is for falling edge, we're not synchrnous on the failling edge, so no need for it
# by default, set_input_delay means rising edge

# sequantial logic
create_clock -period 5.000 -name clk -waveform {0.000 2.500} [get_ports clk]
set_input_delay -clock clk -add_delay  -max -rise 0.1 [get_ports * -filter {DIRECTION == IN && NAME !~ "clk"}]
set_input_delay -clock clk -add_delay -min -rise 0.1 [get_ports * -filter {DIRECTION == IN && NAME !~ "clk"}]

# combinational logic
create_clock -name "vclk" -period 5.000 -waveform {0.000 2.500}
set_input_delay -clock vclk -add_delay  -max -rise 0.1  [get_ports * -filter {DIRECTION == IN}]
set_input_delay -clock vclk -add_delay -min -rise 0.1   [get_ports * -filter {DIRECTION == IN}]

