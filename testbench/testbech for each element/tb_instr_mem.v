module tb_instr_mem;

    reg  [31:0] addr;
    wire [31:0] instruction;

    instr_mem uut (
        .addr(addr),
        .instruction(instruction)
    );

    initial begin
        addr = 0;        
        #10 addr = 4;   
        #10 addr = 8;
        #10 addr = 12;
        #10 addr = 16;
        #20 $finish;
    end

endmodule
