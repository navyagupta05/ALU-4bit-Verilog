module ALU(
    input [3:0] A, B,          // 4-bit inputs
    input [3:0] ALU_Sel,       // Selection line
    output reg [3:0] ALU_Out,  // 4-bit output
    output CarryOut,            // Carry flag
    output reg Error           // Exception flag
);
// Temporary wire for carry
wire [4:0] tmp;

// Carry logic (only meaningful for addition)
assign tmp = {1'b0, A} + {1'b0, B};
assign CarryOut = tmp[4]; //Carryout flag

// ALU operations
always @(*) begin
    Error = 0;  // default to avoid latch
    case (ALU_Sel)
        4'b0000: ALU_Out = A + B;                // Addition
        4'b0001: ALU_Out = A - B;                // Subtraction
        4'b0010: ALU_Out = A * B;                // Multiplication
        4'b0011: begin                           //Division
            ALU_Out = (B != 0) ? (A / B) : 4'b0000;
            Error   = (B == 0);
        end
        4'b0100: ALU_Out = A << 1;               // Shift Left
        4'b0101: ALU_Out = A >> 1;               // Shift Right
        4'b0110: ALU_Out = {A[2:0], A[3]};       // Rotate Left
        4'b0111: ALU_Out = {A[0], A[3:1]};       // Rotate Right
        4'b1000: ALU_Out = A & B;                // AND
        4'b1001: ALU_Out = A | B;                // OR
        4'b1010: ALU_Out = ~(A & B);             // NAND
        4'b1011: ALU_Out = ~(A | B);             // NOR
        4'b1100: ALU_Out = A ^ B;                // XOR
        4'b1101: ALU_Out = ~(A ^ B);             // XNOR
        4'b1110: ALU_Out = (A > B) ? 4'd1 : 4'd0; // Greater comparison
        4'b1111: ALU_Out = (A == B) ? 4'd1 : 4'd0; // Equal comparison
        default: ALU_Out = 4'b0000;
    endcase
end

endmodule
