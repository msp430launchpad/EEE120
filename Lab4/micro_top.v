// Test module for lab 0
`timescale 1ns/1ns          // set a realistic time scale for the simulation

module micro_top();

wire [11:0] values;           // stimulus and response
reg  [3:0]  in_data_in;       // the data_in input to the circuit
reg         in_reset;         // reset the design
reg         done;             // the simulation is finished

reg         in_clk;           // the clock input

reg  [3:0]  exp_accum;        // the expected accum output

wire [3:0]  accum;            // the actual accum output

reg  [5:0]  addr;             // address into the test_vals memory

integer index;                // the clock number

micro_stim micro_stim(.values(values), .addr(addr));

// create a clock - max number of clock cycles is 32
initial    // all initial blocks run at start up...
begin
    in_clk <= 1'b0;
    for ( index = 0 ; index < 32 ; index = index + 1 )
    begin
       #5 in_clk <= 1'b1;
       #5 in_clk <= 1'b0;
    end
    $display("Exceeded the permitted number of clocks. The max is 32.");
    #1 $finish;   // exceeded the permitted number of clocks
end

initial
begin
   addr     <= 6'b0;
   done     <= 1'b0;
end

always @ ( negedge in_clk )
begin
   exp_accum  <= values[11:8];
   done       <= values[7];

   in_reset     <= values[4];
   in_data_in   <= values[3:0];
end

always @ ( posedge in_clk )
begin
   addr <= addr + 6'b1;
end

always @ ( posedge in_clk )
begin
   #4;                  // wait for things to settle before checking...
   if ( accum != exp_accum )
      $display("Output mismatch for entry ",index," expected accum to be ",
               exp_accum," but got ", accum);
   if ( done == 1'b1 )
      $finish;
end

microprocessor microprocessor(.accum(accum), .data_in(in_data_in),
                              .clk(in_clk), .reset(in_reset));

// dump the output to a VCD file so the waveform viewer can create the display
initial
begin
   $dumpfile("micro_waves.vcd"); // the name of the output file containing the waves
   $dumpvars(0,microprocessor);           // 0 dumps all signals from four_bit_reg down
end

endmodule
