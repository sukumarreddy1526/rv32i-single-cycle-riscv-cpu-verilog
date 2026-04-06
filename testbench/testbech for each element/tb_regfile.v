module tb_regfile;

    reg clk;
    reg regwrite;
    reg [4:0] rs1, rs2, rd;
    reg [31:0] writedata;
    wire [31:0] readdata1, readdata2;

    regfile uut (
        .clk(clk),
        .regwrite(regwrite),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .writedata(writedata),
        .readdata1(readdata1),
        .readdata2(readdata2)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        regwrite = 1;

        // Write 25 to x5
        rd = 5;
        writedata = 32'd25;
        #10;

        // Read x5
        regwrite = 0;
        rs1 = 5;
        #10;

        // Try writing to x0 (should not change)
        regwrite = 1;
        rd = 0;
        writedata = 32'd100;
        #10;

        rs1 = 0;
        #10;

        $finish;
    end

endmodule
