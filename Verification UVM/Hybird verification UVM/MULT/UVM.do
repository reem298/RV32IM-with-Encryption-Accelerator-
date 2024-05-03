vlib work
vlog -f src_files.list
vsim -voptargs=+acc work.top -classdebug -uvmcontrol=all
add wave /MULT_top/multIF/*
run 0
add wave -position insertpoint  \
sim:/uvm_root/uvm_test_top/env/driver/stim_seq_item
run -all