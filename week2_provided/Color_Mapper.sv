//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//    																						 --
//		Modified by Peter Lee	  12-05-2022										 --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//                                                                       --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 7                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------

module  color_mapper ( input        [9:0] p1x, p1y, p2x, p2y, DrawX, DrawY, Ball_size, SW, ms1x, ms1y, ms2x, ms2y, explosion_x, explosion_y, splashscreen_x, splashscreen_y,
								input [7:0] scorep1, scorep2,
								input [3:0] sprite_enum,sprite_enum2, ui_anim_enum, explosion_enum,
								input [2:0] sprite2_animation,
								input [23:0] p1_accent, p2_accent,
								input clk, blank,
                       output logic [7:0]  Red, Green, Blue );
    
		logic ball1_on, ball2_on;
		logic shape_on, shape2_on;
		logic[10:0] shape_x;
		logic[10:0] shape_y;
		logic[10:0] shape_size_x = 32;
		logic[10:0] shape_size_y = 32;
		logic [7:0] R_next, G_next, B_next;
		
		logic[10:0] score1_addr;
		logic[7:0] score1_data;
		font_rom rm1 (.addr1(score1_addr), .data1(score1_data));
		logic score1_on;
		logic score2_on;

		int DistX1, DistY1,DistX2, DistY2, Size;
		assign DistX1 = DrawX - ms1x;
		assign DistY1 = DrawY - ms1y;
		assign DistX2 = DrawX - ms2x;
		assign DistY2 = DrawY - ms2y;
		assign Size = 4;

		always_comb
		begin:Ball_on_proc
			if ( ( DistX1*DistX1 + DistY1*DistY1) <= (Size * Size) ) 
				ball1_on = 1'b1;
			else 
				ball1_on = 1'b0;
			if ( ( DistX2*DistX2 + DistY2*DistY2) <= (Size * Size) ) 
				ball2_on = 1'b1;
			else 
				ball2_on = 1'b0;
		end 
	
		always_comb
		begin:scoreboard
			if(DrawX >= 268 && DrawX < 300 &&
				DrawY >= 416 && DrawY < 480)
			begin
				score1_on = 1'b1;
				score2_on = 1'b0;
				score1_addr = (((DrawY - 416)>>2) + 16*scorep1);
			end
			else if(DrawX >= 338 && DrawX < 370 &&
				DrawY >= 416 && DrawY < 480)
			begin
				score1_on = 1'b0;
				score2_on = 1'b1;
				score1_addr = (((DrawY - 416)>>2) + 16*scorep2);
			end
			else
			begin
				score1_on = 1'b0;
				score2_on = 1'b0;
				score1_addr = 10'b0;
			end
		end
		
		logic [16:0] bkg_addr;
		logic [2:0] bkg_data;
		frameROM_background rm3 (.read_address(bkg_addr), .data_Out(bkg_data), .Clk(clk));
		
		logic [14:0] splashscreen_addr;
		logic [1:0] splashscreen_data;
		splashscreen rm10 (.read_address(splashscreen_addr), .data_Out(splashscreen_data), .Clk(clk));
		
		logic [13:0] ui_addr;
		logic [2:0] ui_data;
		frameROM_UI rm5 (.read_address(ui_addr), .data_Out(ui_data), .Clk(clk)); 

		logic [13:0] ocm_addr;
		logic [2:0] ocm_data;
		tankROM rm4 (.read_address(ocm_addr), .data_Out(ocm_data), .Clk(clk));
		
		logic [13:0] shadow_addr;
		logic shadow_data;
		tankshadowROM rm6 (.read_address(shadow_addr), .data_Out(shadow_data), .Clk(clk)); 
		
		logic [13:0] marine_addr;
		logic [2:0]marine_data;
		marine_hud_sprite rm7 (.read_address(marine_addr), .data_Out(marine_data), .Clk(clk)); 
		
		logic [13:0] zerg_addr;
		logic [2:0]zerg_data;
		zerg_hud_sprite rm8 (.read_address(zerg_addr), .data_Out(zerg_data), .Clk(clk)); 

		logic [12:0] explosion_addr;
		logic [2:0] explosion_data;
		explosion_sprite rm9 (.read_address(explosion_addr), .data_Out(explosion_data), .Clk(clk));
		
		assign shape_x = p1x;
		assign shape_y = p1y;
		
		logic [7:0] bkg_r, bkg_g, bkg_b;
		logic [7:0] ui_r, ui_g, ui_b;
		

		always_comb
		begin:calculate_background_and_ui
			bkg_addr = (DrawX >> 1) + (DrawY >> 1)*320;
			case(bkg_data)
				3'h0: //0x2e82ba
				begin
					bkg_r = 8'h2e;
					bkg_g = 8'h82;
					bkg_b = 8'hba;
				end
				3'h1: //0x15557e
				begin
					bkg_r = 8'h15;
					bkg_g = 8'h55;
					bkg_b = 8'h7e;
				end
				3'h2: //0x363808
				begin
					bkg_r = 8'h36;
					bkg_g = 8'h38;
					bkg_b = 8'h08;
				end
				3'h3: //0x19223f
				begin
					bkg_r = 8'h19;
					bkg_g = 8'h22;
					bkg_b = 8'h3f;
				end	
				3'h4: //0x684c2f
				begin
					bkg_r = 8'h68;
					bkg_g = 8'h4c;
					bkg_b = 8'h2f;
				end
				3'h5: //0xa47c66
				begin 
					bkg_r = 8'ha4;
					bkg_g = 8'h7c;
					bkg_b = 8'h66;
				end
				3'h6: //0x2b251c
				begin
					bkg_r = 8'h2b;
					bkg_g = 8'h25;
					bkg_b = 8'h1c;
				end
				3'h7: //0x4e3c25
				begin
					bkg_r = 8'h4e;
					bkg_g = 8'h3c;
					bkg_b = 8'h25;
				end
				default: ;
			endcase
			
			ui_addr = (DrawX >> 1) + ((DrawY - 398) >> 1)*320;
			case(ui_data)
				3'h0: //0xff00ff
				begin
					ui_r = bkg_r;
					ui_g = bkg_g;
					ui_b = bkg_b;
				end
				3'h1: //0x000000
				begin
					ui_r = 8'h00;
					ui_g = 8'h00;
					ui_b = 8'h00;
				end
				3'h2: //0x2d2f36
				begin
					ui_r = 8'h2d;
					ui_g = 8'h2f;
					ui_b = 8'h36;
				end
				3'h3: //0x644d33
				begin
					ui_r = 8'h64;
					ui_g = 8'h4d;
					ui_b = 8'h44;
				end	
				3'h4: //0x56699c
				begin
					ui_r = 8'h56;
					ui_g = 8'h69;
					ui_b = 8'h9c;
				end
				3'h5: //0x644d33
				begin 
					ui_r = 8'h64;
					ui_g = 8'h4d;
					ui_b = 8'hd3;
				end
				3'h6: //0xfff33a
				begin
					ui_r = 8'hff;
					ui_g = 8'hf3;
					ui_b = 8'h3a;
				end
				3'h7: //0x1b223d
				begin
					ui_r = 8'h1b;
					ui_g = 8'h22;
					ui_b = 8'h3d;
				end
				default: ;
			endcase
	
		end
