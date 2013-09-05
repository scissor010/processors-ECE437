onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /datapath_tb/CLK
add wave -noupdate /datapath_tb/nRST
add wave -noupdate /datapath_tb/num
add wave -noupdate /datapath_tb/op
add wave -noupdate /datapath_tb/rs
add wave -noupdate /datapath_tb/rt
add wave -noupdate /datapath_tb/rd
add wave -noupdate /datapath_tb/sa
add wave -noupdate /datapath_tb/spe
add wave -noupdate -radix unsigned /datapath_tb/dpif/imemaddr
add wave -noupdate -radix unsigned /datapath_tb/DP_DUT/rfif/PC
add wave -noupdate /datapath_tb/DP_DUT/rfif/vldflg
add wave -noupdate /datapath_tb/DP_DUT/rfif/cryflg
add wave -noupdate /datapath_tb/DP_DUT/rfif/ngtflg
add wave -noupdate /datapath_tb/DP_DUT/rfif/zroflg
add wave -noupdate /datapath_tb/DP_DUT/rfif/dmemREN
add wave -noupdate /datapath_tb/DP_DUT/rfif/dmemWEN
add wave -noupdate /datapath_tb/DP_DUT/rfif/dmemstore
add wave -noupdate /datapath_tb/DP_DUT/rfif/dmemaddr
add wave -noupdate /datapath_tb/DP_DUT/rfif/dmemload
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {145 ns} 0}
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
WaveRestoreZoom {61 ns} {199 ns}
