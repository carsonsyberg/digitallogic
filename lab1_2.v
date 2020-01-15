module lab1_2(SW, LEDR, KEY, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

    input [7:0] SW;
    input [1:0] KEY;
    output reg [7:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
    output reg [9:0] LEDR;

    reg [7:0] DRV0, DRV1, DRV2, DRV3, DRV4, DRV5, CRV0, CRV1, CRV2, CRV3, CRV4, CRV5;

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
    assign diffHolder[3] = D3 ^ (SW[3] ^ SW[7]);
    assign D4 = (compHolder[3] & SW[7]) | (compHolder[3] & D3) | (SW[7] & D3);


    always @(SW) begin

        //HEX0 = DRV0; 

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
    
    always @(KEY[0]) begin

        // controls HEX0 when KEY0 unpressed
        
        if(diffHolder[3] == 1'b1)
            HEX1 <= 8'b10111111; // - symbol
        else
            HEX1 <= 8'b11111111; // OFF

        if(diffHolder[3:0] == 4'b0111) // input 7
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
    

endmodule

