// =============================================================================
// sc_control.sv
// Main Control Unit - single-cycle RISC-V
//
// Supported instructions:
//   R-type : add, sub, and, or, slt
//   I-type : lw
//   S-type : sw
//   B-type : beq
// =============================================================================

`timescale 1ns / 1ps

module sc_control (
    input  logic [6:0] Opcode,

    output logic       ALUSrc,
    output logic       MemtoReg,
    output logic       RegWrite,
    output logic       MemRead,
    output logic       MemWrite,
    output logic       Branch,
    output logic [1:0] ALUOp
);

    always_comb begin

        // Valores padrão: nenhum acesso à memória,
        // nenhuma escrita em registrador e sem branch.
        ALUSrc   = 1'b0;
        MemtoReg = 1'b0;
        RegWrite = 1'b0;
        MemRead  = 1'b0;
        MemWrite = 1'b0;
        Branch   = 1'b0;
        ALUOp    = 2'b00;

        case (Opcode)

            // -------------------------------------------------------------
            // R-type: add, sub, and, or, slt
            // Opcode = 0110011
            // -------------------------------------------------------------
            7'b0110011: begin
                ALUSrc   = 1'b0;
                MemtoReg = 1'b0;
                RegWrite = 1'b1;
                MemRead  = 1'b0;
                MemWrite = 1'b0;
                Branch   = 1'b0;
                ALUOp    = 2'b10;
            end

            // -------------------------------------------------------------
            // lw
            // Opcode = 0000011
            // -------------------------------------------------------------
            7'b0000011: begin
                ALUSrc   = 1'b1;
                MemtoReg = 1'b1;
                RegWrite = 1'b1;
                MemRead  = 1'b1;
                MemWrite = 1'b0;
                Branch   = 1'b0;
                ALUOp    = 2'b00;
            end

            // -------------------------------------------------------------
            // sw
            // Opcode = 0100011
            // -------------------------------------------------------------
            7'b0100011: begin
                ALUSrc   = 1'b1;
                MemtoReg = 1'b0;
                RegWrite = 1'b0;
                MemRead  = 1'b0;
                MemWrite = 1'b1;
                Branch   = 1'b0;
                ALUOp    = 2'b00;
            end

            // -------------------------------------------------------------
            // beq
            // Opcode = 1100011
            // -------------------------------------------------------------
            7'b1100011: begin
                ALUSrc   = 1'b0;
                MemtoReg = 1'b0;
                RegWrite = 1'b0;
                MemRead  = 1'b0;
                MemWrite = 1'b0;
                Branch   = 1'b1;
                ALUOp    = 2'b01;
            end

            // -------------------------------------------------------------
            // Qualquer opcode não suportado
            // Mantém todos os sinais em estado seguro.
            // -------------------------------------------------------------
            default: begin
                ALUSrc   = 1'b0;
                MemtoReg = 1'b0;
                RegWrite = 1'b0;
                MemRead  = 1'b0;
                MemWrite = 1'b0;
                Branch   = 1'b0;
                ALUOp    = 2'b00;
            end

        endcase
    end

endmodule
