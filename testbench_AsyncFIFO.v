module testbench;

reg read_clk;
reg write_clk;
reg reset;

wire w_full;
wire r_empty;
wire [7:0] data_out;

Asynchronous_FIFO fifo_inst(
    .read_clk(read_clk),
    .write_clk(write_clk),
    .reset(reset),
    .data_out(data_out),
    .w_full(w_full),
    .r_empty(r_empty)
);

initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, testbench);

    read_clk = 0;
    write_clk = 0;
    reset = 1;
    #10 reset = 0;

    // Write some data into the FIFO
    for (int i = 0; i < 10; i = i + 1) begin
        write_clk = 1;
        #5 write_clk = 0;
    end

    // Read data from the FIFO
    for (int i = 0; i < 5; i = i + 1) begin
        read_clk = 1;
        #7 read_clk = 0;
    end

    // Stop the simulation after some time
    #100 $finish;
end

always #5 write_clk = ~write_clk;
always #7 read_clk = ~read_clk;

endmodule
