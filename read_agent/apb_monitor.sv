class apb_monitor extends uvm_monitor;
	`uvm_component_utils(apb_monitor);
	virtual bridge_if.DST_MON vif;
	apb_config apb_cfg;
	apb_xtn xtn;
	uvm_analysis_port#(apb_xtn) apb_monitor_port;

	//--------------------------
	//---------METHODS---------
	//-------------------------
	extern function new(string name="apb_monitor",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task collect_data();
endclass

function apb_monitor::new(string name="apb_monitor",uvm_component parent);
	super.new(name,parent);
	apb_monitor_port=new("apb_monitor_port",this);
endfunction


function void apb_monitor::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db#(apb_config)::get(this,"","apb_config",apb_cfg))
		`uvm_fatal(get_type_name(),"can't get the config")
endfunction

function void apb_monitor::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	vif=apb_cfg.vif;
endfunction


task apb_monitor::run_phase(uvm_phase phase);
	super.run_phase(phase);
	forever 
		collect_data();
endtask
task apb_monitor::collect_data();
	
xtn=apb_xtn::type_id::create("xtn");
//	@(vif.dst_mon_cb);
//	@(vif.dst_mon_cb);

	wait(vif.dst_mon_cb.Penable==1)


//	while(vif.dst_mon_cb.Penable===0)
//		@(vif.dst_mon_cb);
	
	xtn.Penable=vif.dst_mon_cb.Penable;
	xtn.Pwrite=vif.dst_mon_cb.Pwrite;
	xtn.Paddr=vif.dst_mon_cb.Paddr;
	xtn.Pselx=vif.dst_mon_cb.Pselx;

	//	@(vif.dst_mon_cb);


	if(vif.dst_mon_cb.Pwrite==1)
	begin
		xtn.Pwdata=vif.dst_mon_cb.Pwdata;
	end
	else
	begin
		xtn.Prdata=vif.dst_mon_cb.Prdata;
	end
	repeat(2)
	begin
		@(vif.dst_mon_cb);
	end
	apb_monitor_port.write(xtn);
	`uvm_info(get_type_name(),$sformatf("this is apb monitor data %s",xtn.sprint),UVM_LOW)
	//xtn.print();
endtask
