`ifndef MEM_TEST_RANDOM_SV
    `define MEM_TEST_RANDOM_SV

    class mem_test_random extends mem_test_base;
        
        `uvm_component_utils(mem_test_random)

        function new(string name = "", uvm_component parent);
            super.new(name, parent);
        endfunction //new()

        virtual task run_phase(uvm_phase phase);

            phase.raise_objection(this, "TEST DONE");
            `uvm_info("DEBUG", "This is the start of the test", UVM_LOW)

            begin
                mem_sequence_random seq;
                seq = mem_sequence_random::type_id::create("seq");
                seq.set_iterations(`TEST_NUM);
                seq.start(env.agent.sequencer);
            end

            `uvm_info("DEBUG", "This is the end of the test", UVM_LOW)
            phase.drop_objection(this, "TEST DONE");
        endtask

    endclass //mem_test_reg_access extends mem_test_base

`endif