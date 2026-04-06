module tb_imm_gen;

    reg  [31:0] instr;
    wire [31:0] imm_out;

    imm_gen uut (
        .instr(instr),
        .imm_out(imm_out)
    );

    initial begin

        // ADDI x1, x0, 10  (0x00A00093)
        instr = 32'h00A00093;
        #10;

        // SW example
        instr = 32'h00512023;
        #10;

        // BEQ example
        instr = 32'h00208663;
        #10;

        $finish;
    end

endmodule
