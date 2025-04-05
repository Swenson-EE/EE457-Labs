vlib work
vcom -2008 gen_counter.vhd
# Add any additional files here 

vcom -2008 CommonTypes.vhd

vcom -2008 InputSynchronizer.vhd
vcom -2008 ResetSynchronizer.vhd
vcom -2008 RisingEdgeDetector.vhd

vcom -2008 SevenSegment.vhd

vcom -2008 ram1port.vhd
vcom -2008 RamDisplay.vhd



vcom -2008 de10_lite_base.vhd 
vcom -2008 de10_lite_tb.vhd 
vsim -t ns work.de10_lite_tb
view wave
do wave.do
run 100000 ns