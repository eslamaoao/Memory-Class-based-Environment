// Code your design here
module Mem(intf.mod mod1);

logic CLK,RST,EN;
logic [3:0]Address;
logic [31:0]Data_In;
logic W_R; // write or read , if 1 then Write if 0 then read
	
reg [31:0]Data_Out;
reg Valid_Out;
 
 
assign CLK = mod1.CLK;
assign RST = mod1.RST;
assign EN  = mod1.EN;
assign W_R = mod1. W_R;
assign Address  = mod1.Address;
assign Data_In  = mod1.Data_In;


assign mod1.Data_Out   = Data_Out;
assign mod1.Valid_Out  = Valid_Out;


 
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
  
 always_ff@(posedge  CLK or negedge  RST )
  begin
	if(! RST)
	 begin
		for(i=0;i<16;i=i+1) 
			mem[i] <= 32'd0;
		Valid_Out <= 1'b0;
	 end
	 
	else if ( EN)
	 begin
		if( W_R) // write or read , if 1 then Write if 0 then read
		 begin
			mem[ Address] <=  Data_In;
            Valid_Out <= 1'b0;
           	Data_Out <= 32'd0;
		 end
		 
		else
		 begin
			 Data_Out <= mem[ Address];
			 Valid_Out <= 1'b1;
		 end
		
	 
	 end
    else
      begin
        Valid_Out <= 1'b0;
        Data_Out <= 32'd0;
      end
  
  end
endmodule
