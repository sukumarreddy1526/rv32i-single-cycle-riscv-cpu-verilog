module tb_alu_control;

    reg [1:0] aluop;
    reg [2:0] funct3;
    reg [6:0] funct7;
    wire [3:0] alu_sel;

    alu_control uut(
        .aluop(aluop),
        .funct3(funct3),
        .funct7(funct7),
        .alu_sel(alu_sel)
    );

    initial begin

        // LW
        aluop = 2'b00; #10;

        // BEQ
        aluop = 2'b01; #10;

        // ADD
        aluop = 2'b10;
        funct3 = 3'b000;
        funct7 = 7'b0000000;
        #10;

        // SUB
        funct7 = 7'b0100000;
        #10;

        // AND
        funct3 = 3'b111;
        #10;

        // OR
        funct3 = 3'b110;
        #10;

        // SLT
        funct3 = 3'b010;
        #10;

        $finish;
    end

endmodule
