//Instruction memory 32-bit 

module Instruction_Memory(
    input [31:0] PC,
    input reset,
    output [31:0] im_out
);
    // Byte addressable memory with 32 locations
     reg [7:0] Memory [31:0]; 

    // reset = 0 we assign the im_output code, based on PC
    assign im_out = {Memory[PC+3],Memory[PC+2],Memory[PC+1],Memory[PC]};
    
    // Instruction memory when reset is one
    always @(reset)
      begin
          if(reset == 1)
          begin
             // instruction 1: addi x1, x1,7 => 0x00708093 
            Memory[3] = 8'h00;
            Memory[2] = 8'h70;
            Memory[1] = 8'h80;
            Memory[0] = 8'h93;
             // instruction 2: addi x2, x2, 3 => 0x00310113
            Memory[7] = 8'h00;
            Memory[6] = 8'h31;
            Memory[5] = 8'h01;
            Memory[4] = 8'h13;
             // instruction 3: addi x3, x0, 10 => 0x00A00193
            Memory[11] = 8'h00;
            Memory[10] = 8'ha0;
            Memory[9] = 8'h01;
            Memory[8] = 8'h93;
             // instruction 4: sub x4, x1, x2 => 0x40208233
            Memory[15] = 8'h40;
            Memory[14] = 8'h20;
            Memory[13] = 8'h82;
            Memory[12] = 8'h33;
             // instruction 5: lw x2, 96(x0) => 0x06002113
            Memory[19] = 8'h06;
            Memory[18] = 8'h00;
            Memory[17] = 8'h21;
            Memory[16] = 8'h13;
             // instruction 6: beq x4, x0,1C => 0x00020863
            Memory[23] = 8'h00;
            Memory[22] = 8'h02;
            Memory[21] = 8'h08;
            Memory[20] = 8'h63;
             // instruction 7: and x5, x1, x4 => 0x0040F293
            Memory[27] = 8'h00;
            Memory[26] = 8'h40;
            Memory[25] = 8'hF2;
            Memory[24] = 8'h93;
             // instruction 8: mul x4, x4, x2 => 0x02220213
            Memory[31] = 8'h02;
            Memory[30] = 8'h22;
            Memory[29] = 8'h02;
            Memory[28] = 8'h13; 
             // instruction 9: sw x3, 8(x19) => 0x0089A423
            Memory[35] = 8'h00;
            Memory[34] = 8'h89;
            Memory[33] = 8'ha4;
            Memory[32] = 8'h23;  
             // instruction 10: blt x4,x5,34 => 0x00524863
            Memory[39] = 8'h00;
            Memory[38] = 8'h52;
            Memory[37] = 8'h48;
            Memory[36] = 8'h63;
             // instruction 11: or x6, x5, x2 => 0x0022E313
            Memory[43] = 8'h00;
            Memory[42] = 8'h22;
            Memory[41] = 8'hE3;
            Memory[40] = 8'h13;
             // instruction 12: addi x7, x3, 7 => 0x00D08393
            Memory[47] = 8'h00;
            Memory[46] = 8'hd0;
            Memory[45] = 8'h83;
            Memory[44] = 8'h93;
             // instruction 13: sll x9, x6, x5 => 0x005314B3
            Memory[51] = 8'h00;
            Memory[50] = 8'h53;
            Memory[49] = 8'h14;
            Memory[48] = 8'hb3;
             // instruction 14: div x8, x4, x3 => 0x02324433
            Memory[55] = 8'h02;
            Memory[54] = 8'h32;
            Memory[53] = 8'h44;
            Memory[52] = 8'h33;
             // instruction 15: mulh x2, x2, x3 => 0x02311133
            Memory[59] = 8'h02;
            Memory[58] = 8'h31;
            Memory[57] = 8'h11;
            Memory[56] = 8'h33;
             // instruction 16: xor x5, x6, x8 => 0x008342B3
            Memory[63] = 8'h00;
            Memory[62] = 8'h83;
            Memory[61] = 8'h42;
            Memory[60] = 8'hB3;
             // instruction 17: srl x9, x6, x5 => 0x005354B3
            Memory[67] = 8'h00;
            Memory[66] = 8'h53;
            Memory[65] = 8'h54;
            Memory[64] = 8'hB3;
             // instruction 18: rem x10, x4, x3 => 0x02326533
            Memory[71] = 8'h02;
            Memory[70] = 8'h32;
            Memory[69] = 8'h65;
            Memory[68] = 8'h33;
             // instruction 19: addi x7, x1, -4 => 0xFFC08393
            Memory[75] = 8'hff;
            Memory[74] = 8'hc0;
            Memory[73] = 8'h83;
            Memory[72] = 8'h93;
             // instruction 20: add x4, x7, x5 => 0x00538233
            Memory[79] = 8'h00;
            Memory[78] = 8'h53;
            Memory[77] = 8'h82;
            Memory[76] = 8'h33;
             // instruction 21: bne x5, x3, 58 => 0x00329463
            Memory[83] = 8'h00;
            Memory[82] = 8'h32;
            Memory[81] = 8'h94;
            Memory[80] = 8'h63;
         end
    end

endmodule
