module fetch_cycle (clk , rst , pc_s0_in , pc_s1_in , ex , pc_dec_in , pc_alu_in , pc_out, pc_plus4);

    // Declare input & outputs
    input          clk, rst;
    input          ex      ;
    input          pc_s0_in , pc_s1_in;
    input  [31:0]  pc_dec_in , pc_alu_in ;
    output [31:0]  pc_out   ;
    output [31:0]  pc_plus4 ;

    // Declaring interim wires
    wire [31:0] PC_F, PCF, PCPlus4F;
    wire [1:0]  pc_s_in ;

    // Declaration of Register
    reg  [31:0] PCF_reg, PCPlus4F_reg;
    

    // Initiation of Modules
    // Declare PC Mux
    Mux PC_MUX  (.a    ( PCF       ),
                 .b    ( pc_alu_in ),
                 .c    ( pc_dec_in ),
                 .d    ( PCPlus4F  ),
                 .s    ( pc_s_in   ),
                 .ex   ( ex        ),
                 .out  ( PC_F      )
                 );

    // Declare PC Counter
    PC_Module Program_Counter (
                .clk     (clk),
                .rst     (rst),
                .PC      (PCF),
                .PC_Next (PC_F)
                );

    // Declare PC adder
    PC_Adder PC_adder (
                .a(PCF),
                .b(32'h00000004),
                .c(PCPlus4F)
                );

    // Fetch Cycle Register Logic
    always @(posedge clk or negedge rst) begin
        if(!rst) begin
            PCF_reg <= 32'h00000000;
            PCPlus4F_reg <= 32'h00000000;
        end
        else
        begin
         PCF_reg       <= PCF;
         PCPlus4F_reg  <= PCPlus4F; 
       end 
    end


    // Assigning Registers Value to the Output port
    assign  pc_s_in  = {pc_s1_in , pc_s0_in} ;
    assign  pc_out   = (rst == 1'b0) ? 32'h00000000 : PCF_reg;
    assign  pc_plus4 = (rst == 1'b0) ? 32'h00000000 : PCPlus4F_reg;
endmodule
