module  tankROM
(
		input [13:0] read_address,
		input Clk,

		output logic [4:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [2:0] mem [0:16383];

initial
begin
	 $readmemh("sprite_bytes/merged_sprite.txt", mem);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule



module  tankshadowROM
(
		input [13:0] read_address,
		input Clk,

		output logic [4:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic mem [0:16383];

initial
begin
	 $readmemh("sprite_bytes/ocm_shadow.txt", mem);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule


module  P2_sprite_ROM_a
(
		input [13:0] read_address,
		input Clk,

		output logic [4:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [2:0] mem [0:9215];

initial
begin
	 $readmemh("sprite_bytes/player2/merged_p2_a.txt", mem);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule

module  P2_sprite_ROM_b
(
		input [13:0] read_address,
		input Clk,

		output logic [4:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [2:0] mem [0:9215];

initial
begin
	 $readmemh("sprite_bytes/player2/merged_p2_b.txt", mem);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule

module  P2_sprite_ROM_c
(
		input [13:0] read_address,
		input Clk,

		output logic [4:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [2:0] mem [0:9215];

initial
begin
	 $readmemh("sprite_bytes/player2/merged_p2_c.txt", mem);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule

module  P2_sprite_ROM_d
(
		input [13:0] read_address,
		input Clk,

		output logic [4:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [2:0] mem [0:9215];

initial
begin
	 $readmemh("sprite_bytes/player2/merged_p2_d.txt", mem);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule

module  P2_sprite_ROM_e
(
		input [13:0] read_address,
		input Clk,

		output logic [4:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [2:0] mem [0:9215];

initial
begin
	 $readmemh("sprite_bytes/player2/merged_p2_e.txt", mem);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule