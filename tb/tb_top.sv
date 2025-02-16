//TB Top module

module memory_tb_top();

memory_if mem_if(clk, reset);  //create an instance of the interface to pass to the Dynamic tb

//---CLOCK and Reset signal declaration
bit clk, reset;

//Generate the clk
initial begin
  forever
    #5 clk = ~clk;
  end
//connect the dut
memory u_dut(.write_en(mem_if.write_en),
			 .read_en(mem_if.read_en),
			 .w_data(mem_if.w_data),
			 .r_data(mem_if.r_data),
			 .addr(mem_if.addr)
			 );
			 
//Apply the resets
initial begin
    reset = 1;  //Assert reset after 5 tim units
	#5 reset = 0;   //deassert
	end
			 
//Set the config db for the interface to below components	
initial begin		 
uvm_config_db(virtual mem_if)::set(null,"*","memory_if",mem_if); 
$dumpfile("dump.vcd");
$dumpvars;
end

initial begin
run_test("mem_wr_rd_test");
end

endmodule
