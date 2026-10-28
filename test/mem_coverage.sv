`ifndef MEM_COVERAGE_SV
    `define MEM_COVERAGE_SV

    class mem_coverage extends uvm_subscriber#(mem_item);
        
        `uvm_component_utils(mem_coverage)

        covergroup mem_transaction;
            coverpoint trans.addr;
            coverpoint trans.wdata;
            coverpoint trans.wr_en;
            coverpoint trans.rd_en;
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