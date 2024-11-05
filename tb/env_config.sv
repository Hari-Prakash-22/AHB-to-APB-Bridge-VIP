class env_config extends uvm_object;
	`uvm_object_utils(env_config)

	ahb_config ahb_cfg;
	apb_config apb_cfg;
	bit has_ahb_agent=1;
	bit has_apb_agent=1;
	bit has_scoreboard=1;
	bit has_virtual_sequencer=1;
	//------------------------
	//---METHODS-------------
	//------------------------
	extern function new(string name="env_config");
endclass
function env_config::new(string name="env_config");
	super.new("env_config");
endfunction


