module valid_flop_tb 
    #(parameter width = 4);
    reg   clk;                                                                   
    reg   rst;                                                                   
    reg   valid_up;                                                                
    reg   [width-1:0] data_up;
    reg   ready_down;
    wire ready_up;       
    wire valid_down;                                                   
    wire [width-1:0] data_down;
    
	valid_flop  uut(  .clk(clk), 
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
		rst = 0;
		valid_up = 0;
		ready_down = 0;
		data_up = 4'd0;
		
		#5 rst = 0; data_up = 4'd7;
		#5 rst = 1; 
		#5 valid_up = 1; 
		
		#5 valid_up = 0; 
		#5 ready_down = 1; 
		#5 ready_down = 0; 
		
		#5 data_up = 15; valid_up = 1;
		#5 valid_up = 0; 
		#5 ready_down = 1; 
		#5 ready_down = 0; 
		
		#10 $stop;
	end



endmodule
