
module lab62_soc (
	clk_clk,
	collision_ms1_export,
	collision_ms2_export,
	collisionp1_export,
	collisionp2_export,
	explosion_enum_export,
	explosion_x_export,
	explosion_y_export,
	hex_digits_export,
	key_external_connection_export,
	keycode_export,
	keycode1_export,
	keycode2_export,
	keycode3_export,
	keycode4_export,
	keycode5_export,
	leds_export,
	marine_enum_export,
	missile1_x_export,
	missile1_y_export,
	missile2_x_export,
	missile2_y_export,
	p1_accent_export,
	p1_hit_export,
	p1_suicide_export,
	p2_accent_export,
	p2_hit_export,
	p2_suicide_export,
	player1x_export,
	player1y_export,
	player2x_export,
	player2y_export,
	reset_reset_n,
	scorep1_export,
	scorep2_export,
	sdram_clk_clk,
	sdram_wire_addr,
	sdram_wire_ba,
	sdram_wire_cas_n,
	sdram_wire_cke,
	sdram_wire_cs_n,
	sdram_wire_dq,
	sdram_wire_dqm,
	sdram_wire_ras_n,
	sdram_wire_we_n,
	spi0_MISO,
	spi0_MOSI,
	spi0_SCLK,
	spi0_SS_n,
	sprite2_animation_export,
	sprite_enum2_extern_export,
	sprite_enum_extern_export,
	usb_gpx_export,
	usb_irq_export,
	usb_rst_export,
	splashscreen_x_export,
	splashscreen_y_export);	

	input		clk_clk;
	input		collision_ms1_export;
	input		collision_ms2_export;
	input		collisionp1_export;
	input		collisionp2_export;
	output	[7:0]	explosion_enum_export;
	output	[9:0]	explosion_x_export;
	output	[9:0]	explosion_y_export;
	output	[15:0]	hex_digits_export;
	input	[1:0]	key_external_connection_export;
	output	[7:0]	keycode_export;
	output	[7:0]	keycode1_export;
	output		keycode2_export;
	output		keycode3_export;
	output	[7:0]	keycode4_export;
	output	[7:0]	keycode5_export;
	output	[13:0]	leds_export;
	output	[7:0]	marine_enum_export;
	output	[9:0]	missile1_x_export;
	output	[9:0]	missile1_y_export;
	output	[9:0]	missile2_x_export;
	output	[9:0]	missile2_y_export;
	output	[23:0]	p1_accent_export;
	input		p1_hit_export;
	input		p1_suicide_export;
	output	[23:0]	p2_accent_export;
	input		p2_hit_export;
	input		p2_suicide_export;
	output	[9:0]	player1x_export;
	output	[9:0]	player1y_export;
	output	[9:0]	player2x_export;
	output	[9:0]	player2y_export;
	input		reset_reset_n;
	output	[7:0]	scorep1_export;
	output	[7:0]	scorep2_export;
	output		sdram_clk_clk;
	output	[12:0]	sdram_wire_addr;
	output	[1:0]	sdram_wire_ba;
	output		sdram_wire_cas_n;
	output		sdram_wire_cke;
	output		sdram_wire_cs_n;
	inout	[15:0]	sdram_wire_dq;
	output	[1:0]	sdram_wire_dqm;
	output		sdram_wire_ras_n;
	output		sdram_wire_we_n;
	input		spi0_MISO;
	output		spi0_MOSI;
	output		spi0_SCLK;
	output		spi0_SS_n;
	output	[2:0]	sprite2_animation_export;
	output	[7:0]	sprite_enum2_extern_export;
	output	[7:0]	sprite_enum_extern_export;
	input		usb_gpx_export;
	input		usb_irq_export;
	output		usb_rst_export;
	output	[9:0]	splashscreen_x_export;
	output	[9:0]	splashscreen_y_export;
endmodule
