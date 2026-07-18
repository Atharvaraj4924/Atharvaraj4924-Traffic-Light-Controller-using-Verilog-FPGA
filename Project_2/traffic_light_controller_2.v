`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/01/2026 07:46:55 PM
// Design Name: 
// Module Name: traffic_light_controller
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module traffic_light_controller (
    input wire clk,          
    input wire rst,          
    output reg [2:0] main_road, 
    output reg [2:0] side_road  
);

    
    parameter GREEN      = 2'b00;
    parameter YELLOW     = 2'b01;
    parameter RED        = 2'b10;
    parameter RED_YELLOW = 2'b11;

    
    parameter SEC_GREEN      = 7;
    parameter SEC_YELLOW     = 3;
    parameter SEC_RED        = 7;
    parameter SEC_RED_YELLOW = 2;

    reg [1:0] current_state, next_state;
    reg [3:0] timer;

    
    reg [26:0] clk_counter;
    wire clk_1hz_tick;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            clk_counter <= 0;
        end else if (clk_counter == 99_99_999) begin
            clk_counter <= 0;
        end else begin
            clk_counter <= clk_counter + 1;
        end
    end

    assign clk_1hz_tick = (clk_counter == 99_99_999);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            current_state <= GREEN;
            timer <= SEC_GREEN;
        end else if (clk_1hz_tick) begin
            if (timer == 1) begin
                current_state <= next_state;
                // Pre-load timer for the next state
                case (next_state)
                    GREEN:      timer <= SEC_GREEN;
                    YELLOW:     timer <= SEC_YELLOW;
                    RED:        timer <= SEC_RED;
                    RED_YELLOW: timer <= SEC_RED_YELLOW;
                    default:    timer <= SEC_GREEN;
                endcase
            end else begin
                timer <= timer - 1;
            end
        end
    end

    // 3. Next State Combinational Logic
    always @(*) begin
        case (current_state)
            GREEN:      next_state = YELLOW;
            YELLOW:     next_state = RED;
            RED:        next_state = RED_YELLOW;
            RED_YELLOW: next_state = GREEN;
            default:    next_state = GREEN;
        endcase
    end

    // 4. Output Encoding Logic (LED indicators)
    always @(*) begin
        // Default outputs
        main_road = 3'b100; // Red default
        side_road = 3'b100; // Red default

        case (current_state)
            GREEN: begin
                main_road = 3'b001; // Main: Green
                side_road = 3'b100; // Side: Red
            end
            YELLOW: begin
                main_road = 3'b010; // Main: Yellow
                side_road = 3'b100; // Side: Red
            end
            RED: begin
                main_road = 3'b100; // Main: Red
                side_road = 3'b001; // Side: Green
            end
            RED_YELLOW: begin
                main_road = 3'b100; // Main: Red
                side_road = 3'b010; // Side: Yellow
            end
        endcase
    end

endmodule
