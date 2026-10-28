module mem (
    mem_if.dut mif
);
    
    mem_data mem_arr [`AWIDTH-1:0];

    always_ff @( posedge mif.clk or negedge mif.rst_n ) begin
        
        if (!mif.rst_n) begin
            mem_arr <= '{default: 0};
            mif.rdata <= 0;
        end
        else if (mif.wr_en) begin
            mem_arr[mif.addr] <= mif.wdata;
        end
        else if (mif.rd_en) begin
            mif.rdata <= mem_arr[mif.addr];
        end

    end

endmodule