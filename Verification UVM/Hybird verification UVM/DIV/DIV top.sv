//div of RV32IM verification uvm
//Author: reem ahmed
//DIV TOP


`include "uvm_macros.svh"
import DIV_config_obj::*;
import DIV_driver::*;
import DIV_env::*;
import DIV_test::*;
import uvm_pkg::*;
module DIV_top();

DIV_interface divIF();
division DUT(divIF);
	//assertions bind

//interface handle in the config. databse & runnig test
initial begin
		uvm_config_db#(virtual DIV_interface)::set(null, "uvm_test_top", "DIV_INTERFACE", divIF); 
		run_test("div_test");
	end



endmodule : DIV_top
