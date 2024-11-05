class apb_driver extends uvm_driver#(apb_xtn);
	`uvm_component_utils(apb_driver);
	apb_config apb_cfg;

	virtual bridge_if.DST_DRV vif;
	//--------------------------
	//---------METHODS---------
	//-------------------------
	extern function new(string name="apb_driver",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task send_to_dut();
endclass

function apb_driver::new(string name="apb_driver",uvm_component parent);
	super.new(name,parent);
endfunction


function void apb_driver::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db#(apb_config)::get(this,"","apb_config",apb_cfg))
		`uvm_fatal(get_type_name(),"can't get the config")
endfunction
function void apb_driver::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	vif = apb_cfg.vif;
endfunction


task apb_driver::run_phase(uvm_phase phase);
	super.run_phase(phase);
	forever
		send_to_dut();
endtask
task apb_driver::send_to_dut();
	apb_xtn xtn;
	xtn=apb_xtn::type_id::create("xtn");
	while(vif.dst_drv_cb.Pselx===0)
	begin
		@(vif.dst_drv_cb);
	end
//	$display("hi1");
	if(vif.dst_drv_cb.Pwrite==0)
	begin
//	$display("hi2");
		if(vif.dst_drv_cb.Penable)
		begin
//				$display("inside penable block");
			vif.dst_drv_cb.Prdata<=$urandom;
		end
	end
	repeat(1)
		@(vif.dst_drv_cb);
//	$display("%s",xtn.Prdata);
//	`uvm_info(get_type_name(),"this is apb driver xtn",UVM_LOW)
//	xtn.print();
endtask

