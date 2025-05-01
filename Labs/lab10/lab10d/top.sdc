# Create base input clock
create_clock -name clk_in -period 10.000 clk_in

# Create virtual clocks
create_clock -name clk_in_vir -period 10.000
create_clock -name clk_out_vir -period 10.000

# Automatically create generated clocks on PLL outputs
#derive_pll_clocks

create_generated_clock -name {inst|main_pll_inst|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|vcoph[0]} -source [get_pins {inst|main_pll_inst|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|refclkin}] -duty_cycle 50/1 -multiply_by 4 -master_clock {clk_in} [get_pins {inst|main_pll_inst|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|vcoph[0]}] 
create_generated_clock -name {clk_x1} -source [get_pins {inst|main_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|vco0ph[0]}] -duty_cycle 50/1 -multiply_by 1 -divide_by 4 -master_clock {inst|main_pll_inst|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|vcoph[0]} [get_pins {inst|main_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] 
create_generated_clock -name {clk_x2} -source [get_pins {inst|main_pll_inst|altera_pll_i|general[1].gpll~PLL_OUTPUT_COUNTER|vco0ph[0]}] -duty_cycle 50/1 -multiply_by 1 -divide_by 2 -master_clock {inst|main_pll_inst|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|vcoph[0]} [get_pins {inst|main_pll_inst|altera_pll_i|general[1].gpll~PLL_OUTPUT_COUNTER|divclk}] 

# Constrain input data ports
set_input_delay -clock { clk_in_vir } -max [expr 0.7 - (-0.35) + 2.1] [get_ports {din_a* din_b* din_x* din_y*}]
set_input_delay -clock { clk_in_vir } -min [expr 0.35 - 0.35 + 0.7] [get_ports {din_a* din_b* din_x* din_y*}]

# Constrain output data ports
set_output_delay -clock { clk_out_vir } -max [expr 0.7 - (-0.35) + 1.0] [get_ports {multout_ab*}]
set_output_delay -clock { clk_out_vir } -min [expr 0.35 - 0.35 - 1.0] [get_ports {multout_ab*}]

set_output_delay -clock { clk_out_vir } -clock_fall -max [expr 0.7 - (-0.35) + 1.0] [get_ports {multout_xy*}]
set_output_delay -clock { clk_out_vir } -clock_fall -min [expr 0.35 - 0.35 - 1.0] [get_ports {multout_xy*}]

# Constrain asynchronous paths
set_false_path -from reset

# Set up multicycle paths
set_multicycle_path -from [get_registers {x_regtwo* y_regtwo*}] -setup -end 2
set_multicycle_path -from [get_registers {x_regtwo* y_regtwo*}] -hold -end 1