// splashscreen logic
	logic [7:0] splash_r, splash_g, splash_b;
	logic splash_on;
    always_comb
    begin:splash_on_on_proc
        if (DrawX >= splashscreen_x && DrawX < splashscreen_x + 247 &&
				DrawY >= splashscreen_y && DrawY < splashscreen_y + 83)
			begin
				splash_on = 1'b1;
				splashscreen_addr = ((DrawX-splashscreen_x) + ((DrawY-splashscreen_y)*247));
				case(splashscreen_data)
					3'h0:
					begin
						splash_r = bkg_r;
						splash_g = bkg_g;
						splash_b = bkg_b;
					end
					3'h1: 
					begin
						splash_r = 8'ha9;
						splash_g = 8'hbc;
						splash_b = 8'hcf;
					end
					3'h2: 
					begin
						splash_r = 8'h2a;
						splash_g = 8'h5d;
						splash_b = 8'h8d;
					end
					3'h3: 
					begin
						splash_r = 8'h75;
						splash_g = 8'ha0;
						splash_b = 8'hc8;
					end
					default: ;
				endcase
			end
			else
			begin
				splash_on = 1'b0;
				splashscreen_addr = 13'b0;
				splash_r = bkg_r;
				splash_g = bkg_g;
				splash_b = bkg_b;
			end
     end
		
	logic [7:0] explosion_r, explosion_g, explosion_b;
	logic explosion_on;
    always_comb
    begin:explosion_on_proc
        if (DrawX >= explosion_x && DrawX < explosion_x + shape_size_x &&
				DrawY >= explosion_y && DrawY < explosion_y + shape_size_y)
			begin
				explosion_on = 1'b1;
				// palette_hex = ['0xff00ff', '0xfefdfa', '0xedce66', '0x923f15', '0x3d190e', '0x2a0402', '0x1d0000', '0x0d0101']
				explosion_addr = ((DrawX-explosion_x) + ((DrawY-explosion_y)<<5) + (explosion_enum<<10));
				case(explosion_data)
					3'h0:
					begin
						explosion_r = bkg_r;
						explosion_g = bkg_g;
						explosion_b = bkg_b;
					end
					3'h1: //0xfefdfa
					begin
						explosion_r = 8'hfe;
						explosion_g = 8'hfd;
						explosion_b = 8'hfa;
					end
					3'h2: //0xedce66
					begin
						explosion_r = 8'hed;
						explosion_g = 8'hce;
						explosion_b = 8'h66;
					end
					3'h3: //0x923f15
					begin
						explosion_r = 8'h92;
						explosion_g = 8'h3f;
						explosion_b = 8'h15;
					end	
					3'h4: //0x3d190e
					begin
						explosion_r = 8'h3d;
						explosion_g = 8'h19;
						explosion_b = 8'h0e;
					end
					3'h5: //0x2a0402
					begin 
						explosion_r = 8'h2a;
						explosion_g = 8'h04;
						explosion_b = 8'h02;
					end
					3'h6: //0x1d0000
					begin
						explosion_r = 8'h1d;
						explosion_g = 8'h00;
						explosion_b = 8'h00;
					end
					3'h7: //0x0d0101
					begin
						explosion_r = 8'h0d;
						explosion_g = 8'h01;
						explosion_b = 8'h01;
					end
					default: ;
				endcase
			end
			else
			begin
				explosion_on = 1'b0;
				explosion_addr = 13'b0;
				explosion_r = bkg_r;
				explosion_g = bkg_g;
				explosion_b = bkg_b;
			end
     end
		

	logic [7:0] sprite1_r, sprite1_g, sprite1_b;
    always_comb
    begin:sprite1_on_proc
        if (DrawX >= shape_x && DrawX < shape_x + shape_size_x &&
				DrawY >= shape_y && DrawY < shape_y + shape_size_y)
			begin
				shape_on = 1'b1;
				// if I want to flip I should do this, similar to lab7:
				// ocm_addr = ((31-(DrawX-shape_x)) + ((DrawY-shape_y)<<5) + (sprite_enum<<10));
				ocm_addr = ((DrawX-shape_x) + ((DrawY-shape_y)<<5) + (sprite_enum<<10));
				case(ocm_data)
					3'h0:
					begin
						if(shadow_data)
						begin
							sprite1_r = bkg_r >> 1;
							sprite1_g = bkg_g >> 1;
							sprite1_b = bkg_b >> 1;
						end
						else
						begin
							sprite1_r = bkg_r;
							sprite1_g = bkg_g;
							sprite1_b = bkg_b;
						end
					end
					3'h1:
					begin
						sprite1_r = 8'h09;
						sprite1_g = 8'h09;
						sprite1_b = 8'h0a;
					end
					3'h2: //0x48505A
					begin
						sprite1_r = 8'h48;
						sprite1_g = 8'h50;
						sprite1_b = 8'h5A;
					end
					3'h3: //0x6A6784
					begin
						sprite1_r = 8'h6A;
						sprite1_g = 8'h67;
						sprite1_b = 8'h84;
					end	
					3'h4: //0x166C72
					begin
						sprite1_r = 8'h16;
						sprite1_g = 8'h6C;
						sprite1_b = 8'h72;
					end
					3'h5: //0xADB1BD
					begin 
						sprite1_r = 8'hAD;
						sprite1_g = 8'hB1;
						sprite1_b = 8'hBD;
					end
					3'h6: //0x4F0000
					begin
						sprite1_r = 8'h4F;
						sprite1_g = 8'h00;
						sprite1_b = 8'h00;
					end
					3'h7: //0xF60202
					begin
						sprite1_r = p1_accent[23:16];//8'hF6;
						sprite1_g = p1_accent[15:8];//8'h02;
						sprite1_b = p1_accent[7:0];//8'h02;
					end
					default: ;
				endcase
			end
			else
			begin
				shape_on = 1'b0;
				ocm_addr = 14'b0;
				sprite1_r = bkg_r;
				sprite1_g = bkg_g;
				sprite1_b = bkg_b;
			end
     end
	  
	logic [7:0] shadow1_r, shadow1_g, shadow1_b;
	logic shadow1_on;
	always_comb
    begin:shadow_on_proc
        if (DrawX >= shape_x && DrawX < shape_x + shape_size_x &&
				DrawY >= (shape_y + 16) && DrawY < (shape_y+16) + shape_size_y)
			begin
				shadow1_on = 1'b1;
				shadow_addr = ((DrawX-shape_x) + ((DrawY-shape_y - 16)<<5) + (sprite_enum<<10));
				case(shadow_data)
					1'h0:
					begin
						shadow1_r = bkg_r;
						shadow1_g = bkg_g;
						shadow1_b = bkg_b;
					end
					1'h1:
					begin
						shadow1_r = bkg_r >> 1;
						shadow1_g = bkg_g >> 1;
						shadow1_b = bkg_b >> 1;
					end
					default: ;
				endcase
			end
			else
			begin
				shadow1_on = 1'b0;
				shadow_addr = 14'b0;
				shadow1_r = bkg_r;
				shadow1_g = bkg_g;
				shadow1_b = bkg_b;
			end
     end

	logic [7:0] marine_r, marine_g, marine_b;
	logic marine_on;
    always_comb
    begin:marine_on_proc
        if (DrawX >= 5 && DrawX < 69 &&
				DrawY >= 414 && DrawY < 478)
			begin
				marine_on = 1'b1;
				marine_addr = (((DrawX-5)>>1) + (((DrawY-414)>>1)<<5) + (ui_anim_enum<<10));
				case(marine_data)
					3'h0: //0x000000
					begin
						marine_r = 8'h00;
						marine_g = 8'h00;
						marine_b = 8'h00;
					end
					3'h1: //0x5c5c6f
					begin
						marine_r = 8'h5c;
						marine_g = 8'h5c;
						marine_b = 8'h6f;
					end
					3'h2: //0x324986
					begin
						marine_r = 8'h32;
						marine_g = 8'h49;
						marine_b = 8'h86;
					end
					3'h3: //0x00064f
					begin
						marine_r = 8'h00;
						marine_g = 8'h06;
						marine_b = 8'h4f;
					end	
					3'h4: //0xeee182
					begin
						marine_r = 8'hee;
						marine_g = 8'he1;
						marine_b = 8'h82;
					end
					3'h5: //0xc87957
					begin 
						marine_r = 8'hc8;
						marine_g = 8'h79;
						marine_b = 8'h57;
					end
					3'h6: //0x573e18
					begin
						marine_r = 8'h57;
						marine_g = 8'h3e;
						marine_b = 8'h18;
					end
					3'h7: //0xb7aea8
					begin
						marine_r = 8'hb7;
						marine_g = 8'hae;
						marine_b = 8'ha8;
					end
					default: ;
				endcase
			end
			else
			begin
				marine_on = 1'b0;
				marine_addr = 14'b0;
				marine_r = Red;
				marine_g = Green;
				marine_b = Blue;
			end
     end


	logic [7:0] zerg_r, zerg_g, zerg_b;
	logic zerg_on;
    always_comb
    begin:zerg_on_proc
        if (DrawX >= 575 && DrawX < 639 &&
				DrawY >= 414 && DrawY < 478)
			begin
				zerg_on = 1'b1;
				zerg_addr = (((DrawX-575)>>1) + (((DrawY-414)>>1)<<5) + (ui_anim_enum<<10));
				case(zerg_data)
					3'h0: //0x000000
					begin
						zerg_r = 8'h00;
						zerg_g = 8'h00;
						zerg_b = 8'h00;
					end
					3'h1: //0x340b05
					begin
						zerg_r = 8'h34;
						zerg_g = 8'h0b;
						zerg_b = 8'h05;
					end
					3'h2: //0x621a05
					begin
						zerg_r = 8'h62;
						zerg_g = 8'h1a;
						zerg_b = 8'h05;
					end
					3'h3: //0xc16921
					begin
						zerg_r = 8'hc1;
						zerg_g = 8'h69;
						zerg_b = 8'h21;
					end	
					3'h4: //0x191818
					begin
						zerg_r = 8'h19;
						zerg_g = 8'h18;
						zerg_b = 8'h18;
					end
					3'h5: //0x5b5b5d
					begin 
						zerg_r = 8'h5b;
						zerg_g = 8'h5b;
						zerg_b = 8'h5d;
					end
					3'h6: //0x4f261a
					begin
						zerg_r = 8'h4f;
						zerg_g = 8'h26;
						zerg_b = 8'h1a;
					end
					3'h7: //0x8e2d0c
					begin
						zerg_r = 8'h8e;
						zerg_g = 8'h2d;
						zerg_b = 8'h0c;
					end
					default: ;
				endcase
			end
			else
			begin
				zerg_on = 1'b0;
				zerg_addr = 14'b0;
				zerg_r = Red;
				zerg_g = Green;
				zerg_b = Blue;
			end
     end
	  
	  
		logic [13:0] p2_addr_a;
		logic [2:0] p2_data_a;
		P2_sprite_ROM_a p2a (.read_address(p2_addr_a), .data_Out(p2_data_a), .Clk(clk)); 
		
		logic [13:0] p2_addr_b;
		logic [2:0] p2_data_b;
		P2_sprite_ROM_b p2b (.read_address(p2_addr_b), .data_Out(p2_data_b), .Clk(clk)); 
		
		logic [13:0] p2_addr_c;
		logic [2:0] p2_data_c;
		P2_sprite_ROM_c p2c (.read_address(p2_addr_c), .data_Out(p2_data_c), .Clk(clk)); 
		
		logic [13:0] p2_addr_d;
		logic [2:0] p2_data_d;
		P2_sprite_ROM_d p2d (.read_address(p2_addr_d), .data_Out(p2_data_d), .Clk(clk)); 
		
		logic [13:0] p2_addr_e;
		logic [2:0] p2_data_e;
		P2_sprite_ROM_e p2e (.read_address(p2_addr_e), .data_Out(p2_data_e), .Clk(clk)); 
		
		logic [2:0] p2_data_selection;
		
		logic [7:0]sprite2_r, sprite2_b, sprite2_g;
		logic [3:0] sprit_enum2_i;
		assign sprit_enum2_i = 8 - (sprite_enum2 % 8);
		always_comb
		begin:sprite2_on_proc
			if (DrawX >= p2x && DrawX < p2x + shape_size_x &&
				DrawY >= p2y && DrawY < p2y + shape_size_y)
			begin
				shape2_on = 1'b1;
				if(sprite_enum2 < 9)
				begin
					p2_addr_a = ((DrawX-p2x) + ((DrawY-p2y)<<5) + (sprite_enum2<<10));
					p2_addr_b = ((DrawX-p2x) + ((DrawY-p2y)<<5) + (sprite_enum2<<10));
					p2_addr_c= ((DrawX-p2x) + ((DrawY-p2y)<<5) + (sprite_enum2<<10));
					p2_addr_d = ((DrawX-p2x) + ((DrawY-p2y)<<5) + (sprite_enum2<<10));
					p2_addr_e = ((DrawX-p2x) + ((DrawY-p2y)<<5) + (sprite_enum2<<10));
				end
				else
				begin
					p2_addr_a = ((31-(DrawX-p2x)) + ((DrawY-p2y)<<5) + (sprit_enum2_i<<10));
					p2_addr_b = ((31-(DrawX-p2x)) + ((DrawY-p2y)<<5) + (sprit_enum2_i<<10));
					p2_addr_c= ((31-(DrawX-p2x)) + ((DrawY-p2y)<<5) + (sprit_enum2_i<<10));
					p2_addr_d = ((31-(DrawX-p2x)) + ((DrawY-p2y)<<5) + (sprit_enum2_i<<10));
					p2_addr_e = ((31-(DrawX-p2x)) + ((DrawY-p2y)<<5) + (sprit_enum2_i<<10));
				end
				case(sprite2_animation)
					3'h0: p2_data_selection = p2_data_a;
					3'h1: p2_data_selection = p2_data_b;
					3'h2: p2_data_selection = p2_data_c;
					3'h3: p2_data_selection = p2_data_d;
					3'h4: p2_data_selection = p2_data_e;
					default: p2_data_selection = p2_data_e;
				endcase
				
				case(p2_data_selection)
					3'h0:
					begin
					// it used to be background
						sprite2_r = sprite1_r;
						sprite2_g = sprite1_g;
						sprite2_b = sprite1_b;
					end
					3'h1: //0xCDBDCA
					begin
						sprite2_r = 8'hCD;
						sprite2_g = 8'hBD;
						sprite2_b = 8'hCA;
					end
					3'h2: //0xECE6EC
					begin
						sprite2_r = 8'hec;
						sprite2_g = 8'he6;
						sprite2_b = 8'hec;
					end
					3'h3: //0x81147E
					begin
						sprite2_r = p2_accent[23:16];//8'h81;
						sprite2_g = p2_accent[15:8];//8'h14;
						sprite2_b = p2_accent[7:0];//8'h7E;
					end	
					3'h4: //0x95777C
					begin
						sprite2_r = 8'h95;
						sprite2_g = 8'h77;
						sprite2_b = 8'h7C;
					end
					3'h5: //0x984430
					begin 
						sprite2_r = 8'h98;
						sprite2_g = 8'h44;
						sprite2_b = 8'h30;
					end
					3'h6: //0x560853
					begin
						sprite2_r = 8'h56;
						sprite2_g = 8'h08;
						sprite2_b = 8'h53;
					end
					3'h7: //0x3D1224
					begin
						sprite2_r = 8'h3D;
						sprite2_g = 8'h12;
						sprite2_b = 8'h24;
					end
					default:
					begin
						sprite2_r = 8'h3D;
						sprite2_g = 8'h12;
						sprite2_b = 8'h24;
					end
				endcase
			end
			else
			begin
				shape2_on = 1'b0;
				p2_addr_a = 14'b0;
				p2_addr_b = 14'b0;
				p2_addr_c = 14'b0;
				p2_addr_d = 14'b0;
				p2_addr_e = 14'b0;
				sprite2_r = Red;
				sprite2_g = Green;
				sprite2_b = Blue;
				p2_data_selection = p2_data_e;
			end 
		end 
  
		always_comb
		begin:color_decision
			if (~blank)
			begin
				R_next = 8'h00;
				G_next = 8'h00;
				B_next = 8'h00;
			end
			else
			begin
				if ((splash_on == 1'b1))
				begin
					R_next = splash_r;
					G_next = splash_g;
					B_next = splash_b;
				end
				else if ((explosion_on == 1'b1))
				begin
					R_next = explosion_r;
					G_next = explosion_g;
					B_next = explosion_b;
				end
				else if ((ball1_on == 1'b1)) 
				begin 
					R_next = p1_accent[23:16];
					G_next = p1_accent[15:8];
					B_next = p1_accent[7:0];
				end
				else if ((ball2_on == 1'b1)) 
				begin 
					R_next = p2_accent[23:16];
					G_next = p2_accent[15:8];
					B_next = p2_accent[7:0];
				end
				else if ((score1_on == 1'b1) && score1_data[7 - ((DrawX-268)>>2)] == 1'b1)
				begin
					R_next = 8'hff;
					G_next = 8'hf3;
					B_next = 8'h3a;
				end
				else if ((score2_on == 1'b1) && score1_data[7 - ((DrawX-338)>>2)] == 1'b1)
				begin
					R_next = 8'hff;
					G_next = 8'hf3;
					B_next = 8'h3a;
				end
				else if ((shape2_on == 1'b1)) 
				begin 
					R_next = sprite2_r;
					G_next = sprite2_g;
					B_next = sprite2_b;
				end

				else if ((shape_on == 1'b1)) //else if ((shape_on == 1'b1) && sprite_data[DrawX-shape_x] == 1'b1) 
				begin 
					R_next = sprite1_r;
					G_next = sprite1_g;
					B_next = sprite1_b;
				end
				
				else if ((shadow1_on == 1'b1)) //else if ((shape_on == 1'b1) && sprite_data[DrawX-shape_x] == 1'b1) 
				begin 
					R_next = shadow1_r;
					G_next = shadow1_g;
					B_next = shadow1_b;
				end
				
				else if (DrawY < 397)
				begin 
					R_next = bkg_r; 
					G_next = bkg_g;
					B_next = bkg_b;
				end
				else if (marine_on)
				begin
					R_next = marine_r; 
					G_next = marine_g;
					B_next = marine_b;
				end
				else if (zerg_on)
				begin
					R_next = zerg_r; 
					G_next = zerg_g;
					B_next = zerg_b;
				end
				else
				begin
					R_next = ui_r; 
					G_next = ui_g;
					B_next = ui_b;
				end
			end
		end
	  
		always_ff @(posedge clk)
		begin:RGB_Display
			Red <= R_next;
			Green <= G_next;
			Blue <= B_next;
		end 
    
endmodule
