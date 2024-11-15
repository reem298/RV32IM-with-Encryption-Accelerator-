//mult of RV32IM verification uvm
//Author: reem ahmed
//MULT TOP

 
import MULT_config_obj::*;
import MULT_driver::*;
import MULT_env::*;
import MULT_test::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
module MULT_top(/*MULT_interface.TEST multIF */);
	bit clk;

	/* Clock Generation */
	initial begin 
		clk = 0;
		forever 
			#1 clk = ~clk;
       end

MULT_interface multIF(clk);
//mult_radix8_top DUT(multIF);
mult DUT(multIF);
	//assertions bind

//interface handle in the config. databse & runnig test
initial begin
		uvm_config_db#(virtual MULT_interface)::set(null, "uvm_test_top", "MULT_INTERFACE", multIF); 
		run_test("mult_test");
	end



endmodule : MULT_top
