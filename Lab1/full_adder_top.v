// Test module for lab 0
`timescale 1ns/1ns          // set a realistic time scale for the simulation

module full_adder_top();

reg [5:0] resp_data[0:7];   // stimulus and response. This array is 4 rows and 6 columns
reg in_a;                   // the a input to the circuit
reg in_b;                   // the b input to the circuit
reg cin;                    // the cin input to the circuit
wire sum;                   // the sum output
wire cout;                  // the cout output
reg [1:0] exp_out;          // the expected output

integer index;              // index into the input/output arrays

initial                     // read the arrays
begin
   $readmemh("full_adder_stim.txt",resp_data);  // read the inputs and expected respnses
end

initial    // all initial blocks run at start up...
begin
   for ( index = 0 ; index < 8 ; index = index+1 )  // for each of the rows in the table
   begin
      {in_a,in_b,cin} = resp_data[index][2:0];      // get the next inputs.

      exp_out = resp_data[index][5:4];              // get the expected outputs.

      #10;                                // wait for propagation
      if ( {cout,sum} != exp_out )         // did we get what was expected?
         $display("Output mismatch for entry ",index," expected ",
                  exp_out," but got cout and sum ",cout,sum);
   end
end

// this instantiates your design
full_adder full_adder(.a(in_a),.b(in_b),.cin(cin), .sum(sum),.cout(cout)); 

// dump the output to a VCD file so the waveform viewer can create the display
initial
begin
   $dumpfile("full_adder_waves.vcd"); // the name of the output file containing the waves
   $dumpvars(0,full_adder);           // 0 dumps all signals from full_adder down
end

endmodule
