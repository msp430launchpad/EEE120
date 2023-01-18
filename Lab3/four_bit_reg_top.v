// Test module for lab 0
`timescale 1ns/1ns          // set a realistic time scale for the simulation

module four_bit_reg_top();

wire [11:0] values;           // stimulus and response
reg  [3:0]  in_d;             // the d input to the circuit
reg         in_enable;        // the enable input to the circuit
reg         in_reset;         // the reset input to the circuit
reg         in_clk;           // the clock input

wire [3:0]  q;                // the q output of the circuit

reg  [3:0]  exp_q;            // the expected q output

reg  [2:0]  addr;             // address into the test_vals memory
wire [3:0]  num_tests;        // how many tests

integer index;                // the test number

four_bit_reg_stim four_bit_reg_stim( .num_tests(num_tests), .values(values), .addr(addr));


// create a clock that has 8 clock periods
initial    // all initial blocks run at start up...
begin
    in_clk <= 1'b0;
    for ( index = 0 ; index < num_tests * 2 ; index = index + 1 )
       #5 in_clk <= ~in_clk;
end

initial
begin
   addr     <= 3'b0;
   in_reset <= 1'b1;
end

always @ ( negedge in_clk )
begin
   exp_q     <= values[11:8];
   in_reset  <= values[5];
   in_enable <= values[4];
   in_d      <= values[3:0];
end

always @ ( posedge in_clk )
begin
   addr <= addr + 3'b1;
end

always @ ( posedge in_clk )
begin
   #4;                  // wait for things to settle before checking...
   if ( q != exp_q )
      $display("Output mismatch for entry ",index," expected q to be ",
               exp_q," but got ", q);
end

four_bit_reg four_bit_reg(.q(q), .d(in_d), .enable(in_enable), .clk(in_clk), .reset(in_reset));

// dump the output to a VCD file so the waveform viewer can create the display
initial
begin
   $dumpfile("four_bit_reg_waves.vcd"); // the name of the output file containing the waves
   $dumpvars(0,four_bit_reg);           // 0 dumps all signals from four_bit_reg down
end

endmodule
