`timescale 1ns / 1p

module instr_mem (
    input  wire [31:0] addr,     
    output wire [31:0] instruction 
    );

    //(* ram_style = "block" *) 
    reg [31:0] memory [0:255];

    initial begin
        $readmemh("program.mem", memory);
        $display("Instruction memory loaded.");
    end
    assign instruction = memory[addr[9:2]];

endmodule
