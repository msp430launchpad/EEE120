// Test module for lab 0
`timescale 1ns/1ns          // set a realistic time scale for the simulation

module incrementer_top();

reg [3:0]in_a;              // the a input to the circuit
reg inc;                    // the inc input to the circuit
wire [3:0] sum;             // the y output
wire cry;                   // the cry output

integer index;              // index into the input/output arrays
integer exp_out;            // expected output

initial    // all initial blocks run at start up...
begin
   inc = 1'b1;                                      // set the INC bit so it counts
   for ( index = 0 ; index < 16 ; index = index+1 ) // walk through the values
   begin
      in_a = index[3:0];            // the value to increment
      exp_out = index+1;            // the expected output value

      #10;                                // wait for propagation
      if ( sum != exp_out[3:0] )          // did we get what was expected?
         $display("Output mismatch when incrementing for\nentry ",index," expected ",
                  exp_out[3:0]," but got a sum of ",sum);
      if ( cry != exp_out[4] )            // did we get what was expected?
         $display("Output mismatch when incrementing for\nentry ",index," expected ",
                  exp_out[4]," but got a cry of ",cry);
   end

   inc = 1'b0;     // make sure it doesn't count...
   for ( index = 0 ; index < 3 ; index = index+1 ) // walk through the values
   begin
      in_a = index[3:0];            // the value to increment
      exp_out = in_a;               // the expected output value

      #10;                                // wait for propagation
      if ( sum != exp_out[3:0] )          // did we get what was expected?
         $display("Output mismatch when not incrementing for\nentry ",index," expected ",
                  exp_out[3:0]," but got a sum of ",sum);
      if ( cry != 1'b0 )                  // did we get what was expected?
         $display("Output mismatch when not incrementing for\nentry ",index," expected ",
                  exp_out[4]," but got a cry of ",cry);
   end

end

// this instantiates your design
incrementer incrementer(.a(in_a),.inc(inc),.y(sum),.cry(cry)); 

// dump the output to a VCD file so the waveform viewer can create the display
initial
begin
   $dumpfile("incrementer_waves.vcd"); // the name of the output file containing the waves
   $dumpvars(0,incrementer);           // 0 dumps all signals from incrementer down
end

endmodule
