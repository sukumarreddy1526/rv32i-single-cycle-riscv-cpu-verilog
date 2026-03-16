`timescale 1ns / 1ps

module cpu_top(
    input wire clk,
    input wire reset,

    output wire [31:0] pc_debug,
    output wire [31:0] instr_debug,
    output wire [31:0] alu_debug
);

    wire [31:0] pc_out;
    wire [31:0] pc_next;
    wire [31:0] pc_plus4;
    wire [31:0] branch_target;

    pc PC(
        .clk(clk),
        .reset(reset),
        .pc_next(pc_next),
        .pc_out(pc_out)
    );

    assign pc_plus4 = pc_out + 32'd4;

    wire [31:0] instruction;

    instr_mem IM(
        .addr(pc_out),
        .instruction(instruction)
    );

    wire [6:0] opcode  = instruction[6:0];
    wire [4:0] rd      = instruction[11:7];
    wire [2:0] funct3  = instruction[14:12];
    wire [4:0] rs1     = instruction[19:15];
    wire [4:0] rs2     = instruction[24:20];
    wire [6:0] funct7  = instruction[31:25];

    wire regwrite, alusrc, memtoreg;
    wire memread, memwrite, branch;
    wire [1:0] aluop;

    control_unit CU(
        .opcode(opcode),
        .regwrite(regwrite),
        .alusrc(alusrc),
        .memtoreg(memtoreg),
        .memread(memread),
        .memwrite(memwrite),
        .branch(branch),
        .aluop(aluop)
    );

    wire [31:0] readdata1, readdata2;
    wire [31:0] writeback_data;

    regfile RF(
        .clk(clk),
        .regwrite(regwrite),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .writedata(writeback_data),
        .readdata1(readdata1),
        .readdata2(readdata2)
    );

    wire [31:0] imm_out;

    imm_gen IG(
        .instruction(instruction),
        .imm_out(imm_out)
    );

    wire [3:0] alu_sel;

    alu_control ALUCTL(
        .aluop(aluop),
        .funct3(funct3),
        .funct7(funct7),
        .alu_sel(alu_sel)
    );

    wire [31:0] alu_input2;
    wire [31:0] alu_result;
    wire zero;

    assign alu_input2 = (alusrc) ? imm_out : readdata2;

    alu ALU(
        .A(readdata1),
        .B(alu_input2),
        .alu_sel(alu_sel),
        .result(alu_result),
        .zero(zero)
    );

    wire branch_taken;

    assign branch_taken =
        (funct3 == 3'b000 &&  zero) ||                                      // BEQ
        (funct3 == 3'b001 && !zero) ||                                      // BNE
        (funct3 == 3'b100 && ($signed(readdata1) <  $signed(readdata2))) || // BLT
        (funct3 == 3'b101 && ($signed(readdata1) >= $signed(readdata2))) || // BGE
        (funct3 == 3'b110 && (readdata1 <  readdata2)) ||                   // BLTU
        (funct3 == 3'b111 && (readdata1 >= readdata2));                     // BGEU

    wire [31:0] mem_readdata;

    data_mem DM(
        .clk(clk),
        .memwrite(memwrite),
        .memread(memread),
        .addr(alu_result),
        .writedata(readdata2),
        .readdata(mem_readdata)
    );

    assign writeback_data = (memtoreg) ? mem_readdata : alu_result;

    assign branch_target = pc_out + imm_out;

    assign pc_next = (branch && branch_taken) ? branch_target : pc_plus4;

    assign pc_debug   = pc_out;
    assign instr_debug = instruction;
    assign alu_debug  = alu_result;

endmodule
