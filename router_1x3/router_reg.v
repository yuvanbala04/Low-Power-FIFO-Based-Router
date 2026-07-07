module router_reg (
    input clk,
    input resetn,
    input [7:0] data_in,
    input soft_reset,
    output reg [7:0] data_out
);

    always @(posedge clk or negedge resetn) begin
        if (!resetn || soft_reset)
            data_out <= 0;
        else
            data_out <= data_in;
    end
endmodule