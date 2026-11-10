`ifndef MEM_TEST_ALL_RANDOM_SEQ_SV
    `define MEM_TEST_ALL_RANDOM_SEQ_SV

    class mem_test_all_random_seq extends mem_test_base;
        
        `uvm_component_utils(mem_test_all_random_seq)

        function new(string name = "", uvm_component parent);
            super.new(name, parent);
        endfunction //new()

        virtual task run_phase(uvm_phase phase);

            phase.raise_objection(this, "TEST DONE");
            `uvm_info("TEST STATUS", "This is the start of the test", UVM_LOW)

            repeat(`TEST_NUM) begin

                fork
                    begin
                        mem_sequence_reset reset_seq;
                        reset_seq = mem_sequence_reset::type_id::create("reset_seq");
                        reset_seq.set_reset_probability(`RESET_PROBAB);
                        reset_seq.start(env.agent.sequencer);
                    end

                    begin
                        case ($urandom_range(0, 2))
                            0 : begin
                                    mem_sequence_wr seq;
                                    seq = mem_sequence_wr::type_id::create("seq");
                                    seq.start(env.agent.sequencer);
                                end
                            1 : begin
                                    mem_sequence_overwrite seq;
                                    seq = mem_sequence_overwrite::type_id::create("seq");
                                    seq.start(env.agent.sequencer);                    
                                end
                            2 : begin
                                    mem_sequence_random seq;
                                    seq = mem_sequence_random::type_id::create("seq");
                                    seq.start(env.agent.sequencer);
                                end
                        endcase                
                    end
                join

            end

            `uvm_info("TEST STATUS", "This is the end of the test", UVM_LOW)
            phase.drop_objection(this, "TEST DONE");
        endtask

    endclass //mem_test_reg_access extends mem_test_base

`endif