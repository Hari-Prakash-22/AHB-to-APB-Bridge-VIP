interface bridge_if(input bit clock);
		   logic  Hclk;
                   logic  Hresetn;
                   bit  [1:0] Htrans;
		   logic  [2:0]Hsize; 
		   logic  Hreadyin;
		   logic  [31:0]Hwdata; 
		   logic  [31:0]Haddr;
		   logic  Hwrite;
                   logic  [31:0]Prdata;
		   logic  [31:0]Hrdata;
		   logic  [1:0]Hresp;
		   logic  Hreadyout;
		   logic  [3:0]Pselx;
		   bit  Pwrite;
		   bit  Penable; 
		   logic  [31:0] Paddr;
		   logic  [31:0] Pwdata;
//--------clocking for soure driver--------//
clocking src_drv_cb@(posedge clock);
	default input#1 output #0;
	input Hrdata,Hreadyout,Hresp;
	output Hresetn;
	output Hreadyin;
	output Htrans;
	output Hsize;
	output Hwdata;
	output Haddr;
	output Hwrite;
endclocking
//---------clocking for source monitor -----------//
clocking src_mon_cb@(posedge clock );
	default input #1 output #0;
	input Hrdata,Hreadyout,Hresp;
	input Hreadyin;
	input Hresetn;
	input Htrans;
	input Hsize;
	input Hwdata;
	input Haddr;
	input Hwrite;
endclocking
//----------------------- clocking  block for destination driver ----------//
clocking dst_drv_cb@(posedge clock);
	default input #1 output #0;
	   input Pselx;
	   input Pwrite;
	   input Penable; 
	   input Paddr;
	   input Pwdata;
	   output Prdata;
endclocking 
//------------------clocking block for destination monitor-------------//
clocking dst_mon_cb@(posedge clock);
	default input #1 output #0;
	input Pselx;
	input Pwrite;
	input Prdata;
	input Penable;
	input Paddr;
	input Pwdata;
endclocking


modport SRC_DRV(clocking src_drv_cb);
modport DST_DRV(clocking dst_drv_cb);
modport SRC_MON(clocking src_mon_cb);
modport DST_MON(clocking dst_mon_cb);
endinterface
