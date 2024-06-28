module STACK_BASED_ALU #(parameter N = 8) (
    input signed [N-1:0] input_data,
    input [2:0] opcode,
    output reg signed [N-1:0] output_data,
    output reg overflow
);
    // Internal stack for ALU operations
    reg [N-1:0] stack [0:N-1];
    integer top = -1;

    always @(*) begin
        overflow = 0;
        output_data = 0;
        case (opcode)
            3'b100: // Addition
                if (top > 0) begin
                    output_data = stack[top] + stack[top-1];
                    overflow = ((stack[top] > 0 && stack[top-1] > 0 && output_data <= 0) || (stack[top] < 0 && stack[top-1] < 0 && output_data >= 0)) ? 1 : 0;
                end
            3'b101: // Multiplication
                if (top > 0) begin
                    output_data = stack[top] * stack[top-1];
                    if (stack[top] == 0 || stack[top-1] == 0) begin
                        overflow = 0;
                    end
                    else begin
                        overflow = (stack[top] == output_data / stack[top-1]) ? 0 : 1;
                    end
                end
            3'b110: // PUSH
                if (top < N-1) begin
                    top = top + 1;
                    stack[top] = input_data;
                end
            3'b111: // POP
                if (top >= 0) begin
                    output_data = stack[top];
                    top = top - 1;
                end
            default: // No Operation
                output_data = 0;
        endcase
    end
endmodule
