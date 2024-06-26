//ALU of RV32IM 
//Author: reem ahmed ali
module ALU #(parameter data_width = 32)
(
  input  logic [5:0] ALU_Control,
  input  logic signed [data_width-1:0] operand_A,
  input  logic signed [data_width-1:0] operand_B,
  output logic signed [data_width-1:0] ALU_result,
  output logic [data_width-1:0] is_less,
  output logic Branch_taken,
  output logic signed [data_width-1:0] JALR_target,
  output logic hold_pipeline,
  output logic zero
  //output logic carry,
  //output logic overflow,
  //output logic negative
);

//internal wires of ALU assigned to the output of the comparator 
logic Greater,Equal,Less;




//comparator intantiation
ALU_Comparator #(32)  cmp (.operand_A(operand_A),.operand_B(operand_B), .Greater(Greater), .Equal(Equal), .Less(Less));

 always @(*) begin
 ALU_result=32'b0;
 is_less=32'b0;
 Branch_taken=1'b0;
 JALR_target=32'b0;
 hold_pipeline=1'b0;
 zero=1'b0;

  case(ALU_Control)
    // Addition and Subtraction
    6'b000000:  ALU_result=operand_A + operand_B; // Add (lW,SW,ADDI, ADD)
    6'b001000:  ALU_result=operand_A - operand_B; // Sub (SUB)

    // Logic Operations
    6'b000110:  ALU_result= operand_A | operand_B; // Or (OR, ORI)
    6'b000100:  ALU_result= operand_A ^ operand_B; // Xor (XORI, XOR)
    6'b000111:  ALU_result= operand_A & operand_B; // And (ANDI, AND)

     // Shift Operations
     6'b000001: ALU_result=operand_A << operand_B; // Logical Shift Left (SLLI, SLL)
     6'b000101: ALU_result= operand_A >> operand_B; // Logical Shift Right (SRLI, SRL)
	   6'b001101: ALU_result=operand_A >>> operand_B;// Arithmetic Shift Right (SRAI, SRA)

     // Signed Less Than (SLTI, SLT)
     6'b000010: begin
      	if(Less)  is_less=32'b1; // Signed Less Than(SLTI,SLT)
        else
          is_less=32'b0;
      end
     //Jump and link rigister (JALR)
     6'b100111: begin 
        JALR_target=operand_A + operand_B; //jalr_address = rs1 + imm;
     end

     // Branch Operations (BEQ, BNE, BLT, BGE, BLTU)
     6'b010000: begin // BEQ
     	if(Equal)begin
      Branch_taken=1'b1;
      zero=1'b1;
      end
      else Branch_taken=1'b0;
     end

     6'b010001: begin // BNE
      if (~Equal)begin
        Branch_taken=1'b1;
        end 
     else Branch_taken=1'b0;
    end

    6'b10010: begin// BLT
    	if(Less)begin
      Branch_taken=1'b1;
      end 
     else Branch_taken=1'b0;
    end

    6'b010101: begin // BGE
      case({Greater,Equal})
        2'b00: begin 
          Branch_taken=1'b0;
          zero= 1'b0;
        end
        2'b01: begin
          Branch_taken=1'b1;
          zero= 1'b1;
        end
        2'b10: begin
          Branch_taken=1'b1;
          zero= 1'b0;
        end
        2'b11: begin
          Branch_taken=1'b1;
          zero= 1'b1;
        end
      endcase
    end

    //unsined
    6'b010110:begin  // BLTU
    	if(Less) begin
      Branch_taken=1'b1;
      end
      else Branch_taken=1'b0;
    end
    
    6'b010111: begin // BGEU
      case({Greater,Equal})
        2'b00: begin 
          Branch_taken=1'b0;
          zero= 1'b0;
        end
        2'b01: begin
          Branch_taken=1'b1;
          zero= 1'b1;
        end
        2'b10: begin
          Branch_taken=1'b1;
          zero= 1'b0;
        end
        2'b11: begin
          Branch_taken=1'b1;
          zero= 1'b1;
        end
      endcase
    end

	default:begin
   ALU_result= 32'b0;  Branch_taken=1'b0; hold_pipeline=1'b0; zero=1'b0;// Default Case
 end
  endcase

//hold_pipeline signal(branch instructions)
if (Branch_taken==1 && operand_B[11]==0) begin
  hold_pipeline=1'b1;
end
else begin
  hold_pipeline=1'b0;
end

end

// Flags( zero,overflow,negative)
//assign zero = ~(|ALU_result); //ALU_result is zero
//assign overflow = ({carry, ALU_result[data_width-1]} == 2'b01); 
//assign negative = (ALU_result[data_width-1] == 1 && (ALU_Control == 6'b001000)); //last bit is one and subtraction is performed

endmodule