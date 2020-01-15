`timescale 1 ns / 100 ps

module tb_lab1_3();

reg [9:0] s_in;
wire [9:0] l_out;
wire [7:0] h_out;

lab1_3 U0(.SW(s_in), .LEDR(l_out), .HEX2(h_out), .HEX3(h_out), .HEX4(h_out), .HEX5(h_out));

// Unsigned big little
// Unsigned same
// Signed little big
// signed oppisite signs
initial begin
    $dumpfile("out3.vcd");
    $dumpvars;
    $display($time, "<<Starting Simulation>>");

    s_in[8] = 1'b0; // sw8 DOWN unsigned nums
    s_in[3:0] = 4'b1100; // input 2 = 12
    s_in[7:4] = 4'b1101; // input 1 = 13

    #10 // LEDR1 should be on input 1 > input 2

    s_in[3:0] = 4'b0001; // input 2 = 1
    s_in[7:4] = 4'b0001; // input 1 = 1

    #10 // LEDR0 should be on input 1 == input 2

    s_in[8] = 1'b1; // sw8 UP signed nums
    s_in[3:0] = 4'b1101; // input 2 = -3
    s_in[7:4] = 4'b1100; // input 1 = -4

    #10 // LEDR2 should be on input 2 > input 1

    s_in[7:4] = 4'b0010; // input 1 = 2
                         // input 2 still -3

    #10 // LEDR1 should be on input 1 > input 2
    
    $display($time, "<<Simulation Complete>>");
    $finish;
    end

endmodule