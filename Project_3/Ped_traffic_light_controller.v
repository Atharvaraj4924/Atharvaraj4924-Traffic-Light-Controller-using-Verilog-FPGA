`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/01/2026 08:09:53 PM
// Design Name: 
// Module Name: traffic_light_controller_ped
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

module traffic_light_controller_ped (
    input wire clk,          
    input wire rst,          
    input wire ped_request,  
    output reg [2:0] main_road, 
    output reg [2:0] side_road  
);

    
    parameter GREEN      = 3'b000;
    parameter YELLOW     = 3'b001;
    parameter RED        = 3'b010;
    parameter RED_YELLOW = 3'b011;
    parameter PED_WALK   = 3'b100; 

   
    parameter SEC_GREEN      = 7;
    parameter SEC_YELLOW     = 3;
    parameter SEC_RED        = 7;
    parameter SEC_RED_YELLOW = 2;
    parameter SEC_PED_WALK   = 5;  

    reg [2:0] current_state, next_state;
    reg [3:0] timer;
    reg ped_pending; 

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
            ped_pending <= 1'b0;
        end else begin
            if (current_state == GREEN && ped_request) begin
                ped_pending <= 1'b1; 
            end else if (current_state == PED_WALK) begin
                ped_pending <= 1'b0; 
            end
        end
    end
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            current_state <= GREEN;
            timer <= SEC_GREEN;
        end else if (clk_1hz_tick) begin
            if (timer == 1) begin
                current_state <= next_state;
              
                case (next_state)
                    GREEN:      timer <= SEC_GREEN;
                    YELLOW:     timer <= SEC_YELLOW;
                    RED:        timer <= SEC_RED;
                    RED_YELLOW: timer <= SEC_RED_YELLOW;
                    PED_WALK:   timer <= SEC_PED_WALK;
                    default:    timer <= SEC_GREEN;
                endcase
            end else begin
                timer <= timer - 1;
            end
        end
    end

    // 4. Next State Combinational Logic with Pedestrian Insertion [cite: 17, 18]
    always @(*) begin
        case (current_state)
            GREEN: begin
                // When Green finishes, look to see if a pedestrian requested a crossing [cite: 17]
                if (ped_pending)
                    next_state = PED_WALK; 
                else
                    next_state = YELLOW;
            end
            PED_WALK:   next_state = YELLOW; // Route back into standard cycle 
            YELLOW:     next_state = RED;
            RED:        next_state = RED_YELLOW;
            RED_YELLOW: next_state = GREEN;
            default:    next_state = GREEN;
        endcase
    end

    // 5. Output Encoding Logic [cite: 13]
    always @(*) begin
        // Defaults
        main_road = 3'b100; // Red
        side_road = 3'b100; // Red

        case (current_state)
            GREEN: begin
                main_road = 3'b001; // Main: Green
                side_road = 3'b100; // Side: Red [cite: 13]
            end
            YELLOW: begin
                main_road = 3'b010; // Main: Yellow
                side_road = 3'b100; // Side: Red [cite: 13]
            end
            PED_WALK: begin
                main_road = 3'b100; // Main: Red [cite: 17]
                side_road = 3'b100; // Side: Red (Safe pedestrian crossing zone)
            end
            RED: begin
                main_road = 3'b100; // Main: Red
                side_road = 3'b001; // Side: Green [cite: 13]
            end
            RED_YELLOW: begin
                main_road = 3'b100; // Main: Red
                side_road = 3'b010; // Side: Yellow [cite: 13]
            end
        endcase
    end

endmodule
