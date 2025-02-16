//MEM SCOREBOARD

class mem_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(mem_scoreboard)   //registring to the factory
mem_seq_item pkt_qu[$]; //Queue to store the received mem sequence items
bit [3:0] sc_mem[4] ; //static mem array for the expected data
uvm_analysis_imp#(mem_seq_item) item_collect_export;
uvm_active_passive_enum = UVM_ACTIVE;

function new(string name = "mem_scoreboard", uvm_component);
	super.new(name, parent);
endfunction

//-------------
//BUILD PHASE	
//------------
function build_phase(uvm_phase phase);
	super.build_phase(uvm_phase phase);
	item_collect_export = new("item_collect_export", this);
	foreach (sc_mem[i]) 
		sc_mem[i] = 8'hff;  //Initialize mem with default value
	endfunction

//Write fucntion
virtual function void write	(mem_seq_item pkt);
	pkt_qu.push_back(pkt);  //Load the que with seq item(xtns)
endfunction

//Run Phase
virtual task run_phase(uvm_phase phase);
	mem_seq_item mem_pkt;
	foreach begin
	wait(pkt_qu.size() > 0); //Wait until there are items in the que
	mem_pkt = pkt_qu.pop_front(); //de=Q the front item from the que
	
	if (mem_pkt.wr_en) begin
		sc_mem[mem_pkt.addr] = mem_pkt.wdata;  //Update expected data in the mem_Array
		`uvm_info(get_type_name(), $sformatf("address is %0h", mem_pkt.addr, UVM_LOW)
		`uvm_info(get_type_name(), $sformatf("data is %0h", mem_pkt.wdata, UVM_LOW)
		`uvm_info(get_type_name(), "----------", UVM_LOW)
		end
	else if(mem.pkt.rd_en)  begin
		if (sc_mem[mem.pkt.addr] == mem_pkt.rdata)  begin
			`uvm_info(get_type_name(), $sformatf("address is %0h", mem_pkt.addr, UVM_LOW)
			`uvm_info(get_type_name(), $sformatf("Expected data is %0h, Actual data is %0h", sc_mem[mem_pkt.addr], mem_pkt.rdata, UVM_LOW)
			end
		else  begin
			`uvm_error(get_type_name(), "--READ DATA Mismatch --", UVM_NONE);
			`uvm_info(get_type_name(), $sformatf("address is %0h", mem_pkt.addr, UVM_LOW)
			`uvm_info(get_type_name(), $sformatf("Expected data is %0h, Actual data is %0h", sc_mem[mem_pkt.addr], mem_pkt.rdata, UVM_LOW)
			end
		end	
	end
endtask  : run_phase
endclass : scoreboard
