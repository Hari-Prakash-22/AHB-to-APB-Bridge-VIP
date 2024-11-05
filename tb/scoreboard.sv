class scoreboard extends uvm_scoreboard;
	`uvm_component_utils(scoreboard);


	uvm_tlm_analysis_fifo#(ahb_xtn)ahb_monitor_xtn;
	uvm_tlm_analysis_fifo#(apb_xtn)apb_monitor_xtn;
	ahb_xtn ahb_xtn_h,ahb_cov;
	apb_xtn apb_xtn_h,apb_cov;



	//--------------------------
	//---------METHODS---------
	//-------------------------
	extern function new(string name="scoreboard",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task collect_data(ahb_xtn ahb,apb_xtn apb);
	extern task compare_data(bit [31:0] Haddr,Paddr,Hdata,Pdata);
	
	covergroup ahb_cov1;
	cp1: coverpoint ahb_cov.Hsize[2:0]{bins b1[]={[0:2]};}
	cp2: coverpoint ahb_cov.Haddr[31:0]{bins b1[4]={[32'h8000_0000:32'h8000_03ff],
					     [32'h8400_0000:32'h8400_03ff],
					     [32'h8800_0000:32'h8800_03ff],
					     [32'h8c00_0000:32'h8c00_03ff]};}
	cp3: coverpoint ahb_cov.Htrans[1:0]{bins b1[]={[2:3]};}
	cp4: coverpoint ahb_cov.Hwrite{bins b1[]={[0:1]};}
	cp5: cross cp1,cp3;
	endgroup
	covergroup apb_cov1;
		cp1: coverpoint apb_cov.Paddr[31:0]{bins b1[4]={[32'h8000_0000:32'h8000_03ff],
					     [32'h8400_0000:32'h8400_03ff],
					     [32'h8800_0000:32'h8800_03ff],
					     [32'h8c00_0000:32'h8c00_03ff]};}
	cp2: coverpoint apb_cov.Pwrite{bins b1[]={[0:1]};}
	cp3: coverpoint apb_cov.Pselx;
	cp4: cross cp2,cp3;
	endgroup
	

	

endclass

function scoreboard::new(string name="scoreboard",uvm_component parent);
	super.new(name,parent);
	ahb_monitor_xtn=new("ahb_monitor_xtn",this);
	apb_monitor_xtn=new("apb_monitor_xtn",this);
	ahb_cov1=new();
	apb_cov1=new();
endfunction


function void scoreboard::build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction


task scoreboard::run_phase(uvm_phase phase);
	super.run_phase(phase);
	forever
	begin
	fork
		begin
			ahb_monitor_xtn.get(ahb_xtn_h);
			ahb_cov=ahb_xtn_h;
		//	`uvm_info(get_type_name(),$sformatf("%s",ahb_xtn_h.sprint),UVM_LOW)
			ahb_cov1.sample();
			
			
		end
		begin
			apb_monitor_xtn.get(apb_xtn_h);
		//	`uvm_info(get_type_name(),$sformatf("%s",apb_xtn_h.sprint),UVM_LOW)
			apb_cov=apb_xtn_h;
			apb_cov1.sample();
		end
	join
	collect_data(ahb_xtn_h,apb_xtn_h);
	end
	
endtask
task scoreboard::compare_data(bit [31:0] Haddr,Paddr,Hdata,Pdata);
	begin
	if(Haddr==Paddr)
		`uvm_info(get_type_name(),"The address is matching",UVM_LOW)
	else
		begin
			
		`uvm_info(get_type_name(),"The address is not matching",UVM_LOW)
	//	`uvm_info(get_type_name(),$sformatf("Haddr=%s Paddr=%s",Haddr,Paddr),UVM_LOW)
		end
	end
	if(Hdata==Pdata)
		`uvm_info(get_type_name(),"The data is matching",UVM_LOW)
	else
		begin
			
		`uvm_info(get_type_name(),"The data is not matching",UVM_LOW)
	//	`uvm_info(get_type_name(),$sformatf("Hdata=%s Pdata=%s",Hdata,Pdata),UVM_LOW)
		end
endtask
task scoreboard::collect_data(ahb_xtn ahb,apb_xtn apb);
	if(ahb.Hwrite==1)
	begin
		if(ahb.Hsize==0)
		begin
			if(ahb.Haddr[1:0]==2'b00)
			compare_data(ahb.Haddr,apb.Paddr,ahb.Hwdata[7:0],apb.Pwdata[7:0]);
			if(ahb.Haddr[1:0]==2'b01)
			compare_data(ahb.Haddr,apb.Paddr,ahb.Hwdata[15:8],apb.Pwdata[7:0]);
			if(ahb.Haddr[1:0]==2'b10)
			compare_data(ahb.Haddr,apb.Paddr,ahb.Hwdata[23:16],apb.Pwdata[7:0]);
			if(ahb.Haddr[1:0]==2'b10)
			compare_data(ahb.Haddr,apb.Paddr,ahb.Hwdata[31:24],apb.Pwdata[7:0]);
		end
		if(ahb.Hsize==1)
		begin
			if(ahb.Haddr[1:0]==2'b00)
			compare_data(ahb.Haddr,apb.Paddr,ahb.Hwdata[15:0],apb.Pwdata[15:0]);
			if(ahb.Haddr[1:0]==2'b01)
			compare_data(ahb.Haddr,apb.Paddr,ahb.Hwdata[31:16],apb.Pwdata[15:0]);
		end
		if(ahb.Hsize==2)
		begin
			compare_data(ahb.Haddr,apb.Paddr,ahb.Hwdata[31:0],apb.Pwdata[31:0]);
	
		end
	end
	if(ahb.Hwrite==0)
	begin
		if(ahb.Hsize==0)
		begin
			if(ahb.Haddr[1:0]==2'b00)
			compare_data(ahb.Haddr,apb.Paddr,ahb.Hrdata[7:0],apb.Prdata[7:0]);
			if(ahb.Haddr[1:0]==2'b01)
			compare_data(ahb.Haddr,apb.Paddr,ahb.Hrdata[15:8],apb.Prdata[7:0]);
			if(ahb.Haddr[1:0]==2'b10)
			compare_data(ahb.Haddr,apb.Paddr,ahb.Hrdata[23:16],apb.Prdata[7:0]);
			if(ahb.Haddr[1:0]==2'b10)
			compare_data(ahb.Haddr,apb.Paddr,ahb.Hrdata[31:24],apb.Prdata[7:0]);
		end
		if(ahb.Hsize==1)
		begin
			if(ahb.Haddr[1:0]==2'b00)
			compare_data(ahb.Haddr,apb.Paddr,ahb.Hrdata[15:0],apb.Prdata[15:0]);
			if(ahb.Haddr[1:0]==2'b01)
			compare_data(ahb.Haddr,apb.Paddr,ahb.Hrdata[31:16],apb.Prdata[15:0]);
		end
		if(ahb.Hsize==2)
		begin
			compare_data(ahb.Haddr,apb.Paddr,ahb.Hrdata[31:0],apb.Prdata[31:0]);
	
		end
	end
endtask
