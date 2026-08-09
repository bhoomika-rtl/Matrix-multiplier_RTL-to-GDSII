`timescale 1ns / 1ps

module matrix_cont(

input clk,
input rst_n,
input start,

output reg load,
output reg compute,
output reg done

);

parameter IDLE = 2'd0;
parameter LOAD = 2'd1;
parameter COMPUTE = 2'd2;
parameter FINISH = 2'd3;

reg [1:0] state,next_state;

// State Register
always @(posedge clk or negedge rst_n)
begin

    if(!rst_n)
        state <= IDLE;
    else
        state <= next_state;

end

// Next State Logic
always @(*)
begin
    next_state = state;

    case(state)
        IDLE:
            if(start)
                next_state = LOAD;
        LOAD:
                next_state = COMPUTE;
        COMPUTE:
                next_state = FINISH;
        FINISH:
                next_state = IDLE;
        default:
                next_state = IDLE;

    endcase

end

// Output Logic
always @(*)
begin

    load = 0;
    compute = 0;
    done = 0;

    case(state)
        LOAD:
            load = 1;
        COMPUTE:
            compute = 1;
        FINISH:
            done = 1;
    endcase

end

endmodule
