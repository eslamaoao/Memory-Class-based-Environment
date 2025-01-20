class Scoreboard;

  mailbox score_mailbox;
  Transaction score_tr;
  
   
  bit[3:0] address_holder;
  
  bit [31:0]mem_temp[15:0] ;
  int num_of_failer = 0;
  
  function new();
    score_mailbox = new(1); 
  endfunction

  integer i ;
  
  task check(virtual intf intf1);
    

    int counter=1;
    forever 
      begin
        score_mailbox.get(score_tr);
        
        @(intf1.cb_monitor)
        
         begin
            if(score_tr.valid_out)
               begin
                 //if(mem_temp[score_tr.address] == score_tr.data_out)
                 if(mem_temp[address_holder] == score_tr.data_out)
                   begin
                    // $display("\n\n  ------ Scoreboard Test %0d has Succeeded ---------- \n\n",counter );
					// $display(" Addr = %0d\n\n ", score_tr.address);
                   // $display(" Data :: Expected = %0d \t Actual = %0d \n\n",mem_temp[address_holder] ,score_tr.data_out  );
					 counter = counter + 1;
                   end 
                 else
                   begin
					 $display("------------- time = %0d ns --------------",$time);			
					 $display("\n\n  ------ Scoreboard Test %0d has Failed ----------\n\n ",counter );
					 $display(" Addr = %0d\n ", score_tr.address);
                     $display(" Data :: Expected = %0d \t Actual = %0d\n ",mem_temp[address_holder] ,score_tr.data_out  );
                     counter = counter + 1;
                     num_of_failer=num_of_failer+1;
                   end 
               end
           
           
		if(num_of_failer==0)
         	$display(" time = %0d ns   Congrats all the %0d Tests are Succeeded ",$time,counter);
        else
          	$display(" short sad story " );
			   
           
		if(!score_tr.rst)
			for(i=0;i<16;i=i+1) 
				mem_temp[i] = 32'd0;
		else
		 begin
			if (score_tr.en)
             begin
				if(score_tr.w_r)
                 begin
					mem_temp[score_tr.address]  = score_tr.data_in;
                 end
				else
                 begin
                 	address_holder = score_tr.address;
                 end
             end
		 end 
		   
    
       
      	end
      end
    
    
  endtask

endclass
