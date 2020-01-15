module int_lab1(SW, LEDR, KEY, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

    input [9:0] SW;
    input [1:0] KEY;
    output reg [7:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
    output reg [9:0] LEDR;

    wire C1, C2, C3, C4, D1, D2, D3, D4;
    wire [3:0] compHolder;
    wire [3:0] sumHolder, diffHolder;

    // HEX5 sign of [7:4]
    // HEX2 sign of [3:0]


    // This all is the ripple adder circuit
    assign sumHolder[0] = SW[0] ^ SW[4];
    assign C1 = SW[0] & SW[4];
    assign sumHolder[1] = C1 ^ (SW[1] ^ SW[5]);
    assign C2 = (SW[1] & SW[5]) | (SW[1] & C1) | (SW[5] & C1);
    assign sumHolder[2] = C2 ^ (SW[2] ^ SW[6]);
    assign C3 = (SW[2] & SW[6]) | (SW[2] & C2) | (SW[6] & C2);
    assign sumHolder[3] = C3 ^ (SW[3] ^ SW[7]);
    assign C4 = (SW[3] & SW[7]) | (SW[3] & C3) | (SW[7] & C3);

    // This all is the ripple adder circuit but with the 2's complement of 

    // This is getting the 2's complement of our right most input
    assign compHolder = ~(SW[3:0]) + 1;

    assign diffHolder[0] = compHolder[0] ^ SW[4];
    assign D1 = compHolder[0] & SW[4];
    assign diffHolder[1] = D1 ^ (compHolder[1] ^ SW[5]);
    assign D2 = (compHolder[1] & SW[5]) | (compHolder[1] & D1) | (SW[5] & D1);
    assign diffHolder[2] = D2 ^ (compHolder[2] ^ SW[6]);
    assign D3 = (compHolder[2] & SW[6]) | (compHolder[2] & D2) | (SW[6] & D2);
    assign diffHolder[3] = D3 ^ (compHolder[3] ^ SW[7]);
    assign D4 = (compHolder[3] & SW[7]) | (compHolder[3] & D3) | (SW[7] & D3);

    always @ (SW or KEY) begin
        
        if(SW[9:8] == 2'b00) begin 
        /******************************
                 Design Block 1             SW9 and SW8 down
        ******************************/
        
            // resets 7 segment displays
            HEX0 <= 8'b11111111; // off
            HEX1 <= 8'b11111111; // off
            HEX2 <= 8'b11111111; // off
            HEX3 <= 8'b11111111; // off
            HEX4 <= 8'b11111111; // off                
            HEX5 <= 8'b11111111; // off

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

            if(KEY[0] && ~SW) // button unpressed, switch down LED ON
                LEDR[7:0] <= ~SW;
            else if(KEY[0] && SW) // button unpressed, switch up LED OFF
                LEDR[7:0] <= ~SW;
            else if(~KEY[0] && SW) // button pressed, switch up LED ON
                LEDR[7:0] <= SW;
            else                    // button pressed, switch down LED OFF
                LEDR[7:0] <= SW;

        end
        else if(SW[9:8] == 2'b01) begin 
        /****************************** 
                Design Block 2          SW9 down SW8 UP
        ******************************/

            // resets 7 segment displays
            HEX0 <= 8'b11111111; // off
            HEX1 <= 8'b11111111; // off
            HEX2 <= 8'b11111111; // off
            HEX3 <= 8'b11111111; // off
            HEX4 <= 8'b11111111; // off                
            HEX5 <= 8'b11111111; // off
            
            LEDR[7:0] <= 8'b00000000; // turns off LEDs

                //CONTROLS INPUT DISPLAYS
                if(SW[7])
                    HEX5 <= 8'b10111111; // - symbol
                else
                    HEX5 <= 8'b11111111; // OFF

                if(SW[3])
                    HEX3 <= 8'b10111111; // - symbol
                else
                    HEX3 <= 8'b11111111; // OFF

                // Controls HEX4
                if(SW[7:4] == 4'b0111) // input 7
                    HEX4 <= 8'b11111000; // 7
                else if(SW[7:4] == 4'b0110) // input 6
                    HEX4 <= 8'b10000011; // 6
                else if(SW[7:4] == 4'b0101) // input 5
                    HEX4 <= 8'b10010010; // 5
                else if(SW[7:4] == 4'b0100) // input 4
                    HEX4 <= 8'b10011001; // 4
                else if(SW[7:4] == 4'b0011) // input 3
                    HEX4 <= 8'b10110000; // 3
                else if(SW[7:4] == 4'b0010) // input 2
                    HEX4 <= 8'b10100100; // 2
                else if(SW[7:4] == 4'b0001) // input 1
                    HEX4 <= 8'b11111001; // 1
                else if(SW[7:4] == 4'b0000) // input 0
                    HEX4 <= 8'b11000000; // 0
                else if(SW[7:4] == 4'b1111) // input -1
                    HEX4 <= 8'b11111001; // 1
                else if(SW[7:4] == 4'b1110) // input -2
                    HEX4 <= 8'b10100100; // 2
                else if(SW[7:4] == 4'b1101) // input -3
                    HEX4 <= 8'b10110000; // 3
                else if(SW[7:4] == 4'b1100) // input -4
                    HEX4 <= 8'b10011001; // 4
                else if(SW[7:4] == 4'b1011) // input -5
                    HEX4 <= 8'b10010010; // 5
                else if(SW[7:4] == 4'b1010) // input -6
                    HEX4 <= 8'b10000011; // 6
                else if(SW[7:4] == 4'b1001) // input -7
                    HEX4 <= 8'b11111000; // 7
                else if(SW[7:4] == 4'b1000) // input -8
                    HEX4 <= 8'b10000000; // 8
                else
                    HEX4 <= 8'b11111111; // OFF
            
                // Controls HEX2
                if(SW[3:0] == 4'b0111) // input 7
                    HEX2 <= 8'b11111000; // 7
                else if(SW[3:0] == 4'b0110) // input 6
                    HEX2 <= 8'b10000011; // 6
                else if(SW[3:0] == 4'b0101) // input 5
                    HEX2 <= 8'b10010010; // 5
                else if(SW[3:0] == 4'b0100) // input 4
                    HEX2 <= 8'b10011001; // 4
                else if(SW[3:0] == 4'b0011) // input 3
                    HEX2 <= 8'b10110000; // 3
                else if(SW[3:0] == 4'b0010) // input 2
                    HEX2 <= 8'b10100100; // 2
                else if(SW[3:0] == 4'b0001) // input 1
                    HEX2 <= 8'b11111001; // 1
                else if(SW[3:0] == 4'b0000) // input 0
                    HEX2 <= 8'b11000000; // 0
                else if(SW[3:0] == 4'b1111) // input -1
                    HEX2 <= 8'b11111001; // 1
                else if(SW[3:0] == 4'b1110) // input -2
                    HEX2 <= 8'b10100100; // 2
                else if(SW[3:0] == 4'b1101) // input -3
                    HEX2 <= 8'b10110000; // 3
                else if(SW[3:0] == 4'b1100) // input -4
                    HEX2 <= 8'b10011001; // 4
                else if(SW[3:0] == 4'b1011) // input -5
                    HEX2 <= 8'b10010010; // 5
                else if(SW[3:0] == 4'b1010) // input -6
                    HEX2 <= 8'b10000011; // 6
                else if(SW[3:0] == 4'b1001) // input -7
                    HEX2 <= 8'b11111000; // 7
                else if(SW[3:0] == 4'b1000) // input -8
                    HEX2 <= 8'b10000000; // 8
                else
                    HEX2 <= 8'b11111111; // OFF

            if(KEY[0]) begin

                // controls HEX0 when KEY0 unpressed
            
                if(sumHolder[3] == 1'b1)
                    HEX1 <= 8'b10111111; // - symbol
                else
                    HEX1 <= 8'b11111111; // OFF

                if(C3 ^ C4) begin // overflow!
                    HEX1 <= 8'b11000000; // 0
                    HEX0 <= 8'b10001110; // F
                end
                else if(sumHolder[3:0] == 4'b0111) // input 7
                    HEX0 <= 8'b11111000; // 7
                else if(sumHolder[3:0] == 4'b0110) // input 6
                    HEX0 <= 8'b10000011; // 6
                else if(sumHolder[3:0] == 4'b0101) // input 5
                    HEX0 <= 8'b10010010; // 5
                else if(sumHolder[3:0] == 4'b0100) // input 4
                    HEX0 <= 8'b10011001; // 4
                else if(sumHolder[3:0] == 4'b0011) // input 3
                    HEX0 <= 8'b10110000; // 3
                else if(sumHolder[3:0] == 4'b0010) // input 2
                    HEX0 <= 8'b10100100; // 2
                else if(sumHolder[3:0] == 4'b0001) // input 1
                    HEX0 <= 8'b11111001; // 1
                else if(sumHolder[3:0] == 4'b0000) // input 0
                    HEX0 <= 8'b11000000; // 0
                else if(sumHolder[3:0] == 4'b1111) // input -1
                    HEX0 <= 8'b11111001; // 1
                else if(sumHolder[3:0] == 4'b1110) // input -2
                    HEX0 <= 8'b10100100; // 2
                else if(sumHolder[3:0] == 4'b1101) // input -3
                    HEX0 <= 8'b10110000; // 3
                else if(sumHolder[3:0] == 4'b1100) // input -4
                    HEX0 <= 8'b10011001; // 4
                else if(sumHolder[3:0] == 4'b1011) // input -5
                    HEX0 <= 8'b10010010; // 5
                else if(sumHolder[3:0] == 4'b1010) // input -6
                    HEX0 <= 8'b10000011; // 6
                else if(sumHolder[3:0] == 4'b1001) // input -7
                    HEX0 <= 8'b11111000; // 7
                else if(sumHolder[3:0] == 4'b1000) // input -8
                    HEX0 <= 8'b10000000; // 8
                else
                    HEX0 <= 8'b11111111; // OFF     
            end
            else begin // THIS IS IF THE BUTTON IS PRESSED
                if(diffHolder[3] == 1'b1)
                    HEX1 <= 8'b10111111; // - symbol
                else
                    HEX1 <= 8'b11111111; // OFF

                if(D3 ^ D4) begin // overflow!
                    HEX1 <= 8'b11000000; // 0
                    HEX0 <= 8'b10001110; // F
                end  
                else if(diffHolder[3:0] == 4'b0111) // input 7
                    HEX0 <= 8'b11111000; // 7
                else if(diffHolder[3:0] == 4'b0110) // input 6
                    HEX0 <= 8'b10000011; // 6
                else if(diffHolder[3:0] == 4'b0101) // input 5
                    HEX0 <= 8'b10010010; // 5
                else if(diffHolder[3:0] == 4'b0100) // input 4
                    HEX0 <= 8'b10011001; // 4
                else if(diffHolder[3:0] == 4'b0011) // input 3
                    HEX0 <= 8'b10110000; // 3
                else if(diffHolder[3:0] == 4'b0010) // input 2
                    HEX0 <= 8'b10100100; // 2
                else if(diffHolder[3:0] == 4'b0001) // input 1
                    HEX0 <= 8'b11111001; // 1
                else if(diffHolder[3:0] == 4'b0000) // input 0
                    HEX0 <= 8'b11000000; // 0
                else if(diffHolder[3:0] == 4'b1111) // input -1
                    HEX0 <= 8'b11111001; // 1
                else if(diffHolder[3:0] == 4'b1110) // input -2
                    HEX0 <= 8'b10100100; // 2
                else if(diffHolder[3:0] == 4'b1101) // input -3
                    HEX0 <= 8'b10110000; // 3
                else if(diffHolder[3:0] == 4'b1100) // input -4
                    HEX0 <= 8'b10011001; // 4
                else if(diffHolder[3:0] == 4'b1011) // input -5
                    HEX0 <= 8'b10010010; // 5
                else if(diffHolder[3:0] == 4'b1010) // input -6
                    HEX0 <= 8'b10000011; // 6
                else if(diffHolder[3:0] == 4'b1001) // input -7
                    HEX0 <= 8'b11111000; // 7
                else if(diffHolder[3:0] == 4'b1000) // input -8
                    HEX0 <= 8'b10000000; // 8
                else
                    HEX0 <= 8'b11111111; // OFF  
            end
        end
        else begin 
        /**********************************
                  DESIGN BLOCK 3               SW9 UP SW8 either
        ***********************************/

            // resets 7 segment displays
            HEX0 <= 8'b11111111; // off
            HEX1 <= 8'b11111111; // off
            HEX2 <= 8'b11111111; // off
            HEX3 <= 8'b11111111; // off
            HEX4 <= 8'b11111111; // off                
            HEX5 <= 8'b11111111; // off

            LEDR[9:0] = 1'b0; // turns off all LEDs

            if(~SW[8]) begin //comparing unsigned values in here
                
                HEX5 <= 8'b11111111; // OFF All numbers positive
                HEX3 <= 8'b11111111; // OFF

                // Controls HEX4
                if(SW[7:4] == 4'b0111) // input 7
                    HEX4 <= 8'b11111000; // 7
                else if(SW[7:4] == 4'b0110) // input 6
                    HEX4 <= 8'b10000011; // 6
                else if(SW[7:4] == 4'b0101) // input 5
                    HEX4 <= 8'b10010010; // 5
                else if(SW[7:4] == 4'b0100) // input 4
                    HEX4 <= 8'b10011001; // 4
                else if(SW[7:4] == 4'b0011) // input 3
                    HEX4 <= 8'b10110000; // 3
                else if(SW[7:4] == 4'b0010) // input 2
                    HEX4 <= 8'b10100100; // 2
                else if(SW[7:4] == 4'b0001) // input 1
                    HEX4 <= 8'b11111001; // 1
                else if(SW[7:4] == 4'b0000) // input 0
                    HEX4 <= 8'b11000000; // 0
                else if(SW[7:4] == 4'b1111) begin // input 15
                    HEX5 <= 8'b11111001; // 1
                    HEX4 <= 8'b10010010; // 5
                end
                else if(SW[7:4] == 4'b1110) begin// input 14
                    HEX5 <= 8'b11111001; // 1
                    HEX4 <= 8'b10011001; // 4
                end
                else if(SW[7:4] == 4'b1101) begin // input 13
                    HEX5 <= 8'b11111001; // 1
                    HEX4 <= 8'b10110000; // 3
                end
                else if(SW[7:4] == 4'b1100) begin // input 12
                    HEX5 <= 8'b11111001; // 1
                    HEX4 <= 8'b10100100; // 2
                end
                else if(SW[7:4] == 4'b1011) begin // input 11
                    HEX5 <= 8'b11111001; // 1
                    HEX4 <= 8'b11111001; // 1
                end
                else if(SW[7:4] == 4'b1010) begin // input 10
                    HEX5 <= 8'b11111001; // 1
                    HEX4 <= 8'b11000000; // 0
                end
                else if(SW[7:4] == 4'b1001) // input 9
                    HEX4 <= 8'b10011000; // 9
                else if(SW[7:4] == 4'b1000) // input 8
                    HEX4 <= 8'b10000000; // 8
                else
                    HEX4 <= 8'b11111111; // OFF
                    
                // Controls 2
                if(SW[3:0] == 4'b0111) // input 7
                    HEX2 <= 8'b11111000; // 7
                else if(SW[3:0] == 4'b0110) // input 6
                    HEX2 <= 8'b10000011; // 6
                else if(SW[3:0] == 4'b0101) // input 5
                    HEX2 <= 8'b10010010; // 5
                else if(SW[3:0] == 4'b0100) // input 4
                    HEX2 <= 8'b10011001; // 4
                else if(SW[3:0] == 4'b0011) // input 3
                    HEX2 <= 8'b10110000; // 3
                else if(SW[3:0] == 4'b0010) // input 2
                    HEX2 <= 8'b10100100; // 2
                else if(SW[3:0] == 4'b0001) // input 1
                    HEX2 <= 8'b11111001; // 1
                else if(SW[3:0] == 4'b0000) // input 0
                    HEX2 <= 8'b11000000; // 0
                else if(SW[3:0] == 4'b1111) begin // input 15
                    HEX3 <= 8'b11111001; // 1
                    HEX2 <= 8'b10010010; // 5
                end
                else if(SW[3:0] == 4'b1110) begin// input 14
                    HEX3 <= 8'b11111001; // 1
                    HEX2 <= 8'b10011001; // 4
                end
                else if(SW[3:0] == 4'b1101) begin // input 13
                    HEX3 <= 8'b11111001; // 1
                    HEX2 <= 8'b10110000; // 3
                end
                else if(SW[3:0] == 4'b1100) begin // input 12
                    HEX3 <= 8'b11111001; // 1
                    HEX2 <= 8'b10100100; // 2
                end
                else if(SW[3:0] == 4'b1011) begin // input 11
                    HEX3 <= 8'b11111001; // 1
                    HEX2 <= 8'b11111001; // 1
                end
                else if(SW[3:0] == 4'b1010) begin // input 10
                    HEX3 <= 8'b11111001; // 1
                    HEX2 <= 8'b11000000; // 0
                end
                else if(SW[3:0] == 4'b1001) // input 9
                    HEX2 <= 8'b10011000; // 9
                else if(SW[3:0] == 4'b1000) // input 8
                    HEX2 <= 8'b10000000; // 8
                else
                    HEX2 <= 8'b11111111; // OFFF    

                if(SW[7] & ~SW[3]) // sw7 = 1 and sw3 = 0   input 1 > input 2
                    LEDR[1] = 1'b1;
                else if(~SW[7] & SW[3]) // sw7 = 0 and sw3 = 1  input 2 > input 1
                    LEDR[0] = 1'b1; 
                else if(~SW[6] & SW[2]) // sw6 = 0 and sw2 = 1   input 2 > input 1
                    LEDR[0] = 1'b1;
                else if(~SW[2] & SW[6]) // sw2 = 0 and sw6 = 1   input 1 > input 2
                    LEDR[1] = 1'b1;
                else if(~SW[5] & SW[1]) // sw5 = 0 and sw1 = 1   input 2 > input 1
                    LEDR[0] = 1'b1; 
                else if(~SW[1] & SW[5]) // sw1 = 0 and sw5 = 1    input 1 > input 2
                    LEDR[1] = 1'b1;
                else if(~SW[4] & SW[0]) // sw4 = 0 and sw0 = 1   input 2 > input 1
                    LEDR[0] = 1'b1; 
                else if(~SW[0] & SW[4]) // sw0 = 0 and sw4 = 1    input 1 > input 2
                    LEDR[1] = 1'b1;
                else // the two are equal
                    LEDR[2] = 1'b1;
            end
            else begin //comparing signed values in here
                if(SW[7])
                    HEX5 <= 8'b10111111; // - symbol
                else
                    HEX5 <= 8'b11111111; // OFF

                if(SW[3])
                    HEX3 <= 8'b10111111; // - symbol
                else
                    HEX3 <= 8'b11111111; // OFF

                // Controls HEX4
                if(SW[7:4] == 4'b0111) // input 7
                    HEX4 <= 8'b11111000; // 7
                else if(SW[7:4] == 4'b0110) // input 6
                    HEX4 <= 8'b10000011; // 6
                else if(SW[7:4] == 4'b0101) // input 5
                    HEX4 <= 8'b10010010; // 5
                else if(SW[7:4] == 4'b0100) // input 4
                    HEX4 <= 8'b10011001; // 4
                else if(SW[7:4] == 4'b0011) // input 3
                    HEX4 <= 8'b10110000; // 3
                else if(SW[7:4] == 4'b0010) // input 2
                    HEX4 <= 8'b10100100; // 2
                else if(SW[7:4] == 4'b0001) // input 1
                    HEX4 <= 8'b11111001; // 1
                else if(SW[7:4] == 4'b0000) // input 0
                    HEX4 <= 8'b11000000; // 0
                else if(SW[7:4] == 4'b1111) // input -1
                    HEX4 <= 8'b11111001; // 1
                else if(SW[7:4] == 4'b1110) // input -2
                    HEX4 <= 8'b10100100; // 2
                else if(SW[7:4] == 4'b1101) // input -3
                    HEX4 <= 8'b10110000; // 3
                else if(SW[7:4] == 4'b1100) // input -4
                    HEX4 <= 8'b10011001; // 4
                else if(SW[7:4] == 4'b1011) // input -5
                    HEX4 <= 8'b10010010; // 5
                else if(SW[7:4] == 4'b1010) // input -6
                    HEX4 <= 8'b10000011; // 6
                else if(SW[7:4] == 4'b1001) // input -7
                    HEX4 <= 8'b11111000; // 7
                else if(SW[7:4] == 4'b1000) // input -8
                    HEX4 <= 8'b10000000; // 8
                else
                    HEX4 <= 8'b11111111; // OFF
                    
                // Controls HEX2
                if(SW[3:0] == 4'b0111) // input 7
                    HEX2 <= 8'b11111000; // 7
                else if(SW[3:0] == 4'b0110) // input 6
                    HEX2 <= 8'b10000011; // 6
                else if(SW[3:0] == 4'b0101) // input 5
                    HEX2 <= 8'b10010010; // 5
                else if(SW[3:0] == 4'b0100) // input 4
                    HEX2 <= 8'b10011001; // 4
                else if(SW[3:0] == 4'b0011) // input 3
                    HEX2 <= 8'b10110000; // 3
                else if(SW[3:0] == 4'b0010) // input 2
                    HEX2 <= 8'b10100100; // 2
                else if(SW[3:0] == 4'b0001) // input 1
                    HEX2 <= 8'b11111001; // 1
                else if(SW[3:0] == 4'b0000) // input 0
                    HEX2 <= 8'b11000000; // 0
                else if(SW[3:0] == 4'b1111) // input -1
                    HEX2 <= 8'b11111001; // 1
                else if(SW[3:0] == 4'b1110) // input -2
                    HEX2 <= 8'b10100100; // 2
                else if(SW[3:0] == 4'b1101) // input -3
                    HEX2 <= 8'b10110000; // 3
                else if(SW[3:0] == 4'b1100) // input -4
                    HEX2 <= 8'b10011001; // 4
                else if(SW[3:0] == 4'b1011) // input -5
                    HEX2 <= 8'b10010010; // 5
                else if(SW[3:0] == 4'b1010) // input -6
                    HEX2 <= 8'b10000011; // 6
                else if(SW[3:0] == 4'b1001) // input -7
                    HEX2 <= 8'b11111000; // 7
                else if(SW[3:0] == 4'b1000) // input -8
                    HEX2 <= 8'b10000000; // 8
                else
                    HEX2 <= 8'b11111111; // OFF   

                if(SW[7] & ~SW[3]) // negative input 1, positive input 2
                    LEDR[0] = 1'b1; // input 2 > input 1
                else if(~SW[7] & SW[3]) // pos input 1, neg input 2
                    LEDR[1] = 1'b1;
                else if(~SW[7] & ~SW[3]) begin // both positive inputs
                    if(~SW[6] & SW[2]) // sw6 = 0 and sw2 = 1   input 2 > input 1
                        LEDR[0] = 1'b1;
                    else if(~SW[2] & SW[6]) // sw2 = 0 and sw6 = 1   input 1 > input 2
                        LEDR[1] = 1'b1;
                    else if(~SW[5] & SW[1]) // sw5 = 0 and sw1 = 1   input 2 > input 1
                        LEDR[0] = 1'b1; 
                    else if(~SW[1] & SW[5]) // sw1 = 0 and sw5 = 1    input 1 > input 2
                        LEDR[1] = 1'b1;
                    else if(~SW[4] & SW[0]) // sw4 = 0 and sw0 = 1   input 2 > input 1
                        LEDR[0] = 1'b1; 
                    else if(~SW[0] & SW[4]) // sw0 = 0 and sw4 = 1    input 1 > input 2
                        LEDR[1] = 1'b1;
                    else // the two are equal
                        LEDR[2] = 1'b1;
                end
                else begin // both negative inputs
                    if(SW[6] & ~SW[2]) // sw6 = 1 and sw2 = 0    input 1 > input 2
                        LEDR[1] = 1'b1;
                    else if(~SW[6] & SW[2]) // sw6 = 0 and sw2 = 1    input 2 > input 1
                        LEDR[0] = 1'b1;
                    else if(SW[6] & SW[2]) begin // sw6 = 1 and sw2 = 1 need to check next bit b
                        if(SW[5] & ~SW[1]) // sw5 = 1 and sw2 = 0       input 1 > input 2
                            LEDR[1] = 1'b1;
                        else if(~SW[5] & SW[1]) // sw5 = 0 and sw2 = 1      input 2 > input 1
                            LEDR[0] = 1'b1;
                        else if(SW[5] & SW[1]) begin // sw5 = 1 and sw2 = 1 need to check next bit
                            if(SW[4] & ~SW[0]) // sw4 = 1 and sw0 = 0       input 1 > input 2
                                LEDR[1] = 1'b1;
                            else if(~SW[4] & SW[0])// sw4 = 0 and sw0 = 1      input 2 > input 1
                                LEDR[0] = 1'b1;
                            else // the two are equal
                                LEDR[2] = 1'b1;
                        end
                        else begin // sw5 = 0 and sw2 = 0 need to check next bit
                            if(SW[4] & ~SW[0]) // sw4 = 1 and sw0 = 0       input 1 > input2
                                LEDR[1] = 1'b1;
                            else if(~SW[0] & SW[4])// sw4 = 0 and sw0 = 1
                                LEDR[0] = 1'b1;
                            else // the two are equal
                                LEDR[2] = 1'b1;
                        end
                    end
                    else begin //sw6 = 0 and sw2 = 0 need to check next bit
                        if(SW[5] & ~SW[1]) // sw5 = 1 and sw1 = 0       input 1 > input 2
                            LEDR[1] = 1'b1;
                        else if(~SW[5] & SW[1]) // sw5 = 0 and sw1 = 1      input 2 > input 1
                            LEDR[0] = 1'b1;
                        else if(SW[5] & SW[1]) begin // sw5 = 1 and sw1 = 1 need to check last bit
                            if(SW[4] & ~SW[0]) // sw4 = 1 and sw0 = 0   input 1 > input 2
                                LEDR[1] = 1'b1;
                            else if(~SW[4] & SW[0]) // sw4 = 0 and sw0 = 1      input 2 > input 1
                                LEDR[0] = 1'b1;
                            else // the two are equal
                                LEDR[2] = 1'b1;
                        end
                        else begin // sw5 = 0 and sw6 = 0 need to check last bit
                            if(SW[4] & ~SW[0]) // sw4 = 1 and sw0 = 0   input 1 > input 2
                                LEDR[1] = 1'b1;
                            else if(~SW[4] & SW[0]) // sw4 = 0 and sw0 = 1      input 2 > input 1
                                LEDR[0] = 1'b1;
                            else // sw4 = 0 and sw0 = 0
                                LEDR[2] = 1'b1;
                        end
                    end
                end
            end
        end
    end

endmodule