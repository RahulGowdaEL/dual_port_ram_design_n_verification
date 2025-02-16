//DRIVER
class mem_driver extends uvm_driver#(mem_seq_item);
	`uvm_component_utils(mem_driver)
	
//Virtual interface to drive the signals from tb -> dut	
virtual mem_if vif;

function new(string name = "mem_driver", uvm_component parent);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase, phase);
	super.build_phase(phase);
	if(!(uvm_config_db#(virtual mem_if)::get(this,"","mem_if",vif);
		`uvm_error("get_full_name", "unable to get the interfce have u set in the top")
	endfunction :build_phase

//RUN Phase
virtual task run_phase(uvm_phase phase);
	forever begin
	seq_item_port.get_next_item(req);  //req for the seqr to get a txn from the seq generated
	drive(); //drive directly to the dut
	seq_item_port.item_done(req);  //Notify that the item has been sent
	end
endtask : run_phase
