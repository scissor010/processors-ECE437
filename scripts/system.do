onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate /system_tb/DUT/CPU/DP/haltff
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/ramif/ramREN
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/ramif/ramWEN
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/ramif/ramaddr
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/ramif/ramstore
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/ramif/ramload
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/ramif/ramstate
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/count
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/en
add wave -noupdate -expand -group DP:ENs /system_tb/DUT/CPU/DP/rfif/instEN
add wave -noupdate -expand -group DP:ENs /system_tb/DUT/CPU/DP/rfif/ihit
add wave -noupdate -expand -group DP:ENs /system_tb/DUT/CPU/DP/rfif/dhit
add wave -noupdate -expand -group DP:ENs /system_tb/DUT/CPU/dcif/dmemREN
add wave -noupdate -expand -group DP:ENs /system_tb/DUT/CPU/dcif/dmemWEN
add wave -noupdate -expand -group DP:ENs /system_tb/DUT/CPU/dcif/imemREN
add wave -noupdate -expand -group DP:buses /system_tb/DUT/CPU/dcif/imemload
add wave -noupdate -expand -group PC /system_tb/DUT/CPU/DP/rfif/PC
add wave -noupdate -expand -group PC /system_tb/DUT/CPU/DP/PCtemp
add wave -noupdate -expand -group PC /system_tb/DUT/CPU/DP/PCnxt
add wave -noupdate -expand -group PC /system_tb/DUT/CPU/DP/PC4
add wave -noupdate -expand -group PC /system_tb/DUT/CPU/DP/PCelse
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/imemload
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/cu_dmemREN
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/cu_dmemWEN
add wave -noupdate -group {reg file} /system_tb/DUT/CPU/DP/rfif/wsel
add wave -noupdate -group {reg file} /system_tb/DUT/CPU/DP/rfif/wdat
add wave -noupdate -group {reg file} -expand /system_tb/DUT/CPU/DP/regfile/data
add wave -noupdate -expand -group {CCIF:mem ctrl} /system_tb/DUT/CPU/CM/instr
add wave -noupdate -expand -group {CCIF:mem ctrl} /system_tb/DUT/CPU/ccif/iREN
add wave -noupdate -expand -group {CCIF:mem ctrl} /system_tb/DUT/CPU/ccif/dREN
add wave -noupdate -expand -group {CCIF:mem ctrl} /system_tb/DUT/CPU/ccif/dWEN
add wave -noupdate -expand -group {CCIF:mem ctrl} /system_tb/DUT/CPU/ccif/iwait
add wave -noupdate -expand -group {CCIF:mem ctrl} /system_tb/DUT/CPU/ccif/dwait
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/rfif/oprnd1
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/rfif/oprnd2
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/rfif/alurst
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/rfif/alucode
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {882242 ps} 0}
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
WaveRestoreZoom {755952 ps} {1185320 ps}
