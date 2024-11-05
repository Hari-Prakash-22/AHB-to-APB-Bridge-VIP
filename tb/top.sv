module ahb_apb_bridge;
import uvm_pkg::*;
import test_pkg::*;
	`include "uvm_macros.svh"

bit clock;
always #10 clock=~clock;

//-------interface instanitation ---------------------//
	bridge_if src_in0(clock);
	bridge_if dst_in0(clock);


//-------instantiate the rtl with the tb----------//
	rtl_top dut(.Hclk(clock),
			.Hrdata(src_in0.Hrdata),
			.Hreadyout(src_in0.Hreadyout),
			.Hresp(src_in0.Hresp),
			.Hresetn(src_in0.Hresetn),
			.Hreadyin(src_in0.Hreadyin),
			.Htrans(src_in0.Htrans),
			.Hsize(src_in0.Hsize),
			.Hwdata(src_in0.Hwdata),
			.Haddr(src_in0.Haddr),
			.Hwrite(src_in0.Hwrite),
			.Pselx(dst_in0.Pselx),
			.Pwrite(dst_in0.Pwrite),
		   	.Penable(dst_in0.Penable), 
		  	.Paddr(dst_in0.Paddr),
		   	.Pwdata(dst_in0.Pwdata),
			.Prdata(dst_in0.Prdata));








initial 
	begin

		`ifdef VCS
        	 $fsdbDumpvars(0, ahb_apb_bridge);
        	`endif	
		uvm_config_db#(virtual bridge_if)::set(null,"*","ahb_if",src_in0);
		uvm_config_db#(virtual bridge_if)::set(null,"*","apb_if",dst_in0);







		run_test("");


	end
endmodule	
