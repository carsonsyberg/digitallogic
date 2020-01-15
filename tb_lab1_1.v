`timescale 1 ns / 100 ps

module tb_lab1_1();

reg [7:0] s_in;
reg [1:0] k_in;
wire [9:0] l_out;
wire [7:0] h_out;

lab1_1 U0(.SW(s_in), .LEDR(l_out), .KEY(k_in), .HEX0(h_out), .HEX1(h_out), .HEX2(h_out), .HEX3(h_out), .HEX4(h_out), .HEX5(h_out));

initial begin
    $dumpfile("out1.vcd");
    $dumpvars;
    $display($time, "<<Starting Simulation>>");

    s_in = 8'b00000000; // switch signal
    k_in = 2'b11;        // both buttons off
    #10
    k_in = 2'b10;       // button 0 pressed
    #10
    k_in = 2'b11;       // button 0 unpressed
    #10 
    k_in = 2'b01;       // button 1 pressed
    #10
    k_in = 2'b11;       // button 1 unpressed
    #10
    
    $display($time, "<<Simulation Complete>>");
    $finish;
    end

endmodule