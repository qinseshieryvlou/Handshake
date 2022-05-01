`timescale 1ns/1ns
module valid_flop
    #(parameter width = 4)
        (
        input   clk,                                                                   
        input   rst,                                                                   
        input   valid_up,                                                                
        input   [width-1:0] data_up,
        input   ready_down,   
        output ready_up,       
        output reg valid_down,                                                     
        output reg [width-1:0] data_down
        );
        
//valid
always @(posedge clk) begin
    if (!rst)  valid_down <= 1'b0;
    else        valid_down <= ready_up ? valid_up : valid_down;
 end
//data
always @(posedge clk) begin
    if (!rst)  data_down <= {width{1'b0}} ;
    else        data_down <= (ready_up && valid_up) ? data_up : data_down;
end
//ready with buble collapsing.
assign ready_up = ready_down || ~valid_down;
endmodule
