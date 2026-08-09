create_clock \
-name clk \
-period 10 \
-waveform {0 5} \
[get_ports clk]

set_clock_transition 0.1 [get_clocks clk]
set_clock_uncertainty 0.05 [get_clocks clk]

set_input_delay 1.0 \
-clock clk \
[get_ports {
start
a11 a12 a13
a21 a22 a23
a31 a32 a33
b11 b12 b13
b21 b22 b23
b31 b32 b33
}]

set_output_delay 1.0 \
-clock clk \
[get_ports {
c11 c12 c13
c21 c22 c23
c31 c32 c33
done
}]