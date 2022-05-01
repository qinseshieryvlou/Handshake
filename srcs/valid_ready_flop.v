module valid_ready_flop
     #(parameter width = 4)
     (
	input clk, 
	input  rst,
	input [width-1:0] data_up,
	input valid_up,
	output ready_up, 
	input ready_down, 
	output valid_down,
	output [width-1:0] data_down 
    );

	//valid_flop
	reg [width-1:0] data_pipe;
	reg pipe_ready;
	reg pipe_valid;
	
	assign ready_up = pipe_ready || !pipe_valid; 
	
	always @(posedge clk) begin
		if (!rst) begin
			pipe_valid <= 0;
			data_pipe <= 0;
		end
		else begin
			pipe_valid <= (ready_up) ? valid_up : pipe_valid; 
			data_pipe <= (ready_up && valid_up) ? data_up : data_pipe;
		end
	end
	
	//ready_flop
	wire store_data; 
	reg [width-1:0] buffered_data;
	reg buffer_valid;

	assign store_data = pipe_valid && pipe_ready && ~valid_down; 
	always @(posedge clk) begin
		if (!rst)  buffer_valid <= 1'b0;
		else buffer_valid <= buffer_valid ? ~valid_down: store_data; 
    end
    
	always @(posedge clk) begin
		if (!rst)  buffered_data <= 0;
	   else      buffered_data <= store_data ? data_pipe : buffered_data;
    end
    
	always @(posedge clk) begin
		if (!rst)  pipe_ready <= 1'b1; 
		else pipe_ready <= valid_down || ((~buffer_valid) && (~store_data)); 
	end

	assign valid_down = pipe_ready? pipe_valid : buffer_valid;
	assign data_down  = pipe_ready? data_pipe : buffered_data;
endmodule
