class mem_env extends uvm_env;
  mem_agent      agent;
  mem_scoreboard scoreboard;
  `uvm_component_utils(mem_env)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent      = mem_agent::type_id::create("agent", this);
    scoreboard = mem_scoreboard::type_id::create("scoreboard", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    agent.monitor.item_collected_port.connect(scoreboard.item_collected_export);
  endfunction
endclass
