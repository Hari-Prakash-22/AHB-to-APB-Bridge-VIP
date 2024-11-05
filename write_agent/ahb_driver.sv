
class ahb_driver extends uvm_driver#(ahb_xtn);
	`uvm_component_utils(ahb_driver);
	virtual bridge_if.SRC_DRV vif;
	
	ahb_config ahb_cfg;
	//--------------------------
	//---------METHODS---------
	//-------------------------
	extern function new(string name="ahb_driver",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task send_to_dut(ahb_xtn xtn);
	extern function void report_phase(uvm_phase phase);
endclass

function ahb_driver::new(string name="ahb_driver",uvm_component parent);
	super.new(name,parent);
endfunction


function void ahb_driver::build_phase(uvm_phase phase);

	super.build_phase(phase);

	uvm_top.print_topology();
	if(!uvm_config_db#(ahb_config)::get(this,"","ahb_config",ahb_cfg))
		`uvm_fatal(get_type_name(),"can't get the config")
endfunction
function void ahb_driver::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	vif=ahb_cfg.vif;
endfunction


task ahb_driver::run_phase(uvm_phase phase);
	super.run_phase(phase);
//$display("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");

	@(vif.src_drv_cb);
		vif.src_drv_cb.Hresetn<=1'b0;
	@(vif.src_drv_cb);
		vif.src_drv_cb.Hresetn<=1'b1;
//	while(vif.src_drv_cb.Hreadyout===0)
	//	@(vif.src_drv_cb);
	forever
	begin
		seq_item_port.get_next_item(req);
//$display("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
		send_to_dut(req);
		seq_item_port.item_done();
	end

endtask

task ahb_driver::send_to_dut(ahb_xtn xtn);
	//$display("hi ");


//	$display("hi ");
//	$display("hi ");


	while(vif.src_drv_cb.Hreadyout===0)
	begin
		`uvm_info(get_type_name(),$sformatf("%p ",vif.src_drv_cb.Hreadyout),UVM_LOW)
		@(vif.src_drv_cb);
	end

	`uvm_info(get_type_name(),"The AHB Transcation is",UVM_LOW) //$sformatf("%s",xtn.sprint),UVM_LOW)	
xtn.print();

		vif.src_drv_cb.Haddr<=xtn.Haddr;
		vif.src_drv_cb.Hwrite<=xtn.Hwrite;
		vif.src_drv_cb.Htrans<=xtn.Htrans;
		vif.src_drv_cb.Hsize<=xtn.Hsize;
		vif.src_drv_cb.Hreadyin<=1'b1;
	@(vif.src_drv_cb);
//	$display("hi ");
	while(vif.src_drv_cb.Hreadyout==0)
	@(vif.src_drv_cb);
//	$display("hi ");
	if(xtn.Hwrite)
		vif.src_drv_cb.Hwdata<=xtn.Hwdata;
	else
		vif.src_drv_cb.Hwdata<=32'b0;



endtask
function void ahb_driver::report_phase(uvm_phase phase);
	super.report_phase(phase);
endfunction
