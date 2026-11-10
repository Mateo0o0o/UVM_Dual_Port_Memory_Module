`ifndef MEM_SEQUENCE_WR_SV
    `define MEM_SEQUENCE_WR_SV

    class mem_sequence_wr extends mem_sequence_base;
        
        `uvm_object_utils(mem_sequence_wr)
        
        local mem_addr addr;

        function new(string name = "");
            super.new(name);
        endfunction //new()

        virtual task body();
            repeat(iterations) begin
                item = mem_item::type_id::create("item");

                item.rst_n = 1;

                // Writes to an address and saves that address
                `uvm_do_with(item, {item.wr_en == 1;})
                addr = item.addr;

                // Reads the saved address
                `uvm_do_with(item, {
                    item.wr_en == 0; 
                    item.rd_en == 1; 
                    item.addr == local::addr;
                    })
            end
        endtask

    endclass //mem_sequence extends uvm_sequencer

`endif