`ifndef MEM_SEQUENCE_RANDOM_SV
    `define MEM_SEQUENCE_RANDOM_SV

    class mem_sequence_random extends mem_sequence_base;
        
        `uvm_object_utils(mem_sequence_random)

        mem_sequence_reset reset_seq;
        
        function new(string name = "");
            super.new(name);
        endfunction //new()

        virtual task body();
            repeat(`TEST_NUM) begin
                item = mem_item::type_id::create("item");
                reset_seq = mem_sequence_reset::type_id::create("reset_seq");

                fork
                    `uvm_do(reset_seq)
                    item.rst_n = 1;
                    `uvm_do(item)
                join
                
                    // start_item(item);
                    // assert(item.randomize());
                    // finish_item(item); 
            end
        endtask

    endclass //mem_sequence extends uvm_sequencer

`endif