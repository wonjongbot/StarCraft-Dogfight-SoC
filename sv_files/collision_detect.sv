//// do it so that it offsets x_pos and checks all 4 corners!
//module collision_detect	(	input clk,
//									input [9:0]x_pos, y_pos,
//									output collision
//								);
//	logic [16:0]col_map_addr0, col_map_addr1, col_map_addr2, col_map_addr3;
//	logic col_map_data_0, col_map_data_1, col_map_data_2, col_map_data_3;
//	
//	assign col_map_addr0 = ((x_pos) >> 1) + (((y_pos)>>1)*320);
//	assign col_map_addr1 = ((x_pos+32) >> 1) + (((y_pos+0)>>1)*320);
//	assign col_map_addr2 = ((x_pos+0) >> 1) + (((y_pos+48)>>1)*320);
//	assign col_map_addr3 = ((x_pos+32) >> 1) + (((y_pos+48)>>1)*320);
//	
//	collision_map u1 (.addr_a(col_map_addr0), .addr_b(col_map_addr1), .Clk(clk), .q_a(col_map_data0),.q_b(col_map_data1));
//	collision_map u2 (.addr_a(col_map_addr2), .addr_b(col_map_addr3), .Clk(clk), .q_a(col_map_data2),.q_b(col_map_data3));
//
//	
//	always_comb
//	begin
//		if(col_map_data0 == 0 || col_map_data1 == 0 || col_map_data2 == 0 || col_map_data3 == 0)
//			collision = 1'b1;
//		else
//			collision = 1'b0;
//	end
//endmodule
//

/////////////////////////////////////////////////////////////////
//// do it so that it offsets x_pos and checks all 4 corners!
//module collision_detect	(	input clk,
//									input [9:0]x_pos, y_pos,
//									output collision
//								);
//	logic [16:0]col_map_addr;
//	logic col_map_data;
//	logic [5:0] x_offset, y_offset;
//	logic tmp_collision, c0, c1, c2, c3, c4, c5, c6, c7;
//	
//	assign col_map_addr = ((x_pos+x_offset) >> 1) + (((y_pos+y_offset)>>1)*320);
//	
//	collision_map u1 (.read_address(col_map_addr), .Clk(clk), .data_Out(col_map_data));
//	
//	always_comb
//	begin
//		case(col_map_data)
//			1'b0:
//			begin
//				tmp_collision = 1'b1;
//			end
//			1'b1:
//			begin
//				tmp_collision = 1'b0;
//			end
//		endcase
//	end
//	
//	enum logic [2:0] {s_0, s_01, s_1, s_11, s_2,s_21, s_3,s_31} state, n_state;
//	
//	always_ff @(posedge clk)
//	begin
//		state<=n_state;
//	end
//	
//	always_comb
//	begin
//		n_state = state;
//		c0 = 1'b0;
//		c1 = 1'b0; 
//		c2 = 1'b0; 
//		c3 = 1'b0;
//		c4 = 1'b0;
//		c5 = 1'b0;
//		c6 = 1'b0;
//		c7 = 1'b0;
//		case(state)
//			s_0:
//				n_state = s_01;
//			s_01:
//				n_state = s_1;
//			s_1:
//				n_state = s_11;
//			s_11:
//				n_state = s_2;
//			s_2:
//				n_state = s_21;
//			s_21:
//				n_state = s_3;
//			s_3:
//				n_state = s_31;
//			s_31:
//				n_state = s_0;
//			default: ;
//		endcase
//		case(state)
//			s_0:
//			begin
//				x_offset = 6'h0;
//				y_offset = 6'h0;
//				if(tmp_collision)
//					c0 = 1'b1;
//				else
//					c0 = 1'b0;
//			end
//			s_01:
//			begin
//				x_offset = 6'h10;
//				y_offset = 6'h0;
//				if(tmp_collision)
//					c1 = 1'b1;
//				else
//					c1 = 1'b0;
//			end
//			s_1:
//			begin
//				x_offset = 6'h20;
//				y_offset = 6'h0;
//				if(tmp_collision)
//					c2 = 1'b1;
//				else
//					c2= 1'b0;
//			end
//			s_11:
//			begin
//				x_offset = 6'h0;
//				y_offset = 6'h18;
//				if(tmp_collision)
//					c3 = 1'b1;
//				else
//					c3 = 1'b0;
//			end
//			s_2:
//			begin
//				x_offset = 6'h0;
//				y_offset = 6'h30;
//				if(tmp_collision)
//					c4 = 1'b1;
//				else
//					c4 = 1'b0;
//			end
//			s_21:
//			begin
//				x_offset = 6'h10;
//				y_offset = 6'h30;
//				if(tmp_collision)
//					c5 = 1'b1;
//				else
//					c5 = 1'b0;
//			end
//			s_3:
//			begin
//				x_offset = 6'h20;
//				y_offset = 6'h30;
//				if(tmp_collision)
//					c6 = 1'b1;
//				else
//					c6 = 1'b0;
//			end
//			s_31:
//			begin
//				x_offset = 6'h20;
//				y_offset = 6'h18;
//				if(tmp_collision)
//					c7 = 1'b1;
//				else
//					c7 = 1'b0;
//			end
//			default:
//			begin
//				c0 = 1'b0;
//				c1 = 1'b0; 
//				c2 = 1'b0; 
//				c3 = 1'b0;
//				c4 = 1'b0;
//				c5 = 1'b0;
//				c6 = 1'b0;
//				c7 = 1'b0;
//			end
//		endcase
//		if(c0 == 1'b1 || c1 == 1'b1 || c2 == 1'b1 || c3 == 1'b1 || c4 == 1'b1 || c5 == 1'b1 || c6 == 1'b1 || c7 == 1'b1)
//			collision = 1'b1;
//		else
//			collision = 1'b0;
//	end
//endmodule



module collision_detect	(	input clk,
									input [9:0]x_pos1, y_pos1, x_pos2, y_pos2,
									output collision1, collision2
								);
	logic [16:0]col_map_addr1;
	logic [16:0]col_map_addr2;
	logic col_map_data1;
	logic col_map_data2;
	
	assign col_map_addr1 = ((x_pos1+16) >> 1) + (((y_pos1+24)>>1)*320);
	assign col_map_addr2 = ((x_pos2+16) >> 1) + (((y_pos2+24)>>1)*320);
	
	collision_map u1 (.addr_a(col_map_addr1), .addr_b(col_map_addr2), .Clk(clk), .q_a(col_map_data1), .q_b(col_map_data2));
	
	always_comb
	begin
		case(col_map_data1)
			1'b0:
			begin
				collision1 = 1'b1;
			end
			1'b1:
			begin
				collision1 = 1'b0;
			end
		endcase
		case(col_map_data2)
			1'b0:
			begin
				collision2 = 1'b1;
			end
			1'b1:
			begin
				collision2 = 1'b0;
			end
		endcase
	end
endmodule

