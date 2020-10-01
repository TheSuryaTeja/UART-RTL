`timescale 1ns/1ns

module top_tb;

reg clk=0;
reg reset;
reg [31:0] baud_rate;
reg [7:0]data_in;
reg input_valid;
wire [7:0]data_out;
wire finished;

//local regs

parameter clock_frequency = 100000000;
parameter clock_period = 10; // nano-seconds


top #(.clock_frequency(clock_frequency)) dut  (
	.clk(clk), 
	.reset(reset),
	.baud_rate(baud_rate),
	.data_in(data_in),
	.data_out(data_out), 
	.input_valid(input_valid),
	.finished(finished)
);


always
#5 clk = !clk;

initial
begin
baud_rate = 115200; //change baud_rate here
//pause =(clock_freqency/baud_rate) * clock_period; 
reset = 1;	

@(negedge clk)
reset = 0;	

@(negedge clk)
input_valid <= 1;
data_in <= 8'd37;

@(negedge clk)
input_valid <= 0;  
end


endmodule