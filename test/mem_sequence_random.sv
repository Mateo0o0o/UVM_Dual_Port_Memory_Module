`ifndef MEM_SEQUENCE_RANDOM_SV
    `define MEM_SEQUENCE_RANDOM_SV

    class mem_sequence_random extends mem_sequence_base;
        
        `uvm_object_utils(mem_sequence_random)
        
        function new(string name = "");
            super.new(name);
        endfunction //new()

        virtual task body();
            repeat(`TEST_NUM) begin
                item = mem_item::type_id::create("item");
                start_item(item);
                assert(item.randomize());
                `uvm_info(get_type_name(), "Driving", UVM_NONE)
                finish_item(item); 
            end
        endtask

    endclass //mem_sequence extends uvm_sequencer

`endif