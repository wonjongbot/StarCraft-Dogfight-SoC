module detect_key(	input logic [7:0] keycode, keycode1, keycode2, keycode3, keycode4, keycode5, targetkeycode,
							output logic key_on
						);
	always_comb
	begin
		if(keycode == targetkeycode || keycode1 == targetkeycode || keycode2 == targetkeycode || 
			keycode3 == targetkeycode || keycode4 == targetkeycode || keycode5 == targetkeycode)
			key_on = 1'b1;
		else
			key_on = 1'b0;
	end
endmodule
