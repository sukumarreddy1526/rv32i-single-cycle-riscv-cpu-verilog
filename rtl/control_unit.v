`timescale 1ns / 1ps

module control_unit(
    input  wire [6:0] opcode,

    output reg regwrite,
    output reg alusrc,
    output reg memtoreg,
    output reg memread,
    output reg memwrite,
    output reg branch,
    output reg [1:0] aluop
);

    always @(*) begin

        regwrite = 0;
        alusrc   = 0;
        memtoreg = 0;
        memread  = 0;
        memwrite = 0;
        branch   = 0;
        aluop    = 2'b00;

        case (opcode)
            // R-Type (ADD, SUB, AND, OR, SLT)
            7'b0110011: begin
                regwrite = 1;
                alusrc   = 0;
                memtoreg = 0;
                aluop    = 2'b10;
            end
            // I-Type (ADDI)
            7'b0010011: begin
                regwrite = 1;
                alusrc   = 1;
                memtoreg = 0;
                aluop    = 2'b10;
            end
            // LW
            7'b0000011: begin
                regwrite = 1;
                alusrc   = 1;
                memtoreg = 1;
                memread  = 1;
                aluop    = 2'b00;
            end
            // SW
            7'b0100011: begin
                alusrc   = 1;
                memwrite = 1;
                aluop    = 2'b00;
            end
            // BEQ
            7'b1100011: begin
                branch = 1;
                aluop  = 2'b01;
            end
            default: begin
                // keep safe defaults
            end

        endcase
    end

endmodule
