module ALU_Control (
    input wire is_immediate_i,
    input wire [1:0] ALU_CO_i,
    input wire [6:0] FUNC7_i,
    input wire [2:0] FUNC3_i,
    output reg [3:0] ALU_OP_o
);

always @(*) begin
    case (ALU_CO_i)
        2'b00: 
            ALU_OP_o = 4'b0010;
        2'b01: 
            case (FUNC3_i)
                3'b000, 3'b010, 3'b011: 
                    ALU_OP_o = 4'b1010;
                3'b001: 
                    ALU_OP_o = 4'b0011;
                3'b100: 
                    ALU_OP_o = 4'b1100;
                3'b101: 
                    ALU_OP_o = 4'b1110;
                3'b110: 
                    ALU_OP_o = 4'b1101;
                3'b111: 
                    ALU_OP_o = 4'b1111;
                default: 
                    ALU_OP_o = 4'b0000;
            endcase
        2'b10: 
            case (FUNC3_i)
                3'b000: 
                    if (is_immediate_i || FUNC7_i == 7'b0000000)
                        ALU_OP_o = 4'b0010;
                    else
                        ALU_OP_o = 4'b1010;
                3'b111: 
                    ALU_OP_o = 4'b0000;
                3'b110: 
                    ALU_OP_o = 4'b0001;
                3'b100: 
                    ALU_OP_o = 4'b1000;
                3'b010: 
                    ALU_OP_o = 4'b1110;
                3'b011: 
                    ALU_OP_o = 4'b1111;
                3'b001: 
                    ALU_OP_o = 4'b0100;
                3'b101: 
                    ALU_OP_o = (FUNC7_i == 7'b0100000) ? 4'b0111 : 4'b0101;
                default: 
                    ALU_OP_o = 4'b0000;
            endcase
        default: 
            ALU_OP_o = 4'b0000;
    endcase
end

endmodule
