class mem_sequence_base extends uvm_sequence#(mem_item);
    
    mem_item item;

    `uvm_object_utils(mem_sequence_base)
    
    function new(string name = "");
        super.new(name);        
    endfunction //new()
    
endclass //mem_sequence_base extends uvm_sequence_item