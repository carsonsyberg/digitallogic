module lab1_1(SW, LEDR, KEY, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

    input [7:0] SW;
    input [1:0] KEY;
    output reg [7:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
    output reg [9:0] LEDR;

    always @(KEY[1]) begin
        if(~KEY[1]) begin
            HEX0 <= 8'b10011000; // 9
            HEX1 <= 8'b10011000; // 9
            HEX2 <= 8'b10011001; // 4
            HEX3 <= 8'b11000000; // 0
            HEX4 <= 8'b10100100; // 2
            HEX5 <= 8'b11111001; // 1
        end
        else begin
            HEX0 <= 8'b11000000; // 0   off 8'b11111111
            HEX1 <= 8'b11000000; // 0
            HEX2 <= 8'b10000000; // 8
            HEX3 <= 8'b11000000; // 0
            HEX4 <= 8'b10010010; // 5
            HEX5 <= 8'b11000000; // 0
        end
    end

    always @(KEY[0]) begin
        if(KEY[0] && ~SW) // button unpressed, switch down LED ON
            LEDR[7:0] <= ~SW;
        else if(KEY[0] && SW) // button unpressed, switch up LED OFF
            LEDR[7:0] <= ~SW;
        else if(~KEY[0] && SW) // button pressed, switch up LED ON
            LEDR[7:0] <= SW;
        else                    // button pressed, switch down LED OFF
            LEDR[7:0] <= SW;
    end

    //driver U0(HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY);

endmodule

