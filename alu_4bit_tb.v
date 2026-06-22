`timescale 1ns/1ps

module alu_4bit_tb;

reg [3:0] A_tb;
reg [3:0] B_tb;
reg [1:0] Opcode_tb;
reg clk_tb;
wire [7:0] Y_tb;

// Instantiate DUT
alu_4bit dut (
    .A(A_tb),
    .B(B_tb),
    .Y(Y_tb),
    .clk(clk_tb),
    .Opcode(Opcode_tb)
);

// Clock generation
initial begin
    clk_tb = 0;
    forever #2.5 clk_tb = ~clk_tb;
end

// Stimulus
initial begin

    // Initialize
    #0 A_tb = 0; B_tb = 0; Opcode_tb = 0;

    // Addition
    #5 A_tb = 4'b1010; B_tb = 4'b1011; Opcode_tb = 2'b00;
    
    // Subtraction
    #5 A_tb = 4'b1111; B_tb = 4'b1100; Opcode_tb = 2'b01;

    // AND
    #5 A_tb = 4'b1100; B_tb = 4'b1010; Opcode_tb = 2'b10;

    // XOR
    #5 A_tb = 4'b1100; B_tb = 4'b1010; Opcode_tb = 2'b11;

    #10;
    $finish;

end

endmodule
