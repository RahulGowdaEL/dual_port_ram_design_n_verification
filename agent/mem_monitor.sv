//MONITOR
class mem_monitor extends uvm_monitor;
	`uvm_component_utils(mem_monitor)
	
//Virtual interface to collect the signals from driver psasing to dut
virtual mem_if vif;	
uvm_analysis_port#(mem_seq_item) item_collect_port;
mem_seq_item trans_collected;

function new(string name = "mem_monitor", uvm_component parent);
	super.new(name,parent);
	trans_collected = new();
	item_collect_port = new("item_collect_port",this);
endfunction  : new

function void build_phase(uvm_phase, phase);
	super.build_phase(phase);
	if(!(uvm_config_db#(virtual mem_if)::get(this,"","mem_if",vif);
		`uvm_error("get_full_name", "unable to get the interfce have u set in the top")
	endfunction : build_phase
	
//RUN Phase
virtual task run_phase(uvm_phase phase);
forever  begin
	@(posedge vif.MONITOR.clk);  //Wait for the next clock edge
	wait(vif.monitor_cb.wr_en || vif.monitor_cb.rd_en);  //Wait until either write or read happens on the dut
		trans_collected.addr = vif.monitor_cb.addr; //collect using blocking statement 
		
		if (vif.monitor_cb.wr_en) begin
			trans_collected.wr_en = vif.monitor_cb.wr_en; //collect write enable info
			trans_collected.wr_data = vif.monitor_cb.wr_data; //collect write data info
			trans_collected.rd_en <= 0;
			@(posedge vif.MONITOR.clk);
			end
		if (vif.monitor_cb.rd_en) begin
			trans_collected.rd_en = vif.monitor_cb.rd_en;
			trans_collected.wr_en = 0;
			always@(2)
			trans_collected.rd_data = vif.monitor_cb.rd_data;
			end
			
			item_collect_port.write(trans_collected);  //Write the collected transaction to the analysis port
			end
		endtask : run_phase
	endclass : monitor
