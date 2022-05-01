module ready_flop_tb
 #(parameter width = 4);
        reg     clk;
        reg     rst;
        reg     valid_up;
        wire    ready_up;
        reg  [width-1:0] data_up;
        wire   valid_down;
        reg      ready_down;
        wire [width-1:0]  data_down;
	
	ready_flop  uut(   .clk(clk), 
                                    .rst(rst), 
                                    .valid_up(valid_up),
                                    .data_up(data_up), 
                                    .ready_down(ready_down),
                                    .ready_up(ready_up),
                                    .valid_down(valid_down),
                                    .data_down(data_down));
	
	always begin
		#2 clk = ~clk;
	end
	
	initial begin
		clk = 0;
		rst = 1;
		valid_up = 0;
		ready_down = 0;
		data_up = 0;
		
		#5 rst = 0;
		#5 rst = 1;
		#5 valid_up = 1; ready_down = 1;
		#5 data_up = 4'd1;
		#5 data_up = 4'd2; 
		#5 data_up = 4'd3;
		#5 data_up = 4'd4;
		#5 data_up = 4'd5;
		#5 data_up = 4'd6;
		#5 data_up = 4'd7;
		#5 data_up = 4'd8; 
		
		#10 $stop;
 end
    

endmodule
