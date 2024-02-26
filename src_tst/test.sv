`include "enviroment.sv"

class test extends uvm_test;
  `uvm_component_utils(test)
  
  env env_tst;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    env_tst = env::type_id::create("env_tst",this);
  endfunction
  
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    #5;
    `uvm_warning("","Para Javi, Ya funciona el test 1 de 5")
    phase.drop_objection(this);
  endtask
  
endclass