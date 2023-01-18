`timescale 1ns/1ns

// IMPORTANT: DO NOT MODIFY ANYTHING BETWEEN HERE AND *****

// Module to provide stimulus to the brainless CPU
module micro_stim(values,addr);
output [11:0]  values;          // the values to apply plus expected response
input  [5:0]   addr;            // the address into the memory of values

reg [11:0] test_vals [0:31];    // memory to hold the input and expected output

assign values = test_vals[addr];

// The bits of the test_vals memory are:
// 11:8 - accum     The expectd accumulator output
//  7   - done      Set this bit to indicate that the simulation should stop
//  4   - reset     Reset the circuit
//  3:0 - data_in   The data_in input

// IMPORTANT: ONLY MODIFY BELOW THIS LINE *****

// Each assignment to test_vals[#] is one test.
// NOTE: The maximum number of tests is 32, and they are numbered 0-31.
// NOTE: The tests MUST be numbered consecutively starting with 0.
// NOTE: At least the first test should be reset!
// For the bit assignments, see the comment 12 lines above this line

initial
begin
   test_vals[ 0] = 12'h0_1_0;     // reset - this should always be the first vector
   test_vals[ 1] = 12'h0_0_0;
   test_vals[ 2] = 12'h3_0_0;
   test_vals[ 3] = 12'h3_0_0;
   test_vals[ 4] = 12'h8_0_0;
   test_vals[ 5] = 12'h8_0_0;
   test_vals[ 6] = 12'h8_8_0;     // end the simulation here
   test_vals[ 7] = 12'h0_0_0;
   test_vals[ 8] = 12'h0_0_0;
   test_vals[ 9] = 12'h0_0_0;
   test_vals[10] = 12'h0_0_0;
   test_vals[11] = 12'h0_0_0;
   test_vals[12] = 12'h0_0_0;
   test_vals[13] = 12'h0_0_0;
   test_vals[14] = 12'h0_0_0;
   test_vals[15] = 12'h0_0_0;
   test_vals[16] = 12'h0_0_0;
   test_vals[17] = 12'h0_0_0;
   test_vals[18] = 12'h0_0_0;
   test_vals[19] = 12'h0_0_0;
   test_vals[20] = 12'h0_0_0;
   test_vals[21] = 12'h0_0_0;
   test_vals[22] = 12'h0_0_0;
   test_vals[23] = 12'h0_0_0;
   test_vals[24] = 12'h0_0_0;
   test_vals[25] = 12'h0_0_0;
   test_vals[26] = 12'h0_0_0;
   test_vals[27] = 12'h0_0_0;
   test_vals[28] = 12'h0_0_0;
   test_vals[29] = 12'h0_0_0;
   test_vals[30] = 12'h0_0_0;
   test_vals[31] = 12'h0_0_0;
end

endmodule
