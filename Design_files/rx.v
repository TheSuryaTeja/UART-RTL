module rx #(parameter clock_frequency = 100000000 )( // in Hz

input clk,
input reset,
input data_in,
input [31:0] baud_rate,
output [7:0]data_out,
output finished
	);



localparam  start_bit = 2'b00 , 
			data_bits = 2'b01 , 
			stop_bit = 2'b10 , 
			wait_state =2'b11;

// local_regs
reg [1:0] state;
reg [7:0] reg_data_out;
reg reg_finished;
reg [31:0]count;
reg [3:0] index;

always @(posedge clk)
if(reset)
begin
	reg_finished <= 1'b0;
	state <= start_bit;
	count <= 0;
	index <= 0;
end

else 
begin
	case(state)

	start_bit : begin
					if(data_in == 1'b0 && count == ((clock_frequency/baud_rate)-1)/2 )		//  sampling at middle	
					begin
						count <= 0;
						state <= data_bits;
					end
					else begin
						count <= count + 1;
					end
				end

	data_bits : begin
					if(count == (clock_frequency/baud_rate)-1)
					begin
						count <=0;
						if(index < 8)
						begin
							reg_data_out[index] = data_in;
							index <= index + 1; 
						end
						else begin
							index <= 0;
							state <= stop_bit;
						end
					end

					else begin
						count <= count + 1;
					end
				end

	stop_bit : begin
				   if(data_in == 1'b1)
				   begin
				   	state <= wait_state;
				   	reg_finished <= 1'b1;
				   end
				   	
			   end

	wait_state : begin
					reg_finished <= 1'b0;
					state <= start_bit;
				 end

	default : state <= start_bit;

	endcase
end

assign data_out = reg_data_out;
assign finished = reg_finished;

endmodule

