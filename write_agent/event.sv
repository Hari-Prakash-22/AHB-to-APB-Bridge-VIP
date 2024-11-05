class eve extends uvm_event_callback;

	`uvm_object_utils(eve)


	function new (string name ="eve");
	super.new(name);
	endfunction
	function bit pre_trigger(uvm_event e,uvm_object data);
		return 0;
	endfunction
	function void post_trigger(uvm_event e,uvm_object data);
		$display("post trigered");
	endfunction
endclass
