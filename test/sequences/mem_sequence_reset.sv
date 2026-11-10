`ifndef MEM_SEQUENCE_RESET_SV
    `define MEM_SEQUENCE_RESET_SV

    class mem_sequence_reset extends mem_sequence_base;

        `uvm_object_utils(mem_sequence_reset)

        local int reset_one_out_of_n_chance = 20; 

        function new(string name = "");
            super.new(name);
        endfunction //new()

        function void set_reset_probability(int n);
            reset_one_out_of_n_chance = n;
        endfunction

        virtual task body();
            repeat(iterations) begin
                if ($urandom_range(reset_one_out_of_n_chance) == 0) begin
                    item = mem_item::type_id::create("item");
                    start_item(item);
                    item.rst_n = 0;
                    finish_item(item);
                    `uvm_info(get_type_name(), "RESETTING", UVM_HIGH)
                end
            end
        endtask

    endclass //mem_sequence_reset extends uvm_sequence#(mem_item item)



`endif