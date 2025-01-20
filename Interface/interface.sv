interface intf;

logic CLK,RST,EN,W_R;
logic [3:0]Address;
logic [31:0]Data_In;

reg [31:0]Data_Out;
reg Valid_Out;

modport mod(input CLK, RST, EN, W_R, Address, Data_In, output Data_Out, Valid_Out);

/*
  clocking cb @(negedge CLK);
    output #0 RST, EN, Address, Data_In, W_R; 	  // Driven by testbench
    input #1step Data_Out, Valid_Out;             // Observed from DUT
  endclocking*/
  
  
  // Clocking block for the driver
  clocking cb_driver @(negedge CLK);
    output #0 RST, EN, Address, Data_In, W_R; // Signals driven by the driver
  endclocking

  // Clocking block for the monitor
  clocking cb_monitor @(negedge CLK);
    input RST, EN, Address, Data_In, W_R; // Signals observed by the monitor
    input Data_Out, Valid_Out;           
  endclocking

  
endinterface: intf
