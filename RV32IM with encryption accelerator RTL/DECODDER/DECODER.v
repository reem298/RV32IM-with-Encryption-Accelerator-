///////////////////////////////////////////////////////////////////////////////
// Engineer:       Mohamed Atef - mohamedatefp3@gmail.com                     //
//                                                                            //               
//                                                                            //
// Design Name:    Decoder                                                    //
// Project Name:   zero-riscy                                                 //
// Language:       Verilog                                                    //
//                                                                            //
// Description:    The decoder in zero-riscy is responsible for               //
// decoding the instruction fetched from the                                  //
// instruction memory and generating the selection signals                    //                                                                            //
////////////////////////////////////////////////////////////////////////////////
         
module Decoder #( parameter ADDRESS_BITS = 16 )
(

//inputs form fetch module 
input [ADDRESS_BITS-1:0] pc         ,
input [31:0] instruction            ,

//inputs from alu
input [ADDRESS_BITS-1:0] JALR_target,
input branch                        ,

//output to fetch module 
output [ADDRESS_BITS-1:0] target_pc ,  

//outputs to controller 
output [6:0] op                     ,
output [2:0] funct3                 , 
output [6:0] funct7                 , 

//output to GPRs 
output [4:0] read_sel1              ,
output [4:0] read_sel2              ,
output [4:0] write_sel              ,
output reg   wen                    ,

//outputs to Pipeline Register
output [31:0] imm32                 ,
output [11:0] imm12                 , //*****
output [ADDRESS_BITS-1:0] pc_o      ,

//output to mult/div
output reg mul_en , mul_operation   ,
output reg div_en , div_operation   ,
 
//output to ALU
output reg [5:0] alu_control              
);

//op of the instruction
localparam [6:0] R_TYPE     = 7'b0110011,
                 I_TYPE     = 7'b0010011,
                 Load       = 7'b0000011, 
                 STORE      = 7'b0100011,
                 JALR       = 7'b1100111,
                 jAL        = 7'b1101111, 
                 BRANCH     = 7'b1100011,
                 CSR        = 7'B1110011,
                 ENCRYPTION = 7'b0001011;
                 
                
wire [11:0] i_imm                   ; //original 12 bit of the i-type imm instruction
wire [31:0] i_imm_ext               ; //sign extend

wire [4:0]  s_imm_lsb               ; //original lsb 5 bit of the s-type imm instruction
wire [11:5] s_imm_msb               ; //original msb 7 bit of the s-type imm instruction 
wire [31:0] s_imm_ext               ; //sign extend

wire [4:1]  b_imm_lsb               ; //original lsb 5 bit of the b-type imm instruction
wire [12:5] b_imm_msb               ; //original msb 8 bit of the s-type imm instruction 
wire [31:0] b_imm_ext               ; //sign extend

wire [20:0] j_imm                   ; //original (19 bit + 1'b0) of the j-type imm instruction
wire [31:0] j_imm_ext               ; //sign extend

wire [4:0]  shamt_imm               ; //original 5 bits of the imm instruction
wire [31:0] shamt_imm_ext           ; //sign extend

//read registers
assign read_sel1 = instruction[19:15]                 ;
assign read_sel2 = instruction[24:20]                 ;

//destination register
assign write_sel = instruction[11:7]                  ;

//decoding the instructon
assign op        = instruction[7:0]                   ;
assign funct3    = instruction[14:12]                 ;
assign funct7    = instruction[31:25]                 ;

//sign extend calculation
assign i_imm     = instruction[11:0]                  ;
assign i_imm_ext = {{20{i_imm[11]}} , i_imm }         ;

assign s_imm_lsb = instruction[4:0]                   ;
assign s_imm_msb = instruction[11:5]                  ;
assign s_imm_ext = {{20{s_imm_msb[11]}} , s_imm_lsb } ;

