`include "tx.v"
`include "rx.v"

module top #(parameter clock_frequency = 100000000 )(
	input clk,
	input reset,
	input [31:0]baud_rate,
	input [7:0]data_in,
	input input_valid,
	output [7:0]data_out,
	output finished
	);

wire tx_data_out;
wire tx_done;
wire valid_out;

tx #(.clock_frequency(clock_frequency)) inst1  (
	.clk(clk), 
	.reset(reset),
	.baud_rate(baud_rate),
	.data_in(data_in),
	.data_out(tx_data_out), 
	.tx_done(tx_done),
	.input_valid(input_valid),
	.valid_out(valid_out)
);

rx #(.clock_frequency(clock_frequency)) inst2  (
	.clk(clk), 
	.reset(reset),
	.baud_rate(baud_rate),
	.data_in(tx_data_out),
	.data_out(data_out), 
	.finished(finished)
);

endmodule
