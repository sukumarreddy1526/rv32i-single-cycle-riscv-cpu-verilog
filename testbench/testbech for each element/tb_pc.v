module tb_pc;

    reg clk;
    reg reset;
    reg [31:0] pc_next;
    wire [31:0] pc_out;

    pc uut (
        .clk(clk),
        .reset(reset),
        .pc_next(pc_next),
        .pc_out(pc_out)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        pc_next = 32'd4;

        #10;
        reset = 0;

        #10 pc_next = 32'd8;
        #10 pc_next = 32'd12;
        #10 pc_next = 32'd16;

        #20;
        $finish;
    end

endmodule
