module tx#(parameter clock_frequency = 100000000)(
	input clk,
	input reset,
	input [31:0]baud_rate,
	input [7:0] data_in,
	input input_valid,
	output reg data_out,
	output valid_out,
	output tx_done
	);

localparam wait1 = 3'd0,
		   send_start = 3'd1,
		   send_data = 3'd2,
		   send_stop = 3'd3,
		   wait2 = 3'd4;

//local regstx 
reg [2:0]state;
reg [31:0] count;
reg [3:0]index;
reg [7:0]reg_data_in;
reg reg_valid_out;
reg reg_tx_done;

always @(posedge clk)
if(reset)
	begin
		reg_valid_out <= 1'b0;
		state <= wait1;
		count <= 0;
		index <= 0;
		reg_valid_out <= 0;
		reg_tx_done <= 1'b0;
	end
else begin
	case(state)

	wait1 : begin
				if(input_valid)
				begin
					reg_data_in <= data_in;
					reg_valid_out = 1'b1;
					state <= send_start;			
				end		
			end

	send_start : begin
					if(count < (clock_frequency/baud_rate) - 1)
					begin
						data_out <= 1'b0;
						count <= count + 1;
					end

					else begin
						count <= 0;
						state <= send_data;
					end
				 end
	send_data :  begin
	                if(index < 8)
	                data_out <= reg_data_in [index];
					if(count  < (clock_frequency/baud_rate) -1)
						count <= count + 1; 
					else begin
						count <= 0;
						if(index < 8)
						begin
						index <= index + 1;
						end
						else begin
							index <= 0;
							state <= send_stop;
						end
					end
				 end

	send_stop : begin
					data_out <= 1'b1;
					if(count < (clock_frequency/baud_rate) -1)
					count <= count + 1;
					else begin
						reg_tx_done <= 1;
						count <= 0;
						reg_valid_out <= 0;
						state <= wait2;
					end
				end

	wait2 : begin
				reg_tx_done <= 1'b0;
				state <= wait1;
			end

	default : state <= wait1;
	endcase	
end

assign valid_out = reg_valid_out;
assign tx_done = reg_tx_done;

endmodule
