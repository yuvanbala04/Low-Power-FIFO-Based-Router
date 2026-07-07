module router_fifo (
    input clk,
    input resetn,
    input soft_reset,
    input write_enb,
    input read_enb,
    input [7:0] data_in,
    output reg [7:0] data_out,
    output reg full,
    output reg empty
);

    reg [7:0] mem [0:15];
    reg [3:0] wr_ptr, rd_ptr;
    reg [4:0] count;

    integer i;

    // ================= WRITE + MEMORY RESET (SINGLE DRIVER) =================
    always @(posedge clk or negedge resetn) begin
        if (!resetn || soft_reset) begin
            for (i = 0; i < 16; i = i + 1)
                mem[i] <= 8'b0;
        end
        else if (write_enb && !full) begin
            mem[wr_ptr] <= data_in;
        end
    end

    // ================= READ =================
    always @(posedge clk or negedge resetn) begin
        if (!resetn || soft_reset)
            data_out <= 8'b0;
        else if (read_enb && !empty)
            data_out <= mem[rd_ptr];
    end

    // ================= POINTERS + COUNT + FLAGS =================
    always @(posedge clk or negedge resetn) begin
        if (!resetn || soft_reset) begin
            wr_ptr <= 4'b0;
            rd_ptr <= 4'b0;
            count  <= 5'b0;
            full   <= 1'b0;
            empty  <= 1'b1;
        end
        else begin

            // WRITE POINTER
            if (write_enb && !full)
                wr_ptr <= wr_ptr + 1;

            // READ POINTER
            if (read_enb && !empty)
                rd_ptr <= rd_ptr + 1;

            // COUNT LOGIC
            case ({write_enb && !full, read_enb && !empty})
                2'b10: count <= count + 1; // write only
                2'b01: count <= count - 1; // read only
                default: count <= count;   // no change or both
            endcase

            // FLAGS
            full  <= (count == 16);
            empty <= (count == 0);
        end
    end

endmodule