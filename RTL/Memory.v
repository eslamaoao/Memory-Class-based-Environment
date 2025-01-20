module Memory
 (
	input logic CLK,RST,EN,
	input logic [3:0]Address,
	input logic [31:0]Data_In,
	input logic W_R, // write or read , if 1 then Write if 0 then read
	
	output reg [31:0]Data_Out,
	output reg Valid_Out
 );

 integer  i;
 
 reg [31:0] mem [15:0];
 
 //reg [3:0] add_reg;
// reg [31:0] data_reg;
 /*
 always@(posedge CLK or negedge RST ) // registering the Address 
  begin
	if(!RST)
	 begin
		add_reg <= 4'd0;
	 end
	 
	else
	 begin
		if(EN)
		 add_reg <= Address;
	 end
  end
  
  always@(posedge CLK or negedge RST ) // registering the data_in
  begin
	if(!RST)
	 begin
		data_reg <= 32'd0;
	 end
	 
	else
	 begin
		if(EN)
		 data_reg <= Data_In;
	 end
  end
  */
  
 always_ff@(posedge CLK or negedge RST )
  begin
	if(!RST)
	 begin
		for(i=0;i<16;i=i+1) 
			mem[i] <= 32'd0;
		Valid_Out <= 1'b0;
	 end
	 
	else if (EN)
	 begin
		if(W_R) // write or read , if 1 then Write if 0 then read
		 begin
			mem[Address] <= Data_In;
		 end
		 
		else
		 begin
			Data_Out <= mem[Address];
			Valid_Out <= 1'b1;
		 end
		
	 
	 end
  
  end
endmodule