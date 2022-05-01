`timescale 1ns/1ns
module ready_flop
    #(parameter width = 4)
    (input   clk,
    input    rst,
    //Up stream
    input    valid_up,
    output reg ready_up,
    input  [0:width-1] data_up,
    //Down Stream
    output valid_down,
    input      ready_down,
    output [0:width-1]  data_down);

//设定一级寄存器buffer
wire                       store_data;
reg    [width-1:0]         buffered_data;
reg                        buffer_valid;
//---------------------------------------
//buffer.
assign store_data = valid_up && ready_up && ~ready_down;
always @(posedge clk) begin
    if (!rst)  buffer_valid <= 1'b0;
    else        buffer_valid <= buffer_valid ? ~ready_down: store_data;
end
//Note: If now buffer has data, then next valid would be ~ready_down:   
//If downstream is ready, next cycle will be un-valid.    
//If downstream is not ready, keeping high. 
// If now buffer has no data, then next valid would be store_data, 1 for store;
always @(posedge clk) begin
    if (!rst)  buffered_data <= {width{1'b0}};
    else        buffered_data <= store_data ? data_up : buffered_data;
end

always @(posedge clk) begin
    if (!rst)  ready_up <= 1'b1; 
    else        ready_up <= ready_down || ((~buffer_valid) && (~store_data)); //Bubule clampping
end
//Downstream valid and data.
//Bypass
assign valid_down = ready_up? valid_up : buffer_valid;
assign data_down  = ready_up? data_up  : buffered_data;
endmodule

