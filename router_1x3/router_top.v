module router_1x3 (
    input clk,
    input resetn,
    input [7:0] data_in,
    input pkt_valid,
    input read_enb_0,
    input read_enb_1,
    input read_enb_2,
    output [7:0] data_out_0,
    output [7:0] data_out_1,
    output [7:0] data_out_2,
    output vld_out_0,
    output vld_out_1,
    output vld_out_2
);

    wire [7:0] data_reg;
    wire [1:0] dest_addr;
    wire [1:0] addr;
    wire detect_add, ld_state, write_enb_reg;
    wire write_enb_0, write_enb_1, write_enb_2;
    wire empty_0, empty_1, empty_2;
    wire full_0, full_1, full_2;
    wire soft_reset_0, soft_reset_1, soft_reset_2;
    
    assign addr = data_in[1:0];
    
    // FSM
    router_fsm fsm (
        .clk(clk),
        .resetn(resetn),
        .pkt_valid(pkt_valid),
        .fifo_full_0(full_0),
        .fifo_full_1(full_1),
        .fifo_full_2(full_2),
        .dest_addr(dest_addr),
        .addr(addr),
        .detect_add(detect_add),
        .ld_state(ld_state),
        .write_enb_reg(write_enb_reg),
        .soft_reset_0(soft_reset_0),
        .soft_reset_1(soft_reset_1),
        .soft_reset_2(soft_reset_2)
    );
    
    // Register
    router_reg reg_block (
        .clk(clk),
        .resetn(resetn),
        .data_in(data_in),
        .soft_reset(soft_reset_0 | soft_reset_1 | soft_reset_2),
        .data_out(data_reg)
    );
    
    // Sync
    router_sync sync (
        .dest_addr(dest_addr),
        .write_enb_reg(write_enb_reg), 
        .write_enb_0(write_enb_0),
        .write_enb_1(write_enb_1),
        .write_enb_2(write_enb_2)
    );
    
    // FIFO0
    router_fifo fifo0 (
        .clk(clk),
        .resetn(resetn),
        .soft_reset(soft_reset_0),
        .write_enb(write_enb_0),
        .read_enb(read_enb_0),
        .data_in(data_reg),
        .data_out(data_out_0),
        .full(full_0),
        .empty(empty_0)
    );
    
    // FIFO1
    router_fifo fifo1 (
        .clk(clk),
        .resetn(resetn),
        .soft_reset(soft_reset_1),
        .write_enb(write_enb_1),
        .read_enb(read_enb_1),
        .data_in(data_reg),
        .data_out(data_out_1),
        .full(full_1),
        .empty(empty_1)
    );
    
    // FIFO2
    router_fifo fifo2 (
        .clk(clk),
        .resetn(resetn),
        .soft_reset(soft_reset_2),
        .write_enb(write_enb_2),
        .read_enb(read_enb_2),
        .data_in(data_reg),
        .data_out(data_out_2),
        .full(full_2),
        .empty(empty_2)
    );
    
    assign vld_out_0 = !empty_0;
    assign vld_out_1 = !empty_1;
    assign vld_out_2 = !empty_2;

endmodule