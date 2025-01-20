

class Driver;
  Transaction tr;
  mailbox driv_mailbox;
  
  
  function new();
    driv_mailbox = new(1); 
  endfunction

  task drive(virtual intf intf1); 
    forever 
      begin
        
        driv_mailbox.get(tr); // Wait for a transaction
        @(intf1.cb_driver)
         begin
          intf1.cb_driver.RST <= tr.rst;
          intf1.cb_driver.EN  <= tr.en ;
          intf1.cb_driver.Address <= tr.address;
          intf1.cb_driver.Data_In <= tr.data_in;
          intf1.cb_driver.W_R	  <= tr.w_r;
    
         end
      end
  endtask
endclass
