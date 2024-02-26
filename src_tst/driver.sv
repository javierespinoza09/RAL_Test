class driver extends uvm_driver #(sequence_drv);
  `uvm_component_utils(driver)
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  
  task run_phase(uvm_phase phase);
    #5;
    `uvm_warning("","Para Javi, Ya funciona el Driver 4 de 5")
    
    seq_item_port.get_next_item(req);
    
    `uvm_warning("","Para Javi, Ya funciona el sequencer 5 de 5 <3 <3 <3")

    seq_item_port.item_done();
    
  endtask
  
endclass