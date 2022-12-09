module joystick	(	input logic clk,
							output logic [1:0] x, y,
							output logic [2:0] button);

// module imported from DE-10 lite demo files by terasic

//=======================================================
//  REG/WIRE declarations
//=======================================================

wire reset_n;
wire sys_clk;


//=======================================================
//  Structural coding
//=======================================================

assign reset_n = 1'b1;
////////////////////////////////////////////
// command
logic  command_valid;
logic  [3:0] command_channel;
logic  command_startofpacket;
logic  command_endofpacket;
logic command_ready;

// continused send command
assign command_startofpacket = 1'b1; // // ignore in altera_adc_control core
assign command_endofpacket = 1'b1; // ignore in altera_adc_control core
assign command_valid = 1'b1; // 
//assign command_channel = SW[2:0]+1; // SW2/SW1/SW0 down: map to arduino ADC_IN0

////////////////////////////////////////////
// response
logic response_valid/* synthesis keep */;
logic [3:0] response_channel;
logic [11:0] response_data;
logic response_startofpacket;
logic response_endofpacket;
logic [4:0]  cur_adc_ch /* synthesis noprune */;
logic [11:0] adc_sample_data /* synthesis noprune */;

always_ff @ (posedge sys_clk)
begin
	if (response_valid)
	begin
		adc_sample_data <= response_data;
		cur_adc_ch <= response_channel;
		case(response_channel)
		4'b0001:
		begin
			if(response_data > 2000)
			begin
				x[0] <= 1'b1;
				x[1] <= 1'b0;
			end
			else if(response_data < 700)
			begin
				x[1] <= 1'b1;
				x[0] <= 1'b0;
			end
			else
			begin
				x[0] <= 1'b0;
				x[1] <= 1'b0;
			end
		end
		4'b0010:
		begin
			if(response_data > 2000)
			begin
				y[0] <= 1'b1;
				y[1] <= 1'b0;
			end
			else if(response_data < 700)
			begin
				y[1] <= 1'b1;
				y[0] <= 1'b0;
			end
			else
			begin
				y[0] <= 1'b0;
				y[1] <= 1'b0;
			end
		end
		4'b0011: if(response_data > 2700) button[0] <= 1'b1; else button[0] <= 1'b0;
		4'b0100: if(response_data > 2700) button[1] <= 1'b1; else button[1] <= 1'b0;
		4'b0101: if(response_data > 2700) button[2] <= 1'b1; else button[2] <= 1'b0;
		4'b0110: ;
		endcase
	end
end			

enum logic [3:0] {a0, a1, a2, a3, a4, a5} state, next_state;
always_ff @ (posedge sys_clk)
begin
	state <= next_state;
end


always_comb
begin
	next_state = state;
	case(state)
		a0:
		begin
			next_state = a1;
			command_channel = 4'b0001;
		end
		a1:
		begin
			next_state = a2;
			command_channel = 4'b0010;
		end
		a2:
		begin
			next_state = a3;
			command_channel = 4'b0011;
		end
		a3: 
		begin
			next_state = a4;
			command_channel = 4'b0100;
		end
		a4:
		begin
			next_state = a5;
			command_channel = 4'b0101;
		end
		a5:
		begin
			next_state = a0;
			command_channel = 4'b0110;
		end
	endcase
end
endmodule