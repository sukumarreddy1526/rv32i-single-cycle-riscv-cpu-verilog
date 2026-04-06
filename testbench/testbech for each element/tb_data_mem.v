module tb_data_mem;

    reg clk;
    reg memread;
    reg memwrite;
    reg [31:0] addr;
    reg [31:0] writedata;
    wire [31:0] readdata;

    data_mem uut (
        .clk(clk),
        .memread(memread),
        .memwrite(memwrite),
        .addr(addr),
        .writedata(writedata),
        .readdata(readdata)
    );

    always #5 clk = ~clk;

    initial begin
        $display("Starting Data Memory Test...");
        
        clk = 0;
        memread = 0;
        memwrite = 0;
        addr = 0;
        writedata = 0;

        #10;
        addr = 32'd4; 
        writedata = 32'd123;
        memwrite = 1;
        #10;
        memwrite = 0;

        #10;
        memread = 1;
        #10;
        $display("Read Data = %d (Expected 123)", readdata);
        memread = 0;

        #10;
        addr = 32'd8;
        writedata = 32'd999;
        memwrite = 1;
        #10;
        memwrite = 0;

        #10;
        memread = 1;
        #10;
        $display("Read Data = %d (Expected 999)", readdata);
        memread = 0;

        #10;
        memread = 0;
        #10;
        $display("Read Disabled Data = %d (Expected 0)", readdata);

        $display("Data Memory Test Finished.");
        $finish;
    end

endmodule
