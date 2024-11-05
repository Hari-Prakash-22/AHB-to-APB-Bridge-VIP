class ahb_config extends uvm_object;
	`uvm_object_utils(ahb_config)
	virtual bridge_if vif;
	uvm_event_pool event_pool = uvm_event_pool::get_global_pool();
	uvm_active_passive_enum is_active=UVM_ACTIVE;
	//------------------------
	//---METHODS-------------
	//------------------------
	extern function new(string name="ahb_config");
endclass
function ahb_config::new(string name="ahb_config");
	super.new("ahb_config");
endfunction

