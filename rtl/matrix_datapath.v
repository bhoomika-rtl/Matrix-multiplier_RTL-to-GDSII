`timescale 1ns / 1ps
module matrix_datapath(
    input clk,
    input rst_n,
    input load,
    input compute,
    // Matrix A
    input signed [31:0] a11,a12,a13,
    input signed [31:0] a21,a22,a23,
    input signed [31:0] a31,a32,a33,

    // Matrix B
    input signed [31:0] b11,b12,b13,
    input signed [31:0] b21,b22,b23,
    input signed [31:0] b31,b32,b33,

    // Matrix C
    output reg signed [65:0] c11,c12,c13,
    output reg signed [65:0] c21,c22,c23,
    output reg signed [65:0] c31,c32,c33
);

// Internal Registers
reg signed [31:0] A11,A12,A13;
reg signed [31:0] A21,A22,A23;
reg signed [31:0] A31,A32,A33;

reg signed [31:0] B11,B12,B13;
reg signed [31:0] B21,B22,B23;
reg signed [31:0] B31,B32,B33;

// Sequential Logic
always @(posedge clk or negedge rst_n)
begin

    if(!rst_n)
    begin
        A11<=0; A12<=0; A13<=0;
        A21<=0; A22<=0; A23<=0;
        A31<=0; A32<=0; A33<=0;

        B11<=0; B12<=0; B13<=0;
        B21<=0; B22<=0; B23<=0;
        B31<=0; B32<=0; B33<=0;

        c11<=0; c12<=0; c13<=0;
        c21<=0; c22<=0; c23<=0;
        c31<=0; c32<=0; c33<=0;
    end

    else
    begin
        // Load matrices
        if (load)
        begin
            A11<=a11; A12<=a12; A13<=a13;
            A21<=a21; A22<=a22; A23<=a23;
            A31<=a31; A32<=a32; A33<=a33;

            B11<=b11; B12<=b12; B13<=b13;
            B21<=b21; B22<=b22; B23<=b23;
            B31<=b31; B32<=b32; B33<=b33;
        end
        
  //  Multiplication
        else if (compute)
        begin
            c11 <= (A11*B11) + (A12*B21) + (A13*B31);
            c12 <= (A11*B12) + (A12*B22) + (A13*B32);
            c13 <= (A11*B13) + (A12*B23) + (A13*B33);

            c21 <= (A21*B11) + (A22*B21) + (A23*B31);
            c22 <= (A21*B12) + (A22*B22) + (A23*B32);
            c23 <= (A21*B13) + (A22*B23) + (A23*B33);

            c31 <= (A31*B11) + (A32*B21) + (A33*B31);
            c32 <= (A31*B12) + (A32*B22) + (A33*B32);
            c33 <= (A31*B13) + (A32*B23) + (A33*B33);
        end
    end
end
endmodule
