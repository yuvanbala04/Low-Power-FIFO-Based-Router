`timescale 1ns/1ps

module router_1x3_tb;

  // DUT signals
  logic clk;
  logic resetn;
  logic [7:0] data_in;
  logic pkt_valid;
  logic read_enb_0, read_enb_1, read_enb_2;

  wire [7:0] data_out_0, data_out_1, data_out_2;
  wire vld_out_0, vld_out_1, vld_out_2;

  // Instantiate DUT
  router_1x3 dut (
    .clk(clk),
    .resetn(resetn),
    .data_in(data_in),
    .pkt_valid(pkt_valid),
    .read_enb_0(read_enb_0),
    .read_enb_1(read_enb_1),
    .read_enb_2(read_enb_2),
    .data_out_0(data_out_0),
    .data_out_1(data_out_1),
    .data_out_2(data_out_2),
    .vld_out_0(vld_out_0),
    .vld_out_1(vld_out_1),
    .vld_out_2(vld_out_2)
  );

  // Clock generation
  always #5 clk = ~clk;

  // Packet task
  task send_packet(input [1:0] addr, input int payload_len);
    int i;
    reg [7:0] payload;

    begin
      // Header: [7:2] length, [1:0] address
      @(posedge clk);
      pkt_valid = 1;
      data_in = {payload_len[5:0], addr};

      // Payload
      for (i = 0; i < payload_len; i++) begin
        @(posedge clk);
        payload = $random;
        data_in = payload;
      end

      // Parity (dummy)
      @(posedge clk);
      pkt_valid = 0;
      data_in = 8'hAA;

      // Idle
      @(posedge clk);
      data_in = 0;
    end
  endtask

  // Read task
  task read_fifo(input int fifo_id);
    begin
      case(fifo_id)
        0: begin
          while (vld_out_0) begin
            @(posedge clk);
            read_enb_0 = 1;
          end
          read_enb_0 = 0;
        end

        1: begin
          while (vld_out_1) begin
            @(posedge clk);
            read_enb_1 = 1;
          end
          read_enb_1 = 0;
        end

        2: begin
          while (vld_out_2) begin
            @(posedge clk);
            read_enb_2 = 1;
          end
          read_enb_2 = 0;
        end
      endcase
    end
  endtask

  // Initial block
  initial begin
    // Initialize
    clk = 0;
    resetn = 0;
    pkt_valid = 0;
    data_in = 0;
    read_enb_0 = 0;
    read_enb_1 = 0;
    read_enb_2 = 0;

    // Reset
    #20;
    resetn = 1;

    // Send packets to all 3 FIFOs
    #10 send_packet(2'b00, 4); // FIFO0
    #20 send_packet(2'b01, 5); // FIFO1
    #20 send_packet(2'b10, 3); // FIFO2

    // Wait and read
    #50;
    fork
      read_fifo(0);
      read_fifo(1);
      read_fifo(2);
    join

    #100;
    $finish;
  end

  // Monitor
  initial begin
    $monitor("T=%0t | pkt_valid=%b | data_in=%h | out0=%h vld0=%b | out1=%h vld1=%b | out2=%h vld2=%b",
              $time, pkt_valid, data_in,
              data_out_0, vld_out_0,
              data_out_1, vld_out_1,
              data_out_2, vld_out_2);
  end
 initial begin
  $dumpfile("dump.vcd");
  $dumpvars;
end

endmodule