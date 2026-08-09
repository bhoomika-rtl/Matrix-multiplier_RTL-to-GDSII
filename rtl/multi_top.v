`timescale 1ns / 1ps
module multi_top(

    input clk,
    input rst_n,
    input start,

    // Matrix A
    input signed [31:0] a11,a12,a13,
    input signed [31:0] a21,a22,a23,
    input signed [31:0] a31,a32,a33,

    // Matrix B
    input signed [31:0] b11,b12,b13,
    input signed [31:0] b21,b22,b23,
    input signed [31:0] b31,b32,b33,

    // Matrix C
    output signed [65:0] c11,c12,c13,
    output signed [65:0] c21,c22,c23,
    output signed [65:0] c31,c32,c33,

    output done

);

wire load;
wire compute;

matrix_cont cont1(

    .clk(clk),
    .rst_n(rst_n),
    .start(start),

    .load(load),
    .compute(compute),
    .done(done)

);


matrix_datapath path1(

    .clk(clk),
    .rst_n(rst_n),

    .load(load),
    .compute(compute),

    // Matrix A

    .a11(a11), .a12(a12), .a13(a13),
    .a21(a21), .a22(a22), .a23(a23),
    .a31(a31), .a32(a32), .a33(a33),

    // Matrix B

    .b11(b11), .b12(b12), .b13(b13),
    .b21(b21), .b22(b22), .b23(b23),
    .b31(b31), .b32(b32), .b33(b33),

    // Matrix C

    .c11(c11), .c12(c12), .c13(c13),
    .c21(c21), .c22(c22), .c23(c23),
    .c31(c31), .c32(c32), .c33(c33)

);

endmodule
