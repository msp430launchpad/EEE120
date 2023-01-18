// Test module for lab 0
`timescale 1ns/1ns          // set a realistic time scale for the simulation

module four_bit_mux_top();

reg [15:0] resp_data[0:7];  // stimulus and response. This array is 8 rows and 16 columns
reg [3:0] in_a;             // the A input to the circuit
reg [3:0] in_b;             // the B input to the circuit
reg in_s;                   // the S input to the circuit
wire [3:0] out_y;           // the Y output
reg [3:0] exp_out;          // the expected output

integer index;              // index into the input/output arrays

initial                     // read the arrays
begin
   $readmemh("four_bit_mux_stim.txt",resp_data);  // read the inputs and expected respnses
end

initial    // all initial blocks run at start up...
begin
   for ( index = 0 ; index < 8 ; index = index+1 )  // for each of the rows in the table
   begin
      $display(resp_data[index]);
      {in_s,in_a,in_b} = resp_data[index][8:0];     // get the next inputs.

      exp_out = resp_data[index][15:12];            // get the expected outputs.

      #10;                                // wait for propagation
      if ( out_y != exp_out )             // did we get what was expected?
         $display("Output mismatch for entry ",index," expected ",
                  exp_out," but got out_y ",out_y);
   end
end

// this instantiates your design
four_bit_mux four_bit_mux(.a(in_a),.b(in_b),.sel(in_s), .y(out_y)); 

// dump the output to a VCD file so the waveform viewer can create the display
initial
begin
   $dumpfile("four_bit_mux_waves.vcd"); // the name of the output file containing the waves
   $dumpvars(0,four_bit_mux);           // 0 dumps all signals from full_adder down
end

endmodule
