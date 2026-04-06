module tb_control_unit;

    reg [6:0] opcode;

    wire regwrite, alusrc, memread, memwrite, memtoreg, branch;
    wire [1:0] aluop;

    control_unit uut(
        .opcode(opcode),
        .regwrite(regwrite),
        .alusrc(alusrc),
        .memread(memread),
        .memwrite(memwrite),
        .memtoreg(memtoreg),
        .branch(branch),
        .aluop(aluop)
    );

    initial begin

        opcode = 7'b0110011; #10;  // R-type
        opcode = 7'b0010011; #10;  // ADDI
        opcode = 7'b0000011; #10;  // LW
        opcode = 7'b0100011; #10;  // SW
        opcode = 7'b1100011; #10;  // BEQ

        $finish;
    end
endmodule
