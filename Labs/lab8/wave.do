onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -r /de10_lite_tb/dut/*

add wave -noupdate /de10_lite_tb/dut/hex0
add wave -noupdate /de10_lite_tb/dut/hex1
add wave -noupdate /de10_lite_tb/dut/hex2
add wave -noupdate /de10_lite_tb/dut/hex3
add wave -noupdate /de10_lite_tb/dut/hex4
add wave -noupdate /de10_lite_tb/dut/hex5
add wave -noupdate /de10_lite_tb/dut/key(0)
add wave -noupdate /de10_lite_tb/dut/key(1)

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 260
configure wave -valuecolwidth 100
configure wave -justifyvalue right
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
# WaveRestoreZoom {18271 ns} {35307 ns}
