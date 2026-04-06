module tb_cpu_top;

    reg clk;
    reg reset;

    cpu_top uut (
        .clk(clk),
        .reset(reset)
    );
  
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;

        $display("===== CPU WAVEFORM TEST STARTED =====");

        #20;
        reset = 0;

        #300;

        $display("----- FINAL REGISTER VALUES -----");
        $display("x1 = %d", uut.RF.registers[1]);
        $display("x2 = %d", uut.RF.registers[2]);
        $display("x3 = %d", uut.RF.registers[3]);
        $display("x4 = %d", uut.RF.registers[4]);
        $display("----------------------------------");

        $finish;
    end

    always @(posedge clk) begin
        if (!reset) begin
            $display("Time=%0t | PC=%h | Instr=%h | x1=%d x2=%d x3=%d",
                     $time,
                     uut.pc_out,
                     uut.instruction,
                     uut.RF.registers[1],
                     uut.RF.registers[2],
                     uut.RF.registers[3]);
        end
    end

endmodule
