vlib work
# Add any additional files here 

vcom -2008 Types.vhd


vcom -2008 TickGen.vhd
vcom -2008 ResetSynchronizer.vhd
vcom -2008 InputSynchronizer.vhd
vcom -2008 BitMover.vhd
vcom -2008 SnakeDraw.vhd


vcom -2008 de10_lite_base.vhd 
vcom -2008 de10_lite_tb.vhd 

vsim -t ns work.de10_lite_tb
view wave
do wave.do
run 10000 ns