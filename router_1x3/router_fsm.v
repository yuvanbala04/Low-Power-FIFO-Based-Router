module router_fsm (
    input clk,
    input resetn,
    input pkt_valid,
    input fifo_full_0,
    input fifo_full_1,
    input fifo_full_2,
    input [1:0] addr,
    
    output reg detect_add,
    output reg ld_state,
    output reg write_enb_reg,
    output reg soft_reset_0,
    output reg soft_reset_1,
    output reg soft_reset_2,
    output reg [1:0] dest_addr
);

    // States
    parameter IDLE   = 2'b00;
    parameter DETECT = 2'b01;
    parameter LOAD   = 2'b10;

    reg [1:0] state, next_state;

    // ================= STATE TRANSITION =================
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= IDLE;
        else
            state <= next_state;
    end

    // ================= NEXT STATE LOGIC =================
    always @(*) begin
        case(state)
            IDLE: begin
                if (pkt_valid)
                    next_state = DETECT;
                else
                    next_state = IDLE;
            end

            DETECT: begin
                next_state = LOAD;
            end

            LOAD: begin
                if (!pkt_valid)
                    next_state = IDLE;
                else
                    next_state = LOAD;
            end

            default: next_state = IDLE;
        endcase
    end

    // ================= OUTPUT LOGIC =================
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            detect_add    <= 0;
            ld_state      <= 0;
            write_enb_reg <= 0;
            dest_addr     <= 0;
            soft_reset_0  <= 0;
            soft_reset_1  <= 0;
            soft_reset_2  <= 0;
        end 
        else begin
            // default values
            detect_add    <= 0;
            ld_state      <= 0;
            write_enb_reg <= 0;
            soft_reset_0  <= 0;
            soft_reset_1  <= 0;
            soft_reset_2  <= 0;

            case(state)

                // ================= IDLE =================
                IDLE: begin
                    if (pkt_valid) begin
                        detect_add <= 1;
                        write_enb_reg <=1;
                        dest_addr <= addr;   // capture header
                    end
                end

                // ================= DETECT =================
                DETECT: begin
                    ld_state      <= 1;
                    write_enb_reg <= 1;   // ✅ WRITE HEADER
                    dest_addr     <= addr;
                end

                // ================= LOAD =================
                LOAD: begin
                    ld_state <= pkt_valid;

                    case(dest_addr)
                        2'b00: write_enb_reg <= pkt_valid && !fifo_full_0;
                        2'b01: write_enb_reg <= pkt_valid && !fifo_full_1;
                        2'b10: write_enb_reg <= pkt_valid && !fifo_full_2;
                        default: write_enb_reg <= 0;
                    endcase
                end

            endcase
        end
    end

endmodule