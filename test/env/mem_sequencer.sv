`ifndef MEM_SEQUENCER_SV
    `define MEM_SEQUENCER_SV

    class mem_sequencer extends uvm_sequencer#(mem_item);
        
        `uvm_component_utils(mem_sequencer)

        function new();
            
        endfunction //new()
    endclass //mem_sequencer extends uvm_sequencer

`endif