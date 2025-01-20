class Subscriber;

  
  mailbox subs_mailbox;      
  Transaction received_tr;  
  

  covergroup input_functional_coverage;
    
    coverpoint received_tr.en 
    {
      bins enabled = {1'b1};
      bins disabled = {1'b0};
    }
    coverpoint received_tr.w_r
    {
      bins write = {1'b1};
      bins read  = {1'b0};
    }
    coverpoint received_tr.address
    {
      bins addr_range[] = {[0:15]}; 
    }
   coverpoint received_tr.data_in 
   {
	  bins low_range[]   = {[1:100]}; 
	  
   }
   
   
    
    cross received_tr.w_r, received_tr.address; 
	
	cross received_tr.en,received_tr.w_r; 
    
  endgroup

covergroup output_functional_coverage;
 
	coverpoint received_tr.data_out 
   {
	  bins low_range[]   = {[1:100]}; 
	  
   }
   
   coverpoint received_tr.valid_out 
   {
	  bins enabled  = {1'b1};
      bins disabled = {1'b0};
   }

endgroup

  function new();
    subs_mailbox = new(1);
    input_functional_coverage = new(); 
	output_functional_coverage = new();
  endfunction


  task collect();
    forever 
	 begin
      subs_mailbox.get(received_tr); 
	 // $display("Sampling outputs: data_out=%0d, valid_out=%0b", received_tr.data_out, received_tr.valid_out);
      input_functional_coverage.sample(); 
	  output_functional_coverage.sample();
      
     end
  endtask

endclass
