`ifndef MEM_TEST_WR_SV
    `define MEM_TEST_WR_SV

    class mem_test_wr extends mem_test_base;
        
        `uvm_component_utils(mem_test_wr)

        function new(string name = "", uvm_component parent);
            super.new(name, parent);
        endfunction //new()

        virtual task run_phase(uvm_phase phase);

            phase.raise_objection(this, "TEST DONE");
            `uvm_info("DEBUG", "This is the start of the test", UVM_LOW)

            fork
                begin
                    mem_sequence_reset reset_seq;
                    reset_seq = mem_sequence_reset::type_id::create("reset_seq");
                    reset_seq.set_iterations(`TEST_NUM);
                    reset_seq.set_reset_probability(`RESET_PROBAB);
                    reset_seq.start(env.agent.sequencer);
                end

                begin
                    mem_sequence_wr seq;
                    seq = mem_sequence_wr::type_id::create("seq");
                    seq.set_iterations(`TEST_NUM);
                    seq.start(env.agent.sequencer);
                end
            join


            `uvm_info("DEBUG", "This is the end of the test", UVM_LOW)
            phase.drop_objection(this, "TEST DONE");
        endtask

    endclass //mem_test_reg_access extends mem_test_base

`endif