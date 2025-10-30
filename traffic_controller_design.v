// traffic_controller.v
// 2-way traffic light controller with emergency priority
// Synthesis friendly Verilog (works in Vivado/ModelSim)
// Outputs: ns_red, ns_yellow, ns_green, ew_red, ew_yellow, ew_green
// Inputs: clk, rst, emg_ns, emg_ew

module traffic_controller #(
    parameter COUNTER_WIDTH = 32,
    parameter GREEN_TICKS   = 50000000,   // example for 1s @50MHz -> change for FPGA
    parameter YELLOW_TICKS  = 5000000,
    parameter ALLRED_TICKS  = 1000000,
    parameter EMG_GREEN_TICKS = 80000000
)(
    input  wire clk,
    input  wire rst,       // synchronous active-high reset
    input  wire emg_ns,
    input  wire emg_ew,
    output reg  ns_red,
    output reg  ns_yellow,
    output reg  ns_green,
    output reg  ew_red,
    output reg  ew_yellow,
    output reg  ew_green,
    output reg [2:0] state_debug // expose state for waveform/debug
);

    // State encoding
    localparam S_NS_GREEN  = 3'd0;
    localparam S_NS_YELLOW = 3'd1;
    localparam S_ALLRED_1  = 3'd2;
    localparam S_EW_GREEN  = 3'd3;
    localparam S_EW_YELLOW = 3'd4;
    localparam S_ALLRED_2  = 3'd5;
    localparam S_EMG_NS    = 3'd6;
    localparam S_EMG_EW    = 3'd7;

    reg [2:0] state, next_state;
    reg [COUNTER_WIDTH-1:0] timer;

    // Next state (combinational)
    always @(*) begin
        next_state = state;
        case (state)
            S_NS_GREEN: begin
                if (emg_ns) next_state = S_EMG_NS;
                else if (emg_ew) next_state = S_EMG_EW;
                else if (timer >= GREEN_TICKS) next_state = S_NS_YELLOW;
            end
            S_NS_YELLOW: begin
                if (emg_ns) next_state = S_EMG_NS;
                else if (emg_ew) next_state = S_EMG_EW;
                else if (timer >= YELLOW_TICKS) next_state = S_ALLRED_1;
            end
            S_ALLRED_1: begin
                if (emg_ns) next_state = S_EMG_NS;
                else if (emg_ew) next_state = S_EMG_EW;
                else if (timer >= ALLRED_TICKS) next_state = S_EW_GREEN;
            end
            S_EW_GREEN: begin
                if (emg_ew) next_state = S_EMG_EW;
                else if (emg_ns) next_state = S_EMG_NS;
                else if (timer >= GREEN_TICKS) next_state = S_EW_YELLOW;
            end
            S_EW_YELLOW: begin
                if (emg_ew) next_state = S_EMG_EW;
                else if (emg_ns) next_state = S_EMG_NS;
                else if (timer >= YELLOW_TICKS) next_state = S_ALLRED_2;
            end
            S_ALLRED_2: begin
                if (emg_ns) next_state = S_EMG_NS;
                else if (emg_ew) next_state = S_EMG_EW;
                else if (timer >= ALLRED_TICKS) next_state = S_NS_GREEN;
            end
            S_EMG_NS: begin
                // remain in EMG_NS for fixed emergency green duration
                if (timer >= EMG_GREEN_TICKS) next_state = S_ALLRED_1; // safe transition
            end
            S_EMG_EW: begin
                if (timer >= EMG_GREEN_TICKS) next_state = S_ALLRED_2;
            end
            default: next_state = S_NS_GREEN;
        endcase
    end

    // State register and timer (sequential)
    always @(posedge clk) begin
        if (rst) begin
            state <= S_NS_GREEN;
            timer <= 0;
        end else begin
            if (state != next_state) begin
                state <= next_state;
                timer <= 0;
            end else begin
                timer <= timer + 1;
            end
        end
    end

    // Outputs (combinational) and expose debug state
    always @(*) begin
        // default outputs
        ns_red    = 1'b0;
        ns_yellow = 1'b0;
        ns_green  = 1'b0;
        ew_red    = 1'b0;
        ew_yellow = 1'b0;
        ew_green  = 1'b0;
        state_debug = state;

        case (state)
            S_NS_GREEN: begin ns_green = 1; ew_red = 1; end
            S_NS_YELLOW: begin ns_yellow = 1; ew_red = 1; end
            S_ALLRED_1: begin ns_red = 1; ew_red = 1; end
            S_EW_GREEN: begin ew_green = 1; ns_red = 1; end
            S_EW_YELLOW: begin ew_yellow = 1; ns_red = 1; end
            S_ALLRED_2: begin ns_red = 1; ew_red = 1; end
            S_EMG_NS: begin ns_green = 1; ew_red = 1; end
            S_EMG_EW: begin ew_green = 1; ns_red = 1; end
            default: begin ns_red = 1; ew_red = 1; end
        endcase
    end

endmodule
