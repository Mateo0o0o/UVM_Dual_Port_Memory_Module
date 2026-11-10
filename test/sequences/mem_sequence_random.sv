`ifndef MEM_SEQUENCE_RANDOM_SV
    `define MEM_SEQUENCE_RANDOM_SV

    class mem_sequence_random extends mem_sequence_base;
        
        `uvm_object_utils(mem_sequence_random)
        
        function new(string name = "");
            super.new(name);
        endfunction //new()

        virtual task body();
            repeat(iterations) begin
                item = mem_item::type_id::create("item");
                item.rst_n = 1;
                `uvm_do(item)
            end
        endtask

    endclass //mem_sequence extends uvm_sequencer

`endif