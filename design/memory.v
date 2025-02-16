//dut

module memory#(parameter DATA_WIDTH = 64,
				parameter ADDR_WIDTH = 32);
			(input clk,      //clock signal
			input reset,     //reset signal
			input write_en, read_en,   //control signal
			input [ADDR_WIDTH - 1] addr,   //address bus of 32bit
			input [DATA_WIDTH - 1] w_data,   //data of 64bit
			output [DATA_WIDTH - 1] r_data );   //read data
			
	//mem array (64 x 64)
	reg [DATA_WIDTH-1]memArray [2*ADDR_WIDTH];   //depth is 64 length is 64bit wide
	
	//On reset store 8'hff in all the locations
	always@(posedge rst)
		for (int i=0; i<2**ADDR_WIDTH ;i++)
			memArray[i] = 8'hff;
			
	//Write into the memory always when write_en is asserted
		always@(posedge clk)
			if(write_en)
				memArray[addr] <= w_data;
				
	//Read from the memory when read_en is asserted
		always@(posedge clk)
			if(read_en)
				r_data <= memArray[addr];
	endmodule