assign b_imm_lsb = instruction[4:1]                   ;
assign b_imm_msb = instruction[12:5]                  ;
assign b_imm_ext = {{20{instruction[31]}} ,instruction[7] , instruction[30:25] , instruction[11:8] , 1'b0 } ;

assign j_imm     = {instruction[31] , instruction[19:12] , instruction[20] , instruction[30:21] , instruction[31] , 1'b0 } ;
assign j_imm_ext = {{11{j_imm[20]}} , j_imm }         ;

assign shamt_imm = instruction[24:20]                 ;
assign shamt_imm_ext = {27'b0 , shamt_imm }           ;

assign pc_o      = pc                                           ;//to Pipeline Register


assign imm12 = i_imm                                  ;
assign imm32 = (op == 7'b0000011 ) ? i_imm_ext : //load instruction
               (op == 7'b0100011 ) ? s_imm_ext : //store instruction
               (op == 7'b1100011 ) ? b_imm_ext : //branch instruction
               (op == 7'b1101111 ) ? j_imm_ext : //jump and link instruction
                0;
               
               
assign target_pc = (op == 7'b1100011) && (branch) ? (pc + b_imm_ext[15:0]) : //branch instructions
                   (op == 7'b1101111 )            ? (pc + j_imm_ext[15:0]) : //jal instruction 
                   (op == 7'b1100111 )            ? JALR_target            : //jalr            
                   0;
                   

    
             
//control and output signal for most blocks
always@(*)
begin
wen           = 0         ;
mul_en        = 0         ;
mul_operation = 0         ;
div_en        = 0         ;
div_operation = 0         ;
alu_control   = 6'b101010 ;
      case(op)
        R_TYPE:begin //R-TYPE
                        wen       = 1     ;
                        if(funct3==3'b000)
                          begin
                                if(funct7==7'b0000000)
                                  begin 
                                        alu_control = 6'b000000 ; // add
                                  end
                              else if(funct7==7'b0000001)         //mul
                                  begin
                                        mul_en       = 1          ;
                                        mul_operation= 0          ;
                                  end             
                                else 
                                  begin
                                        alu_control = 6'b001000 ; // sub
                                  end
                        end
                        
                        else if (funct3==3'b001)
                          begin
                                if(funct7==7'b0000000)
                                  begin 
                                         alu_control = 6'b000001 ; // sll
                                  end
                                else                               //mulh
                                  begin
                                         
                                        mul_en        = 1          ;
                                        mul_operation = 1          ;
                                  end
                          end
                            
                        else if (funct3==3'b010)
                            begin
                                         alu_control = 6'b000010 ; // slt
                            end
                            
                        else if (funct3==3'b100)
                            begin
                                if(funct7==7'b0000000)
                                  begin 
                                         alu_control = 6'b000100 ; // xor  
                                  end
                                else                               //div
                                  begin
                                         div_en       = 1        ;
                                         div_operation= 1        ;
                                  end
                            end                      
                          
                        else if (funct3==3'b101)
                          begin
                                if(funct7==7'b0000000)
                                  begin
                                        alu_control = 6'b000101 ; // srl
                                  end
                                else
                                  begin
                                        alu_control = 6'b001101 ; // sra
                                  end
                          end
                          
                        else if (funct3==3'b110)
                          begin
                                if(funct7==7'b0000000)
                                  begin
                                        alu_control = 6'b000110 ; // or
                                  end
                                else                              //rem
                                  begin
                                        div_en       = 1        ;
                                        div_operation= 0        ;
                                  end    
                                        
                          end
                          
                        else if (funct3==3'b111)
                          begin
                                         alu_control = 6'b000111 ; // and
                          end
                          
                        else
                          begin
                                         alu_control = 6'b100000 ; // ideal
                          end
                   end
                   
        I_TYPE:begin //I-TYPE
                        wen       = 1 ;
                        if (funct3==3'b000)
                          begin 
                                       alu_control = 6'b000000 ; // addi 
                          end
                          
                        else if (funct3==3'b001 && funct7==7'b0000000)
                          begin
                                        alu_control = 6'b000001 ; // ssli
                          end
                         
                        else if (funct3==3'b100)
                          begin
                                        alu_control = 6'b000100 ; // xori
                          end
                                       
                        else if (funct3==3'b101)
                          begin
                                if(funct7==7'b0000000)
                                  begin
                                        alu_control = 6'b000101 ; // srli
                                  end
                                else
                                  begin 
                                        alu_control = 6'b001101 ; // srai
                                  end
                          end
                          
                        else if (funct3==3'b110)
                          begin
                                        alu_control = 6'b000110 ; // ori
                          end
                          
                        else if (funct3==3'b111)
                          begin
                                        alu_control = 6'b000111 ; // andi
                          end
                          
                        else
                          begin
                                        alu_control = 6'b100000 ; // ideal
                          end
                          
                   end
                   
        Load:begin // LOAD
                                        wen       = 1 ;      
                                        alu_control = 6'b000000 ; // lw
                  end
                  
        STORE:begin // STORE
                                        wen       = 0 ;
                                        alu_control = 6'b000000 ; // sw
                   end
                 
        JALR:begin //Jump AND LINK REGISTER
                                        wen       = 1 ;
                                        alu_control = 6'b111111 ; // jalr
                   end
                                        
        jAL:begin //Jump AND LINK
                                        wen       = 1 ;
                   end
            
        BRANCH:begin //BRANCH
                                        wen= 0 ;
                        if (funct3==3'b000)
                          begin
                                        alu_control = 6'b010000 ; // beq 
                          end
                          
                        else if (funct3==3'b001)
                          begin
                                        alu_control = 6'b010001 ; // bne
                          end
                          
                        else if (funct3==3'b100)
                          begin
                                        alu_control = 6'b000010 ; // blt
                          end
                            
                        else if (funct3==3'b101)
                          begin
                                        alu_control = 6'b010101 ; // bge
                          end
                          
                        else if (funct3==3'b110)
                          begin
                                        alu_control = 6'b010110 ; // bltu
                          end
                          
                        else if (funct3==3'b111)
                          begin
                                        alu_control = 6'b010111 ; // bgeu
                          end
                  end     
        default :begin
                                         wen           = 0         ;
                                         mul_en        = 0         ;
                                         mul_operation = 0         ;
                                         div_en        = 0         ;
                                         div_operation = 0         ;
                                         alu_control   = 6'b101010 ;
                 end
      endcase
end
endmodule
                        
          
                                        