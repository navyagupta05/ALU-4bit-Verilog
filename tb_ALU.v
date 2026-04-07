module tb_ALU;

// Inputs
reg [3:0] A, B;
reg [3:0] ALU_Sel;

// Outputs
wire [3:0] ALU_Out;
wire CarryOut;
wire Error;

// Instantiate the ALU (named mapping)
ALU uut (
    .A(A),
    .B(B),
    .ALU_Sel(ALU_Sel),
    .ALU_Out(ALU_Out),
    .CarryOut(CarryOut),
    .Error(Error)
);
// Monitor block 
initial begin
    $monitor("Time=%0t | A=%b B=%b Sel=%b | Out=%b Carry=%b Error=%b",
              $time, A, B, ALU_Sel, ALU_Out, CarryOut, Error);
end

// Test sequence
initial begin
    // Initialize inputs
    A = 4'b1010; 
    B = 4'b0010;

    ALU_Sel = 4'b0000; #100; // ADD
    ALU_Sel = 4'b0001; #100; // SUB
    ALU_Sel = 4'b0010; #100; // MUL
    
    ALU_Sel = 4'b0011; #100; // DIV (normal case)
    B = 4'b0000;             // Division by zero case
    ALU_Sel = 4'b0011; #100; // Check Error flag
    B = 4'b0010;             // restore
    
    ALU_Sel = 4'b0100; #100; // Shift Left
    ALU_Sel = 4'b0101; #100; // Shift Right
    ALU_Sel = 4'b0110; #100; // Rotate Left
    ALU_Sel = 4'b0111; #100; // Rotate Right
    ALU_Sel = 4'b1000; #100; // AND
    ALU_Sel = 4'b1001; #100; // OR
    ALU_Sel = 4'b1010; #100; // NAND
    ALU_Sel = 4'b1011; #100; // NOR
    ALU_Sel = 4'b1100; #100; // XOR
    ALU_Sel = 4'b1101; #100; // XNOR
    ALU_Sel = 4'b1110; #100; // GREATER
    ALU_Sel = 4'b1111; #100; // EQUAL

    $stop;
end

endmodule
