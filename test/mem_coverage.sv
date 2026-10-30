`ifndef MEM_COVERAGE_SV
    `define MEM_COVERAGE_SV

    class mem_coverage extends uvm_subscriber#(mem_item);
        
        `uvm_component_utils(mem_coverage)

        covergroup mem_transaction;
            coverpoint trans.rst_n {
                bins rst_0 = {0};
            }
            coverpoint trans.addr iff (trans.rst_n) {
                bins low_addr   = {[0               : (2**`AWIDTH/2)-1]};
                bins high_addr  = {[(2**`AWIDTH/2)  : (2**`AWIDTH)  -1]};
                bins all0_addr  = {0};
                bins all1_addr  = {{`AWIDTH{1}}};
            }
            coverpoint trans.wdata iff (trans.rst_n);
            write_c : coverpoint trans.wr_en iff (trans.rst_n);
            read_c  : coverpoint trans.rd_en iff (trans.rst_n);
            write_x_read : cross write_c, read_c;
        endgroup

        mem_item trans;

        function new(string name = "", uvm_component parent);
            super.new(name, parent);
            mem_transaction = new();
        endfunction //new()

        virtual function void write (mem_item t);
            trans = t;
            mem_transaction.sample();
        endfunction

    endclass //mem_coverage extends uvm_coverage#(mem_item)

`endif