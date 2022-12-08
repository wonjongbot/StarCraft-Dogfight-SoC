/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module  frameROM_background
(
		input [16:0] read_address,
		input Clk,

		output logic [4:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [2:0] mem [0:76799];

initial
begin
	 $readmemh("sprite_bytes/map_cropped_320220.txt", mem);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule


module  frameROM_UI
(
		input [13:0] read_address,
		input Clk,

		output logic [4:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [2:0] mem [0:13119];

initial
begin
	 $readmemh("sprite_bytes/hud_32041.txt", mem);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule

module  explosion_sprite
(
		input [13:0] read_address,
		input Clk,

		output logic [4:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [2:0] mem [0:13119];

initial
begin
	 $readmemh("sprite_bytes/merged_explosion.txt", mem);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule


module  marine_hud_sprite
(
		input [13:0] read_address,
		input Clk,

		output logic [4:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [2:0] mem [0:15359];

initial
begin
	 $readmemh("sprite_bytes/merged_marine.txt", mem);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule


module  zerg_hud_sprite
(
		input [13:0] read_address,
		input Clk,

		output logic [4:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [2:0] mem [0:15359];

initial
begin
	 $readmemh("sprite_bytes/merged_zerg.txt", mem);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule


// Collision map OCM
//module  collision_map
//(
//		input [16:0] read_address,
//		input Clk,
//
//		output logic [4:0] data_Out
//);
//
//// mem has width of 3 bits and a total of 400 addresses
//logic mem [0:76799];
//
//initial
//begin
//	 $readmemb("sprite_bytes/collision_map.txt", mem);
//end
//
//
//always_ff @ (posedge Clk) begin
//	data_Out<= mem[read_address];
//end
//
//endmodule
//
//
//// Quartus Prime Verilog Template
//// Dual Port ROM
//
module collision_map
(
	input [16:0] addr_a, addr_b,
	input Clk, 
	output logic [4:0] q_a, q_b
);

	// Declare the ROM variable
	logic mem[0:76799];

	// Initialize the ROM with $readmemb.  Put the memory contents
	// in the file dual_port_rom_init.txt.  Without this file,
	// this design will not compile.
	// See Verilog LRM 1364-2001 Section 17.2.8 for details on the
	// format of this file.

	initial
	begin
		$readmemh("sprite_bytes/collision_map.txt", mem);
	end

	always @ (posedge Clk)
	begin
		q_a <= mem[addr_a];
		q_b <= mem[addr_b];
	end

endmodule
