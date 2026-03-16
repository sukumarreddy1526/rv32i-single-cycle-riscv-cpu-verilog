`timescale 1ns / 1ps

module data_mem(
    input  wire clk,
    input  wire memread,
    input  wire memwrite,
    input  wire [31:0] addr,
    input  wire [31:0] writedata,
    output reg  [31:0] readdata
);

    //(* ram_style = "block" *) 
    reg [31:0] memory [0:255];

    always @(posedge clk) begin
        if (memwrite)
            memory[addr[9:2]] <= writedata;
    end

    always @(*) begin
        if (memread)
            readdata = memory[addr[9:2]];
        else
            readdata = 32'b0;
    end

endmodule
