///////////////////////////////////////////////////////////////////////////////
// Engineer:       Mohamed Atef - mohamedatefp3@gmail.com                     //
//                                                                            //               
//                                                                            //
// Design Name:    DECODER_tb                                                 //
// Project Name:   zero-riscy                                                 //
// Language:       Verilog                                                    //
//                                                                            //                                                //
////////////////////////////////////////////////////////////////////////////////
module DECODER_tb ()        ;
parameter ADDRESS_BITS = 16 ;
  
//inputs form fetch module 
reg [ADDRESS_BITS-1:0] pc         ;
reg [31:0] instruction            ;

//inputs from alu
reg [ADDRESS_BITS-1:0] JALR_target;
reg branch                        ;

//output to fetch module 
wire [ADDRESS_BITS-1:0] target_pc ;  

//outputs to controller 
wire [6:0] op                     ;
wire [2:0] funct3                 ;
wire [6:0] funct7                 ;

//output to GPRs 
wire [4:0] read_sel1              ;
wire [4:0] read_sel2              ;
wire [4:0] write_sel              ;
wire       wen                    ;

//outputs to Pipeline Register
wire [31:0] imm32                 ;
wire [ADDRESS_BITS-1:0] pc_o      ;
wire [11:0] imm12                 ;

//output to mult/div
wire mul_en , mul_operation       ;
wire div_en , div_operation       ;
 
//output to ALU
wire [5:0] alu_control            ;


                       /*
                        ###################################################
                        ############### ///CONECCTIONS//// ################
                        ###################################################
                                                                           */

Decoder #(.ADDRESS_BITS(ADDRESS_BITS)) u1 (
.pc(pc)                   ,
.instruction(instruction) ,

.JALR_target(JALR_target) ,
.branch(branch)           ,

.target_pc(target_pc)     ,

.op(op)                   ,
.funct3(funct3)           ,
.funct7(funct7)           ,

.read_sel1(read_sel1)     ,
.read_sel2(read_sel2)     ,
.write_sel(write_sel)     ,
.wen(wen)                 ,

.imm32(imm32)             ,
.pc_o(pc_o)               ,
.imm12(imm12)             ,

.mul_en(mul_en)           ,
.mul_operation(mul_operation),
.div_en(div_en)           ,
.div_operation(div_operation),

.alu_control(alu_control) 
);

/*
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
                                                                                            */
initial
begin
  initialize();
  #20
  instruction = 32'h00500113 ; // addi x2, x0, 5 
  #20
  instruction = 32'h00C00193; // addi x3, x0, 12
  #20
  instruction = 32'hFF718393; // addi x7, x3, -9
  #20
  instruction = 32'h0023E233; // r x4, x7, x2
  #20
  instruction = 32'h0041F2B3; // and x5, x3, x4
  #20
  instruction = 32'h004282B3; // add x5, x5, x4
  #20
  instruction = 32'h02728863; // beq x5, x7, end
  #20
  instruction = 32'h0041A233; // slt x4, x3, x4
  #20
  instruction = 32'h00020463; // beq x4, x0, around
  #20
  instruction = 32'h00000293; // addi x5, x0, 0 
  #20
  $finish;
end


                      /*
                        ###################################################
                        ################# ///TASK//// #####################
                        ###################################################
                                                                           */
                                                                           
                                                                           
task initialize ;
  begin
        instruction = 32'h0; 
        pc          = 0    ;
        JALR_target = 0    ;
        branch      = 0    ;
  end
endtask
endmodule


