`timescale 1ns/1ns

// IMPORTANT: DO NOT MODIFY ANYTHING BETWEEN HERE AND *****

// Module to provide stimulus to the brainless CPU
module brainless_stim(num_tests,values,addr);
output [3:0]   num_tests;       // how many tests to apply
output [27:0]  values;          // the values to apply plus expected response
input  [2:0]   addr;            // the address into the memory of values

reg [27:0] test_vals [0:7];     // memory to hold the input and expected output

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
// 27:23 - accum     The expectd accumulator output
// 23:20 - data_bus  The expected data_bus value
// 19:16 - alu_out   The expected alu output
// 15:12 - data_in   The data_in input
// 11: 8 - addr_bus  The address bus input
//  7    - invert    An ALU control input
//  6    - arith     An ALU control input
//  5    - pass      An ALU control input
//  4    - load_acc  Load the accumulator
//  3    - acc_to_db Select the accumulator value
//  2    - reset     Reset the circuit
//  1    - write     Write a value into the RAM
//  0    - read      Select the program_ram value

// IMPORTANT: ONLY MODIFY BELOW THIS LINE *****

assign num_tests = 8;                // how many tests you want to run

// Each assignment to test_vals[#] is one test.
// NOTE: The maximum number of tests is 8, and they are numbered 0-7.
// NOTE: The tests MUST be numbered consecutively starting with 0.
// NOTE: At least the first test should be reset!
// For the bit assignments, see the comment 14 lines above this line

initial
begin
   test_vals[0] = 28'h0_0_0_0_0_0_4;     // reset - this should always be the first vector
   test_vals[1] = 28'h3_3_3_0_0_3_1;     // get 3 into the accumulator
   test_vals[2] = 28'h8_5_D_0_1_5_1;     // add 3+5 and store in the accumulator
   test_vals[3] = 28'h8_0_0_0_0_0_0;     // do nothing the rest of the way
   test_vals[4] = 28'h8_0_0_0_0_0_0;
   test_vals[5] = 28'h8_0_0_0_0_0_0;
   test_vals[6] = 28'h8_0_0_0_0_0_0;
   test_vals[7] = 28'h8_0_0_0_0_0_0;
end

endmodule
