`timescale 1ns / 1ps

module multiplier_tb();

reg clk;
reg rst_n;
reg start;

reg signed [31:0] a11,a12,a13;
reg signed [31:0] a21,a22,a23;
reg signed [31:0] a31,a32,a33;

reg signed [31:0] b11,b12,b13;
reg signed [31:0] b21,b22,b23;
reg signed [31:0] b31,b32,b33;

wire signed [65:0] c11,c12,c13;
wire signed [65:0] c21,c22,c23;
wire signed [65:0] c31,c32,c33;

wire done;

multi_top uut (

    .clk(clk),
    .rst_n(rst_n),
    .start(start),

    .a11(a11), .a12(a12), .a13(a13),
    .a21(a21), .a22(a22), .a23(a23),
    .a31(a31), .a32(a32), .a33(a33),

    .b11(b11), .b12(b12), .b13(b13),
    .b21(b21), .b22(b22), .b23(b23),
    .b31(b31), .b32(b32), .b33(b33),

    .c11(c11), .c12(c12), .c13(c13),
    .c21(c21), .c22(c22), .c23(c23),
    .c31(c31), .c32(c32), .c33(c33),

    .done(done)

);

always #5 clk = ~clk;

initial begin

    clk = 0;
    rst_n = 0;
    start = 0;
    #10 rst_n = 1;

    // Matrix A
    a11=1; a12=2; a13=3;
    a21=4; a22=5; a23=6;
    a31=7; a32=8; a33=9;

    // Matrix B
    b11=9; b12=8; b13=7;
    b21=6; b22=5; b23=4;
    b31=3; b32=2; b33=1;

    #10 start = 1;
    #10 start = 0;
    #50;

    $display("C11=%0d C12=%0d C13=%0d", c11,c12,c13);
    $display("C21=%0d C22=%0d C23=%0d", c21,c22,c23);
    $display("C31=%0d C32=%0d C33=%0d", c31,c32,c33);

    #20;

    a11=1; a12=1; a13=2;
    a21=2; a22=2; a23=1;
    a31=1; a32=1; a33=1;

    b11=1; b12=1; b13=1;
    b21=1; b22=1; b23=1;
    b31=1; b32=1; b33=1;

    #10 start = 1;
    #10 start = 0;
    #50;

    $display("C11=%0d C12=%0d C13=%0d", c11,c12,c13);
    $display("C21=%0d C22=%0d C23=%0d", c21,c22,c23);
    $display("C31=%0d C32=%0d C33=%0d", c31,c32,c33);
    $finish;

end

endmodule
