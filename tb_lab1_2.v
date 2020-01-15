`timescale 1 ns / 100 ps

module tb_lab1_2();

reg [7:0] s_in;
reg [1:0] k_in;
wire [9:0] l_out;
wire [7:0] h_out0, h_out1, h_out2, h_out3, h_out4, h_out5;

lab1_2 U0(.SW(s_in), .LEDR(l_out), .KEY(k_in), .HEX0(h_out0), .HEX1(h_out1), .HEX2(h_out2), .HEX3(h_out3), .HEX4(h_out4), .HEX5(h_out5));

// Neg + neg, pos + pos OF, 
// pos - pos (button pressed), 
// pos + neg (button pressed)
initial begin
    $dumpfile("out2.vcd");
    $dumpvars;
    $display($time, "<<Starting Simulation>>");

    k_in = 2'b11; // both buttons off
    s_in = 8'b11001101;
    // s_in[3:0] = 4'b1101; // input 2 = -3
    // s_in[7:4] = 4'b1100; // input 1 = -4

    #10 // HEX1 should be - and HEX0 should be -7

    k_in = 2'b10; // button 0 pressed so now -3 - (-4)

    #10 // HEX1 should be EMPTY and HEX0 should be 1

    k_in = 2'b11; // both buttons off
    s_in = 8'b01110111;
    // s_in[3:0] = 4'b0111; // input 2 = 7
    // s_in[7:4] = 4'b0111; // input 1 = 7

    #10 // HEX1 should be 0 and HEX0 should be F Overflow

    k_in = 2'b10; // button 0 pressed so now 7 - 7

    #10 // HEX1 should be empty and HEX0 should be 0
    
    $display($time, "<<Simulation Complete>>");
    $finish;
    end

endmodule