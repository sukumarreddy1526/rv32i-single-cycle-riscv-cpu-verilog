`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.03.2026 15:12:53
// Design Name: 
// Module Name: pc
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module pc(
    input wire clk,
    input wire reset,
    input wire [31:0] pc_next,
    output reg [31:0] pc_out
    );
    always@(posedge clk)
    begin
    if(reset)
        pc_out <= 32'b0;
    else
        pc_out <= pc_next;
    end
endmodule
