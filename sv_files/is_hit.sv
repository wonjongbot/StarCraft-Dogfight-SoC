module is_hit ( 	input [9:0] p1x, p1y, p2x, p2y,
						output hit
					);

	int dist_x, dist_y;
		// added offset so it points at center of the sprite
	assign dist_x = (p1x + 16) - p2x;
	assign dist_y = (p1y + 16) - p2y;
	
	always_comb
	begin:detect_hits
		if((dist_x * dist_x + dist_y * dist_y) <= 400)
			hit = 1'b1;
		else
			hit = 1'b0;
	end
endmodule