// Test module for lab 0
`timescale 1ns/1ns          // set a realistic time scale for the simulation

module full_adder_top();

reg [19:0] resp_data[0:15]; // stimulus and response. This array is 16 rows and 20 columns
reg [3:0] in_a;             // the a input to the circuit
reg [3:0] in_b;             // the b input to the circuit
reg cin;                    // the cin input to the circuit
wire [3:0] sum;             // the sum output
wire cout;                  // the cout output
wire overfl;                // the overflow output
reg [5:0] exp_out;          // the expected output

integer index;              // index into the input/output arrays

initial                     // read the arrays
begin
   $readmemh("four_bit_adder_stim.txt",resp_data);  // read the inputs and expected respnses
end

initial    // all initial blocks run at start up...
begin
   for ( index = 0 ; index < 16 ; index = index+1 )  // for each of the rows in the table
   begin
      {cin,in_a,in_b} = resp_data[index][8:0];       // get the next inputs.

      exp_out = resp_data[index][17:12];             // get the expected outputs.

      #10;                                    // wait for propagation
      if ( {overfl,cout,sum} != exp_out )     // did we get what was expected?
         $display("Output mismatch for entry ",index," expected ",
                  exp_out," but got overfl, cout, and sum ",overfl,cout,sum);
   end
end

// this instantiates your design
four_bit_adder four_bit_adder(.a(in_a),.b(in_b),.cin(cin), .y(sum),.cout(cout),.overfl(overfl)); 

// dump the output to a VCD file so the waveform viewer can create the display
initial
begin
   $dumpfile("four_bit_adder_waves.vcd"); // the name of the output file containing the waves
   $dumpvars(0,four_bit_adder);           // 0 dumps all signals from full_adder down
end

endmodule
