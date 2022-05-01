module handshake_tb 
    #(parameter wd = 4);
	reg m_valid; 
	reg s_ready;
	reg rst;
	reg clk;
	reg [wd-1:0] data_in;
	wire [wd-1:0] data_out;
	
	handshake uut(  .clk(clk), 
                                .rst(rst), 
                                .m_valid(m_valid),
                                .s_ready(s_ready), 
                                .data_in(data_in),
                                .data_out(data_out));
	
	always begin
		#1 clk = ~clk;
	end
	
	initial begin
		clk = 0;
		rst = 1;
		m_valid = 0;
		s_ready = 0;
		data_in = 0;
		
		#4 rst = 0; data_in = 4'd8;
		#4 rst = 1;
		#4 m_valid = 1; 
		#4 s_ready = 1; //完成握手
		#4 m_valid = 0; 
		#4 data_in = 4'd12; 
		#4 m_valid = 1; //完成握手
		#4 s_ready = 0; 
		#4 data_in = 4'd9; 
		#45 s_ready = 1; //完成握手
		#5 rst = 0;
		#10 $stop;
	end



endmodule
