`timescale 1ns / 1ps

module alu_control(
    input wire [1:0] aluop,
    input wire [2:0] funct3,
    input wire [6:0] funct7,
    output reg  [3:0] alu_sel
);

    always @(*) begin

        case (aluop)

            // 00 ? LW, SW ? ADD
            2'b00: alu_sel = 4'b0000;

            // 01 ? BEQ ? SUB
            2'b01: alu_sel = 4'b0001;

            // 10 ? R-type / I-type
            2'b10: begin
                case (funct3)

                    3'b000: begin
                        if (funct7 == 7'b0100000)
                            alu_sel = 4'b0001;   // SUB
                        else
                            alu_sel = 4'b0000;   // ADD / ADDI
                    end

                    3'b111: alu_sel = 4'b0010;   // AND / ANDI
                    3'b110: alu_sel = 4'b0011;   // OR  / ORI
                    3'b100: alu_sel = 4'b0100;   // XOR / XORI
                    3'b001: alu_sel = 4'b0101;   // SLL / SLLI

                    3'b101: begin
                        if (funct7 == 7'b0100000)
                            alu_sel = 4'b0111;   // SRA / SRAI
                        else
                            alu_sel = 4'b0110;   // SRL / SRLI
                    end

                    3'b010: alu_sel = 4'b1000;   // SLT / SLTI
                    3'b011: alu_sel = 4'b1001;   // SLTU / SLTIU

                    default: alu_sel = 4'b0000;
                endcase
            end

            default: alu_sel = 4'b0000;

        endcase
    end

endmodule
