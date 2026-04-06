module tb_alu;

    reg [31:0] A,B;
    reg [3:0] alu_sel;
    wire [31:0] result;
    wire zero;
    
    alu uut (
        .A(A),
        .B(B),
        .alu_sel(alu_sel),
        .result(result),
        .zero(zero)
    );

    initial begin

        A = 10; B = 5;

        alu_sel = 4'b0000; #10;  // ADD ? 15
        alu_sel = 4'b0001; #10;  // SUB ? 5
        alu_sel = 4'b0010; #10;  // AND
        alu_sel = 4'b0011; #10;  // OR
        alu_sel = 4'b0100; #10;  // SLT

        A = 5; B = 10;
        alu_sel = 4'b0100; #10;  // SLT ? 1

        $finish;
    end

endmodule
