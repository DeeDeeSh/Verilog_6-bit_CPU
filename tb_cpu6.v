`timescale 1ns/1ps

module tb_cpu6;

    reg clk;
    wire [5:0] acc_out;

    cpu6 dut (
        .clk(clk),
        .acc_out(acc_out)
    );

    // clock
    always #5 clk = ~clk;

    initial begin
        clk = 0;

        #3000;   // let CPU run

        $display("FINAL: PC=%0d ACC=%0d LED=%b",
                 dut.pc, dut.acc, acc_out);

        $finish;
    end

    initial begin
        $monitor("t=%0t | PC=%0d | ACC=%0d | LED=%b",
                 $time, dut.pc, dut.acc, acc_out);
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_cpu6);
    end

endmodule
