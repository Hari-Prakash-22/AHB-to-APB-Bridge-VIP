class ahb_sequence extends uvm_sequence#(ahb_xtn);
	`uvm_object_utils(ahb_sequence)
	bit [2:0]hsize;
 	bit [1:0]htrans;
 	bit [31:0]hwdata;
 	bit [31:0]haddr;
	bit hwrite;
	bit[2:0]hburst;
	
 	bit [31:0]hrdata;
	int length;
	bit[1:0]hresp;
	bit hready;

	//-------------------------------
	//--------METHODS----------------
	//-------------------------------
	extern function new(string name="ahb_sequence");
	//extern task body();
endclass

function ahb_sequence::new(string name="ahb_sequence");
	super.new(name);
endfunction
//task ahb_sequence::body();
//	super.body();
//endtask

class incr_seq extends ahb_sequence;
	`uvm_object_utils(incr_seq)


	extern function new(string name="incr_seq");
	extern task body();
endclass

function incr_seq::new(string name="incr_seq");
	super.new(name);
endfunction

task incr_seq::body();
//	super.body();
	begin
	req=ahb_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {Htrans==2'b10; Hwrite ==1;Hburst inside {3,5,7};});
		finish_item(req);
		haddr=req.Haddr;
		hwrite=req.Hwrite;
		hburst=req.Hburst;
		hsize=req.Hsize;
		length=req.length;
		for(int i=0;i<(length-1);i++) begin
			start_item(req);
			assert(req.randomize() with {Hsize==hsize;
							Htrans==3;
							Hwrite==hwrite;
							Hburst==hburst;
							Haddr==haddr+(2**hsize);
						}); 
		//`uvm_info(get_type_name(),$sformatf("sr_seqs %s",req.sprint),UVM_LOW);

			finish_item(req);
		haddr=req.Haddr;
	end	
	end

endtask
class wrap4_seq extends ahb_sequence;
	`uvm_object_utils(wrap4_seq)


	extern function new(string name="wrap4_seq");
	extern task body();
endclass

function wrap4_seq::new(string name="wrap4_seq");
	super.new(name);
endfunction

task wrap4_seq::body();
//	super.body();
	begin
	req=ahb_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {Hsize==2;Htrans==2'b10; Hwrite ==1;Hburst inside {2,4,6};});
		finish_item(req);
		haddr=req.Haddr;
		hwrite=req.Hwrite;
		hburst=req.Hburst;
		hsize=req.Hsize;
		length=req.length;
	//	#50;
		if(hburst==2)
		begin
		for(int i=0;i<(length-1);i++) 
			begin
				start_item(req);
				if(req.Hsize==0)
				begin
				assert(req.randomize() with {Hsize==hsize;
							Htrans==3;
							Hwrite==hwrite;
							Hburst==hburst;
							Haddr=={haddr[31:2],haddr[1:0]+1'b1};});
			 
				end
				if(hsize==1)
				begin
				assert(req.randomize() with {Hsize==hsize;
							Htrans==3;
							Hwrite==hwrite;
							Hburst==hburst;
							Haddr=={haddr[31:3],haddr[2:1]+1'b1,haddr[0]};});
					 
				end
				if(hsize==2)
				begin
				assert(req.randomize() with {Hsize==hsize;
							Htrans==3;
							Hwrite==hwrite;
							Hburst==hburst;
							Haddr=={haddr[31:4],haddr[3:2]+1'b1,haddr[1:0]};});
					 
				end
		finish_item(req);
		haddr=req.Haddr;		end
		end

		if(hburst==4)
		begin
		for(int i=0;i<(length-1);i++) 
			begin
				start_item(req);
				if(req.Hsize==0)
				begin
				assert(req.randomize() with {Hsize==hsize;
							Htrans==3;
							Hwrite==hwrite;
							Hburst==hburst;
							Haddr=={haddr[31:2],haddr[1:0]+1'b1};});
			 
				end
				if(hsize==1)
				begin
				assert(req.randomize() with {Hsize==hsize;
							Htrans==3;
							Hwrite==hwrite;
							Hburst==hburst;
							Haddr=={haddr[31:3],haddr[2:1]+1'b1,haddr[0]};});
					 
				end
				if(hsize==2)
				begin
				assert(req.randomize() with {Hsize==hsize;
							Htrans==3;
							Hwrite==hwrite;
							Hburst==hburst;
							Haddr=={haddr[31:4],haddr[3:2]+1'b1,haddr[1:0]};});
					 
				end
		finish_item(req);
		haddr=req.Haddr;

		end
		end
		if(hburst==6)
		begin
		for(int i=0;i<(length-1);i++) 
			begin
				start_item(req);
				if(req.Hsize==0)
				begin
				assert(req.randomize() with {Hsize==hsize;
							Htrans==3;
							Hwrite==hwrite;
							Hburst==hburst;
							Haddr=={haddr[31:2],haddr[1:0]+1'b1};});
			 
				end
				if(hsize==1)
				begin
				assert(req.randomize() with {Hsize==hsize;
							Htrans==3;
							Hwrite==hwrite;
							Hburst==hburst;
							Haddr=={haddr[31:3],haddr[2:1]+1'b1,haddr[0]};});
					 
				end
				if(hsize==2)
				begin
				assert(req.randomize() with {Hsize==hsize;
							Htrans==3;
							Hwrite==hwrite;
							Hburst==hburst;
							Haddr=={haddr[31:4],haddr[3:2]+1'b1,haddr[1:0]};});
					 
				end
		finish_item(req);
		haddr=req.Haddr;

		end
		end


		//`uvm_info(get_type_name(),$sformatf("sr_seqs %s",req.sprint),UVM_LOW);

		/*	finish_item(req);
		haddr=req.Haddr;*/
	
	end
endtask
class single_seq extends ahb_sequence;
	`uvm_object_utils(single_seq)


	extern function new(string name="single_seq");
	extern task body();
endclass

function single_seq::new(string name="single_seq");
	super.new(name);
endfunction

task single_seq::body();
//	super.body();
	begin
	req=ahb_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {Hsize==2;Htrans==2'b10; Hwrite ==1;Hburst inside {2,4,6};});
		finish_item(req);
	end
endtask



