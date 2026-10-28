module tb;
    
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import mem_test_pkg::*;
    // Clock Signal
    bit clk;

    // Memory Module Interface
    mem_if memif(clk);

    // DUT
    mem dut (memif);

    // Clock Generator
    always clk = #5 ~clk;

    initial begin
                        memif.rst_n = 1;
        @(negedge clk)  memif.rst_n = 0;
        @(negedge clk)  memif.rst_n = 1;
    end

    initial begin
        $dumpfile("mem.fst");
        $dumpvars;

        uvm_config_db#(mem_vif)::set(null, "uvm_test_top*", "vif", memif);

        run_test("");
    end

endmodule