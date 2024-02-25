module reg_param #(parameter size = 4)(
	input clk,    // Clock
	input en, // Enable
	input rst,  // Asynchronous reset active high
	input data_in [size-1:0],	//Input Data
	output reg data_out [size-1:0]	//Output Data
);
	//Registro parametrizable con reset y enable (default 4bits)
	//Reset y enable en ALTO (HIGH)
	reg state [size-1:0];

	always_ff @(posedge clk) begin : next_state
		if(rst) begin
			state <= 0;
		end
		else begin
			if (en) state <= data_in;
			else state <= state;
		end
	end

	always_comb begin : out_assign
		data_out = state;
	end

endmodule : reg_param



module control_unit #(parameter reg_depth = 8)(
	input clk,    // Clock
	input input_signal, // Clock Enable
	input in_destiny [$clog2(reg_depth)-1:0],  // Asynchronous reset active low
	output reg read_en,
	output reg out_destiny [$clog2(reg_depth)-1:0]
	output reg write_en
);

typedef enum [1:0] {idle, read_data, store_result} control_states;

//Unidad de control con 3 estados idle, read_data, store_result

reg state [1:0];
reg destiny [$clog2(reg_depth)-1:0];
always_ff @(posedge clk) begin : next_state //Lógica de siguiente estado 
	if(rst) begin
		state <= idle;
		destiny <= 0;
	end 
	else begin
		case (state) 
			idle: begin
				if (input_signal) begin
					state <= read_data;
					destiny <= in_destiny;
				end 
				else begin
					state <= idle;
					destiny <= destiny;
				end
			end
			read_data: state <= store_result;
			store_result: <= idle;
			default : state <= idle;
		endcase
	end
end


always_comb begin : out_assign //Lógica de salida 
	case (state)
		idle: begin
			read_en = 1'b0;
			write_en = 1'b0;
			out_destiny = 0;
		end
		read_data: begin
		 	read_en = 1'b1;
		 	write_en = 1'b0;
			out_destiny = 0;
		end
		store_result: begin
			read_en = 1'b0;
			write_en = 1'b1;
			out_destiny = destiny;
		end
		default : begin
			read_en = 1'b0;
			write_en = 1'b0;
			out_destiny = 0;
		end
	endcase
end

endmodule : control_unit

