module router_sync (
    input [1:0] dest_addr,
    input write_enb_reg,   
    output reg write_enb_0,
    output reg write_enb_1,
    output reg write_enb_2
);

    always @(*) begin
        write_enb_0 = 0;
        write_enb_1 = 0;
        write_enb_2 = 0;
        
        if (write_enb_reg) begin
            case(dest_addr)
                2'b00: write_enb_0 = 1;
                2'b01: write_enb_1 = 1;
                2'b10: write_enb_2 = 1;
            endcase
        end
    end

endmodule