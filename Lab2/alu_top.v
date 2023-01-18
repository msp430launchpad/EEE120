// Test module for lab 0
`timescale 1ns/1ns          // set a realistic time scale for the simulation

module alu_top();

wire [17:0] values;           // stimulus and response.
wire [3:0]  in_a;             // the a input to the circuit
wire [3:0]  in_b;             // the b input to the circuit
wire        in_cin;           // the cin input to the circuit
wire        in_invert;        // the invert input to the circuit
wire        in_arith;         // the arith input to the circuit
wire        in_pass;          // the pass input to the circuit

wire [3:0]  y;                // the y output of the circuit
wire        overfl;           // the overfl output of the circuit
wire        cout;             // the cout output of the circuit

wire [3:0] exp_y;             // the expected Y output
wire       exp_overfl;        // the expected overfl output
wire       exp_cout;          // the expected Cout output

reg  [2:0]   addr;            // address into the test_vals memory
wire [3:0]   num_tests;       // how many tests
wire [511:0] filename;        // the VCD file name

integer index;                // the test number

my_test my_test( .num_tests(num_tests), .values(values), .addr(addr),.filename(filename));

assign exp_overfl = values[17];
assign exp_cout   = values[16];
assign exp_y      = values[15:12];
assign in_cin     = values[11];
assign in_arith   = values[10];
assign in_invert  = values[9];
assign in_pass    = values[8];
assign in_a       = values[7:4];
assign in_b       = values[3:0];

initial    // all initial blocks run at start up...
begin
   for ( index = 0 ; index < num_tests ; index = index+1 )  // for each of the rows in the table
   begin
      addr = index[2:0];                 // select the values
      #5;                                // wait for propagation
      if ( y != exp_y )
         $display("Output mismatch for entry ",index," expected Y to be ",
                  exp_y," but got ", y);
      if ( ( in_arith == 1'b1 ) && ( in_pass == 1'b0 ) )
      begin
         if ( overfl != exp_overfl )
            $display("Output mismatch for entry ",index," expected overfl to be ",
                     exp_overfl," but got ", overfl);
         if ( cout != exp_cout )
            $display("Output mismatch for entry ",index," expected Cout to be ",
                     exp_cout," but got ", cout);
      end
      #5;                                // wait for propagation
   end
end

alu alu(.y(y), .cout(cout), .overfl(overfl), .a(in_a), .b(in_b), .cin(in_cin),
        .invert(in_invert), .arith(in_arith), .pass(in_pass));

// dump the output to a VCD file so the waveform viewer can create the display
initial
begin
   $dumpfile(filename); // the name of the output file containing the waves
   $dumpvars(0,alu);    // 0 dumps all signals from alu down
end

endmodule
