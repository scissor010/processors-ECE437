onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate /system_tb/DUT/CPU/DP/haltff
add wave -noupdate /system_tb/DUT/RAM/ramif/ramREN
add wave -noupdate /system_tb/DUT/RAM/ramif/ramWEN
add wave -noupdate /system_tb/DUT/RAM/ramif/ramaddr
add wave -noupdate /system_tb/DUT/RAM/ramif/ramstore
add wave -noupdate /system_tb/DUT/RAM/ramif/ramload
add wave -noupdate /system_tb/DUT/RAM/ramif/ramstate
add wave -noupdate /system_tb/DUT/CPU/dcif/imemload
add wave -noupdate /system_tb/DUT/CPU/dcif/dmemREN
add wave -noupdate /system_tb/DUT/CPU/dcif/dmemWEN
add wave -noupdate /system_tb/DUT/CPU/dcif/imemREN
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/dmemstore
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/dmemaddr
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/ihit
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/dhit
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/instEN
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/PC
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/imemload
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/cu_dmemREN
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/cu_dmemWEN
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/wsel
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/wdat
add wave -noupdate /system_tb/DUT/RAM/count
add wave -noupdate /system_tb/DUT/RAM/en
add wave -noupdate /system_tb/DUT/CPU/ccif/iREN
add wave -noupdate /system_tb/DUT/CPU/ccif/dREN
add wave -noupdate /system_tb/DUT/CPU/ccif/dWEN
add wave -noupdate /system_tb/DUT/CPU/ccif/iwait
add wave -noupdate /system_tb/DUT/CPU/ccif/dwait
add wave -noupdate /system_tb/DUT/CPU/DP/regfile/data
add wave -noupdate /system_tb/DUT/CPU/CM/instr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {101707 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {29080 ps} {234880 ps}
