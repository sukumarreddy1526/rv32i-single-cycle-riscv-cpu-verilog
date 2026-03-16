`timescale 1ns / 1ps

module regfile(
    input  wire clk,
    input  wire regwrite,
    input  wire [4:0] rs1, 
    input  wire [4:0] rs2,
    input  wire [4:0] rd,
    input  wire [31:0] writedata,
    output wire [31:0] readdata1,
    output wire [31:0] readdata2
);

    reg [31:0] registers [0:31];

    assign readdata1 = (rs1 == 5'b00000) ? 32'b0 : registers[rs1];
    assign readdata2 = (rs2 == 5'b00000) ? 32'b0 : registers[rs2];

    always @(posedge clk) begin
        if (regwrite && (rd != 5'b00000))
            registers[rd] <= writedata;
    end

endmodule
