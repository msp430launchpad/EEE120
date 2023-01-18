`timescale 1ns/1ns

// IMPORTANT: DO NOT MODIFY ANYTHING BETWEEN HERE AND *****

// Module to provide stimulus to the four-bit register
module four_bit_reg_stim(num_tests,values,addr);
output [3:0]   num_tests;       // how many tests to apply
output [11:0]  values;          // the values to apply plus expected response
input  [2:0]   addr;            // the address into the memory of values

reg [11:0] test_vals [0:7];     // memory to hold the input and expected output

initial    // check for too many tests
begin
   #1 if ( num_tests > 8 )
      begin
         $display("Too many tests - the limit is 8!");
         $finish;
      end
end

assign values = test_vals[addr];

// The bits of the test_vals memory are:
// 11:8 - expected q value
//  5   - reset input
//  4   - enable input
//  3:0 - d input

// IMPORTANT: ONLY MODIFY BELOW THIS LINE *****

assign num_tests = 8;                // how many tests you want to run

// Each assignment to test_vals[#] is one test.
// NOTE: The maximum number of tests is 8, and they are numbered 0-7.
// NOTE: The tests MUST be numbered consecutively starting with 0.
// NOTE: At least the first test should be reset!
// For the bit assignments, see the comment 14 lines above this line

initial
begin
   test_vals[0] = 12'h0_2_0;
   test_vals[1] = 12'h0_0_0;
   test_vals[2] = 12'h0_0_0;
   test_vals[3] = 12'hF_1_F;
   test_vals[4] = 12'hF_0_A;
   test_vals[5] = 12'h0_2_A;
   test_vals[6] = 12'h0_0_A;
   test_vals[7] = 12'h0_0_A;
end

endmodule
