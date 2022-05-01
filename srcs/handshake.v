// ʵ����������ͬ�����ֳ������������첽����
`timescale 1ns/1ns
module handshake 
    #(parameter width = 4)
    (
	input clk,
	input rst,
	input m_valid,
	input s_ready,
	input [width-1:0] data_in,
	output reg [width-1:0] data_out 
    );
	
	always @(posedge clk) begin
		if (!rst) data_out <= 0;
		else if (m_valid && s_ready) data_out <= data_in;
		else data_out <= data_out;
	end

endmodule