// Test module for lab 0
`timescale 1ns/1ns          // set a realistic time scale for the simulation

module half_adder_top();

reg [5:0] resp_data[0:3];   // stimulus and response. This array is 4 rows and 6 columns
reg in_a;                   // the a input to the circuit
reg in_b;                   // the b input to the circuit
wire sum;                   // the sum output
wire cry;                   // the cry output
reg [1:0] exp_out;          // the expected output

integer index;              // index into the input/output arrays

initial                     // read the arrays
begin
   $readmemh("half_adder_stim.txt",resp_data);  // read the inputs and expected respnses
end

initial    // all initial blocks run at start up...
begin
   for ( index = 0 ; index < 4 ; index = index+1 )  // for each of the rows in the table
   begin
      {in_a,in_b} = resp_data[index][1:0];          // get the next inputs.

      exp_out = resp_data[index][5:4];              // get the expected outputs.

      #10;                                // wait for propagation
      if ( {cry,sum} != exp_out )         // did we get what was expected?
         $display("Output mismatch for entry ",index," expected ",
                  exp_out," but got cry and sum ",cry,sum);
   end
end

// this instantiates your design
half_adder half_adder(.a(in_a),.b(in_b),.sum(sum),.cry(cry)); 

// dump the output to a VCD file so the waveform viewer can create the display
initial
begin
   $dumpfile("half_adder_waves.vcd"); // the name of the output file containing the waves
   $dumpvars(0,half_adder);           // 0 dumps all signals from half_adder down
end

endmodule
