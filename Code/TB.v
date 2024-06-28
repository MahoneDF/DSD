`timescale 1ns / 1ps

module TB;
    reg [3:0] input_data_4;
    reg [7:0] input_data_8;
    reg [15:0] input_data_16;
    reg [31:0] input_data_32;
    reg [2:0] opcode;
    wire signed [3:0] output_data_4;
    wire signed [7:0] output_data_8;
    wire signed [15:0] output_data_16;
    wire signed [31:0] output_data_32;
    wire overflow_4, overflow_8, overflow_16, overflow_32;

    // Instantiate the module with N = 4
    STACK_BASED_ALU #(.N(4)) alu_4 (
        .input_data(input_data_4),
        .opcode(opcode),
        .output_data(output_data_4),
        .overflow(overflow_4)
    );

    // Instantiate the module with N = 8
    STACK_BASED_ALU #(.N(8)) alu_8 (
        .input_data(input_data_8),
        .opcode(opcode),
        .output_data(output_data_8),
        .overflow(overflow_8)
    );

    // Instantiate the module with N = 16
    STACK_BASED_ALU #(.N(16)) alu_16 (
        .input_data(input_data_16),
        .opcode(opcode),
        .output_data(output_data_16),
        .overflow(overflow_16)
    );

    // Instantiate the module with N = 32
    STACK_BASED_ALU #(.N(32)) alu_32 (
        .input_data(input_data_32),
        .opcode(opcode),
        .output_data(output_data_32),
        .overflow(overflow_32)
    );

    initial begin
        // Test the ALU with some operations
        input_data_32 = -32'd1;
        input_data_16 = -16'd1;
        input_data_8 = -8'd1;
        input_data_4 = 4'd7;

        opcode = 3'b110; // PUSH
        #10
        input_data_32 = 32'd2;
        input_data_16 = 16'd2;
        input_data_8 = 8'd2;
        input_data_4 = 4'd1;
        #10
        opcode = 3'b100; // Addition
        #10
        $display("after addition 4 -> output_4: %d_%b, overflow_4: %d_%b\n", output_data_4, output_data_4, overflow_4, overflow_4);
        $display("after addition 8 -> output_8: %d_%b, overflow_8: %d_%b\n", output_data_8, output_data_8, overflow_8, overflow_8);
        $display("after addition 16 -> output_16: %d_%b, overflow_16: %d_%b\n", output_data_16, output_data_16, overflow_16, overflow_16);
        $display("after addition 32 -> output_32: %d_%b, overflow_32: %d_%b\n", output_data_32, output_data_32, overflow_32, overflow_32);
        opcode = 3'b101; // Multiplication
        #10
        $display("after multiplication 4 -> output_4: %d_%b, overflow_4: %d_%b\n", output_data_4, output_data_4, overflow_4, overflow_4);
        $display("after multiplication 8 -> output_8: %d_%b, overflow_8: %d_%b\n", output_data_8, output_data_8, overflow_8, overflow_8);
        $display("after multiplication 16 -> output_16: %d_%b, overflow_16: %d_%b\n", output_data_16, output_data_16, overflow_16, overflow_16);
        $display("after multiplication 32 -> output_32: %d_%b, overflow_32: %d_%b\n", output_data_32, output_data_32, overflow_32, overflow_32);
        opcode = 3'b111; // POP
        #10
        $display("after pop 4 -> output_4: %d_%b, overflow_4: %d_%b\n", output_data_4, output_data_4, overflow_4, overflow_4);
        $display("after pop 8 -> output_8: %d_%b, overflow_8: %d_%b\n", output_data_8, output_data_8, overflow_8, overflow_8);
        $display("after pop 16 -> output_16: %d_%b, overflow_16: %d_%b\n", output_data_16, output_data_16, overflow_16, overflow_16);
        $display("after pop 32 -> output_32: %d_%b, overflow_32: %d_%b\n", output_data_32, output_data_32, overflow_32, overflow_32);
        opcode = 3'b000; // No Operation
        #10;
        $finish;
    end
endmodule
