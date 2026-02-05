`include "FIFO.v"
`timescale 1ps/1ps
module FIFO_tb;

    reg clk;
    reg rst;
    reg write_enable;
    reg read_enable;
    reg [7:0] din;

    wire [7:0] dout;
    wire fifo_full;
    wire fifo_empty;

    // Instantiate FIFO
    FIFO dut (
        .clk(clk),
        .rst(rst),
        .write_enable(write_enable),
        .read_enable(read_enable),
        .din(din),
        .dout(dout),
        .fifo_full(fifo_full),
        .fifo_empty(fifo_empty)
    );

    // Clock generation (10 time units period)
    always #5 clk = ~clk;

    initial begin
         $monitor(
            "TIME=%0t | WE=%b RE=%b DIN=%h DOUT=%h FULL=%b EMPTY=%b",
            $time, write_enable, read_enable, din, dout, fifo_full, fifo_empty
        );
        // Initialize
        clk = 0;
        rst = 1;
        write_enable = 0;
        read_enable  = 0;
        din = 8'h00;

        // Reset
        #10 rst = 0;

        // Write 4 values into FIFO
        #10 write_enable = 1; din = 8'h11;
        #10 din = 8'h22;
        #10 din = 8'h33;
        #10 din = 8'h44;
        #10 write_enable = 0;

        // Read 4 values from FIFO
        #10 read_enable = 1;
        #40 read_enable = 0;
        #20 $finish;
    end
    initial begin
        $dumpfile("fifo.vcd");
        $dumpvars(0, FIFO_tb);
    end


endmodule