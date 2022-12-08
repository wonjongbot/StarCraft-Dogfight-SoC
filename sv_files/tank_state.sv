module tank_state( 	input clk, reset, left, right,
							input [3:0] sprite_addr,
							output [9:0] motionx, motiony,
							output [3:0] sprite_addr_calc
							);
	
	always_comb
	begin
	case(sprite_addr)
		4'h0:
			begin
				motionx = 0;
				motiony = -3;
			end
		4'h1:
			begin
				motionx = -1;
				motiony = -3;
			end
		4'h2:
			begin
				motionx = -2;
				motiony = -2;
			end
		4'h3:
			begin
				motionx = -3;
				motiony = -1;
			end
		4'h4:
			begin
				motionx = -3;
				motiony = 0;
			end
		4'h5:
			begin
				motionx = -3;
				motiony = 1;
			end
		4'h6:
			begin
				motionx = -2;
				motiony = 2;
			end
		4'h7:
			begin
				motionx = -1;
				motiony = 3;
			end
		4'h8:
			begin
				motionx = 0;
				motiony = 3;
			end
		4'h9:
			begin
				motionx = 1;
				motiony = 3;
			end
		4'ha:
			begin
				motionx = 2;
				motiony = 2;
			end
		4'hb:
			begin
				motionx = 3;
				motiony = 1;
			end
		4'hc:
			begin
				motionx = 3;
				motiony = 0;
			end
		4'hd:
			begin
				motionx = 3;
				motiony = -1;
			end
		4'he:
			begin
				motionx = 2;
				motiony = -2;
			end

		4'hf:
			begin
				motionx = 1;
				motiony = -3;
			end
	endcase
	end
endmodule
