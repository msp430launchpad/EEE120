// Test module for lab 0
`timescale 1ns/1ns          // set a realistic time scale for the simulation

module brainless_top();

wire [27:0] values;           // stimulus and response
reg  [3:0]  in_data_in;       // the d input to the circuit
reg  [3:0]  in_addr_bus;      // the enable input to the circuit
reg         in_invert;        // invert ALU control
reg         in_arith;         // arith ALU control
reg         in_pass;          // pass ALU control
reg         in_load_acc;      // load the accumulator
reg         in_acc_to_db;     // select accumulator
reg         in_reset;         // reset the design
reg         in_write;         // write a value into the RAM
reg         in_read;          // select the RAM output

reg         in_clk;           // the clock input

reg  [3:0]  exp_accum;        // the expected accum output
reg  [3:0]  exp_data_bus;     // the expected data_bus output
reg  [3:0]  exp_alu_out;      // the expected alu output

wire [3:0]  accum;            // the actual accum output
wire [3:0]  data_bus;         // the actual data_bus output
wire [3:0]  alu_out;          // the actual alu output

reg  [2:0]  addr;             // address into the test_vals memory
wire [3:0]  num_tests;        // how many tests

integer index;                // the test number

brainless_stim brainless_stim( .num_tests(num_tests), .values(values), .addr(addr));


// create a clock that has 8 clock periods
initial    // all initial blocks run at start up...
begin
    in_clk <= 1'b0;
    for ( index = 0 ; index < num_tests ; index = index + 1 )
    begin
       #5 in_clk <= 1'b1;
       #5 in_clk <= 1'b0;
    end
end

initial
begin
   addr     <= 3'b0;
end

always @ ( negedge in_clk )
begin
   exp_accum    <= values[27:24];
   exp_data_bus <= values[23:20];
   exp_alu_out  <= values[19:16];

   in_data_in   <= values[15:12];
   in_addr_bus  <= values[11:8];
   in_invert    <= values[7];
   in_arith     <= values[6];
   in_pass      <= values[5];
   in_load_acc  <= values[4];
   in_acc_to_db <= values[3];
   in_reset     <= values[2];
   in_write     <= values[1];
   in_read      <= values[0];
end

always @ ( posedge in_clk )
begin
   addr <= addr + 3'b1;
end

always @ ( posedge in_clk )
begin
   #4;                  // wait for things to settle before checking...
   if ( accum != exp_accum )
      $display("Output mismatch for entry ",index," expected accum to be ",
               exp_accum," but got ", accum);
   if ( alu_out != exp_alu_out )
      $display("Output mismatch for entry ",index," expected alu_out to be ",
               exp_alu_out," but got ", alu_out);
   if ( data_bus != exp_data_bus )
      $display("Output mismatch for entry ",index," expected data_bus to be ",
               exp_data_bus," but got ", data_bus);
end

brainless brainless(.accum(accum), .data_bus(data_bus), .alu_out(alu_out),
                    .data_in(in_data_in), .addr_bus(in_addr_bus),
                    .invert(in_invert), .arith(in_arith), .pass(in_pass),
                    .load_acc(in_load_acc), .acc_to_db(in_acc_to_db),
                    .write(in_write), .read(in_read),
                    .clk(in_clk), .reset(in_reset));

// dump the output to a VCD file so the waveform viewer can create the display
initial
begin
   $dumpfile("brainless_waves.vcd"); // the name of the output file containing the waves
   $dumpvars(0,brainless);           // 0 dumps all signals from four_bit_reg down
end

endmodule
