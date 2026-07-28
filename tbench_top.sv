`include "uvm_macros.svh"
import uvm_pkg::*;

`include "mem_if.sv"
`include "mem_seq_item.sv"
`include "mem_sequence.sv"
`include "mem_sequencer_item.sv"
`include "mem_driver.sv"
`include "mem_monitor.sv"
`include "mem_agent.sv"
`include "mem_scoreboard.sv"
`include "mem_env.sv"
`include "mem_base.sv"

module tbench_top;
  bit clk;
  bit reset;
  always #5 clk = ~clk;
  initial begin reset = 1; #5 reset = 0; end

  mem_if intf(clk, reset);

  memory DUT (
    .clk(intf.clk), .reset(intf.reset),
    .addr(intf.addr), .wr_en(intf.wr_en), .rd_en(intf.rd_en),
    .wdata(intf.wdata), .rdata(intf.rdata)
  );

  initial begin
    uvm_config_db#(virtual mem_if)::set(null, "*", "vif", intf);
  end

  initial run_test();
endmodule
