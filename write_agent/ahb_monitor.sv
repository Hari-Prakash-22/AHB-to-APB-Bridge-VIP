class ahb_monitor extends uvm_monitor;
	`uvm_component_utils(ahb_monitor);
	ahb_xtn xtn;
	ahb_config ahb_cfg;
	virtual bridge_if.SRC_MON vif;
	uvm_analysis_port#(ahb_xtn) ahb_monitor_port;
	//--------------------------
	//---------METHODS---------
	//-------------------------
	extern function new(string name="ahb_monitor",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task collect_data();
endclass

function ahb_monitor::new(string name="ahb_monitor",uvm_component parent);
	super.new(name,parent);
	ahb_monitor_port=new("ahb_monitor_port",this);
endfunction


function void ahb_monitor::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db#(ahb_config)::get(this,"","ahb_config",ahb_cfg))
		`uvm_fatal(get_type_name(),"can't get the config")

	
endfunction
function void ahb_monitor::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	vif=ahb_cfg.vif;
endfunction


task ahb_monitor::run_phase(uvm_phase phase);
	super.run_phase(phase);
	forever
		collect_data();


endtask
task ahb_monitor::collect_data();
	xtn=ahb_xtn::type_id::create("xtn");

while(vif.src_mon_cb.Hreadyout===0)
		@(vif.src_mon_cb);

while(vif.src_mon_cb.Htrans!==2'b10 && vif.src_mon_cb.Htrans!==2'b11)
		@(vif.src_mon_cb);
//$display("addasdfafafasdfd");


	//	@(vif.src_mon_cb)
		xtn.Haddr=vif.src_mon_cb.Haddr;
		xtn.Hwrite=vif.src_mon_cb.Hwrite;
		xtn.Htrans=vif.src_mon_cb.Htrans;
		xtn.Hsize=vif.src_mon_cb.Hsize;
		xtn.Hreadyin=vif.src_mon_cb.Hreadyin;
	
		@(vif.src_mon_cb);
//$display("addasdfafafasdfd");
//	while(vif.src_mon_cb.Hreadyout===0 && (vif.src_mon_cb.Htrans!=2'b10||vif.src_mon_cb.Htrans!=2'b11))

//wait(vif.src_mon_cb.Hreadyout==1&&(vif.src_mon_cb.Htrans==2'b10||vif.src_mon_cb.Htrans==2'b11))

//		@(vif.src_mon_cb)
while(vif.src_mon_cb.Hreadyout===0)
		@(vif.src_mon_cb);
	if(vif.src_mon_cb.Hwrite==1)
		xtn.Hwdata=vif.src_mon_cb.Hwdata;
	else
	begin
		//$display("--------------------------------==---=-=-=------------------");
		xtn.Hrdata=vif.src_mon_cb.Hrdata;
	end

	ahb_monitor_port.write(xtn);
	`uvm_info(get_type_name(),"this is monitored transcation",UVM_LOW)
	xtn.print();
endtask
