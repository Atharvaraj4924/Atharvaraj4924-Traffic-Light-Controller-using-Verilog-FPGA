`timescale 1ns / 1ps

module traffic_light(
    input clk, rst,
    output reg RED, YELLOW, GREEN
);

    // Clock Divider (100 MHz -> 1 Hz)
    reg [26:0] count = 0;
    reg slow_clk = 0;

    always @(posedge clk or posedge rst) begin
        if (rst) begin count <= 0; slow_clk <= 0; end
        else if (count == 49_999_999) begin count <= 0; slow_clk <= ~slow_clk; end
        else count <= count + 1;
    end

    // FSM States
    localparam GREEN_ST = 2'b00, YELLOW_ST = 2'b01, RED_ST = 2'b10;
    reg [1:0] state = GREEN_ST;
    reg [3:0] timer = 0;

    // FSM & Output Logic
    always @(posedge slow_clk or posedge rst) begin
        if (rst) begin
            state <= GREEN_ST; timer <= 0;
            {RED, YELLOW, GREEN} <= 3'b001;
        end else begin
            timer <= timer + 1;
            case (state)
                GREEN_ST:  if (timer == 5) begin state <= YELLOW_ST; timer <= 0; end
                YELLOW_ST: if (timer == 2) begin state <= RED_ST;    timer <= 0; end
                RED_ST:    if (timer == 5) begin state <= GREEN_ST;  timer <= 0; end
                default:   begin state <= GREEN_ST;  timer <= 0; end
            endcase

            // Drive outputs based on the next/current state
            case (state)
                GREEN_ST:  {RED, YELLOW, GREEN} <= 3'b001;
                YELLOW_ST: {RED, YELLOW, GREEN} <= 3'b010;
                RED_ST:    {RED, YELLOW, GREEN} <= 3'b100;
                default:   {RED, YELLOW, GREEN} <= 3'b001;
            endcase
        end
    end
endmodule
