class mem_base_test extends uvm_test;
  `uvm_component_utils(mem_base_test)
  mem_env      env;
  mem_sequence seq;

  function new(string name = "mem_base_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = mem_env::type_id::create("env", this);
  endfunction

  task run_phase(uvm_phase phase);
    seq = mem_sequence::type_id::create("seq");
    phase.raise_objection(this);
      seq.start(env.agent.sequencer);
      #50;
    phase.drop_objection(this);
  endtask
endclass
