// tb_traffic.v
`timescale 1ns/1ps
module tb_traffic;
    reg clk = 0;
    reg rst = 1;
    reg emg_ns = 0;
    reg emg_ew = 0;

    // Instantiate DUT with short simulated timings (for quick sim)
    traffic_controller #(
        .COUNTER_WIDTH(20),    // small for simulation
        .GREEN_TICKS(50),      // 50 cycles ~ visible in waveform
        .YELLOW_TICKS(12),
        .ALLRED_TICKS(6),
        .EMG_GREEN_TICKS(80)
    ) dut (
        .clk(clk),
        .rst(rst),
        .emg_ns(emg_ns),
        .emg_ew(emg_ew),
        .ns_red(),
        .ns_yellow(),
        .ns_green(),
        .ew_red(),
        .ew_yellow(),
        .ew_green(),
        .state_debug()
    );

    // Expose signals to testbench scope to add to waveform easily
    wire ns_red   = dut.ns_red;
    wire ns_yellow= dut.ns_yellow;
    wire ns_green = dut.ns_green;
    wire ew_red   = dut.ew_red;
    wire ew_yellow= dut.ew_yellow;
    wire ew_green = dut.ew_green;
    wire [2:0] state_debug = dut.state_debug;

    // clock generation
    always #5 clk = ~clk; // 10ns period (100MHz scale)

    initial begin
        // VCD for Vivado / Icarus
        $dumpfile("traffic.vcd");
        $dumpvars(0, tb_traffic);

        // ModelSim: $vcdplusfile("traffic.vpd"); $vcdpluson;  -- optional

        // initial reset
        #12;
        rst = 0;

        // let normal cycles run for a while
        #1000;

        // Trigger emergency EW
        $display("%0t : assert EMG_EW", $time);
        emg_ew = 1;
        #150;
        emg_ew = 0;
        $display("%0t : deassert EMG_EW", $time);

        // more normal cycles
        #500;

        // Trigger emergency NS
        $display("%0t : assert EMG_NS", $time);
        emg_ns = 1;
        #120;
        emg_ns = 0;
        $display("%0t : deassert EMG_NS", $time);

        // final run
        #500;
        $display("%0t : Simulation finished", $time);
        $finish;
    end
endmodule
