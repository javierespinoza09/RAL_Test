`include "agente.sv"

class env extends uvm_env;
  `uvm_component_utils(env)
  
  agent agent_env;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    agent_env = agent::type_id::create("agent_env", this);
  endfunction

    task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    #5;
      `uvm_warning("","Para Javi, Ya funciona el env 2 de 5")
    phase.drop_objection(this);
  endtask
  
endclass