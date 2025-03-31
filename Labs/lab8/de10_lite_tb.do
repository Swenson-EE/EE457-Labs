vlib work
#vcom -2008 gen_counter.vhd
# Add any additional files here 
vcom -2008 CommonTypes.vhd
vcom -2008 PWM_Types.vhd

vcom -2008 ResetSynchronizer.vhd
vcom -2008 InputSynchronizer.vhd
vcom -2008 Counter.vhd
vcom -2008 TwoSpeedTickCounter.vhd

vcom -2008 PWM.vhd
vcom -2008 StateMachine.vhd








vcom -2008 de10_lite_base.vhd 
vcom -2008 de10_lite_tb.vhd 

vsim -t ns work.de10_lite_tb
view wave
do wave.do
run 1000000 ns
#run 10000 ns