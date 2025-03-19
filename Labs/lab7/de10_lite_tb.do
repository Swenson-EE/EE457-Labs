vlib work
vcom -2008 gen_counter.vhd
# Add any additional files here 

vcom -2008 TickGen.vhd
vcom -2008 ResetSynchronizer.vhd
vcom -2008 InputSynchronizer.vhd
vcom -2008 AnyEdgeDetector.vhd

vcom -2008 LED.vhd
vcom -2008 WasherTypes.vhd

vcom WasherStateMachine.vhd


# Testing files
vcom -2008 Testing_AnyEdge.vhd


vcom -2008 de10_lite_base.vhd 
vcom -2008 de10_lite_tb.vhd


 
# Default simulation
vsim -t ns work.de10_lite_tb


view wave
do wave.do
run 100000 ns