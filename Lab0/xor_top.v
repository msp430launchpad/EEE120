// Test module for lab 0
`timescale 1ns/1ns          // set a realistic time scale for the simulation

module xor_top();

reg [4:0] resp_data[0:3];   // stimulus and response. This array is 4 rows and 5 columns
reg in_a;                   // the a input to the circuit
reg in_b;                   // the b input to the circuit
wire out_y;                 // the circuit output
reg exp_y;                  // the expected output

integer index;              // index into the input/output arrays

initial                     // read the arrays
begin
   $readmemh("xor_stim.txt",resp_data);  // read the inputs and expected respnses
end

initial    // all initial blocks run at start up...
begin
   for ( index = 0 ; index < 4 ; index = index+1 )  // for each of the rows in the table
   begin
      {in_a,in_b} = resp_data[index][1:0]; // get the next inputs.

      exp_y = resp_data[index][4];         // get the expected outputs.

      #10;                          // wait for propagation
      if ( out_y != exp_y )         // did we get what was expected?
         $display("Output mismatch for entry ",index," expected ",exp_y," but got ",out_y);
   end
end

// this instantiates your design
xor_test xor_test(.a(in_a),.b(in_b),.y(out_y));

// dump the output to a VCD file so the waveform viewer can create the display
initial
begin
   $dumpfile("xor_waves.vcd"); // the name of the output file containing the waves
   $dumpvars(0,xor_test);      // 0 dumps all signals from xor_test down
end

endmodule
