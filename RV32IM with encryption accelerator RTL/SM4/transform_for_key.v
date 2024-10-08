module Transform_for_key_exp (


input  [31:0] data_in,
output [31:0] data_out



);

wire	[7:0]	byte_0;
wire	[7:0]	byte_1;
wire	[7:0]	byte_2;
wire	[7:0]	byte_3;
wire	[7:0]	byte_0_replaced;
wire	[7:0]	byte_1_replaced;
wire	[7:0]	byte_2_replaced;
wire	[7:0]	byte_3_replaced;
wire	[31:0]	word_replaced;

sbox_replace D0
	(
		.data_in(byte_0),
		.result_out(byte_0_replaced)														
	);

sbox_replace	D1
	(
		.data_in(byte_1),
		.result_out(byte_1_replaced)														
	);
	
sbox_replace	D2
	(
		.data_in(byte_2),
		.result_out(byte_2_replaced)														
	);
	
sbox_replace	D3
	(
		.data_in(byte_3),
		.result_out(byte_3_replaced)														
	);		
	


assign  {byte_0,byte_1,byte_2,byte_3} = data_in ;

assign word_replaced = {byte_0_replaced,byte_1_replaced,byte_2_replaced,byte_3_replaced};

assign data_out = (word_replaced ^ {word_replaced[18:0],word_replaced[31:19]}) ^ {word_replaced[8:0],word_replaced[31:9]};


endmodule
	