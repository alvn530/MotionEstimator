module pe (clock, R, s1, s2, s1s2mux, newDist, Accumulate, Rpipe);
	input clock;
	input [7:0] R, s1, s2;	// from memory
	input s1s2mux, newDist;	// from control
	output [7:0] Accumulate, Rpipe;
	reg [7:0] Accumulate, AccumulateIn, difference, Rpipe;
	reg Carry;

	always @(posedge clock) Rpipe <= R;
	always @(posedge clock) Accumulate <= AccumulateIn;

	always@(R or s1 or s2 or s1s2mux or newDist or Accumulate)
  	begin
  		difference = R - s1s2mux ? s1 : s2;
		if (difference < 0) difference = 0 - difference;	// absolute subtraction
		{Carry,AccumulateIn} = Accumulate + difference;
		if(Carry == 1) AccumulateIn = 8'hff;	// saturated
		if(newDist == 1) AccumulateIn = difference;	// starting new Distortion calculation
	end
endmodule

module pe_tb;
	reg clock;
	reg [7:0] R, s1, s2;
	reg s1s2mux, newDist;
	wire [7:0] Accumulate, Rpipe;

	integer i;
	integer acc;

	always #10 clock <= ~clock;

	task set_random_inputs();
	begin
		R = $urandom_range(8'hFF,0);
		s1 = $urandom_range(8'hFF,0);
		s2 = $urandom_range(8'hFF,0);
		#100;
	end
	endtask

	task test_normal_operation();
	begin
		set_random_inputs();
		if (i == 0) newDist = 1;
		else newDist = 0;
		acc = acc + newDist ? Accumulate : (R - s1s2mux ? s1 : s2);
		if (Accumulate != acc)
		begin
			$display("ERROR! Expected = %2h, actual = %2h", acc, Accumulate);
			$finish;
		end
	end
	endtask

	initial begin
		clock = 0;
		s1s2mux = 0;
		acc = 0;
		#100;
		for (i = 0; i < 256; i = i + 1) begin
			$srandom(i + 1);
			test_normal_operation();
		end
		s1s2mux = 1;
		acc = 0;
		for (i = 0; i < 256; i = i + 1) begin
			$srandom(i + 1);
			test_normal_operation();
		end
		$display("All tests completed successfully\n\n");
		$finish;
	end

	initial begin
		$monitor("R: %2h, s1: %2h, s2: %2h, s1s2mux: %1b, newDist: %1b, Accumulate: %2h, acc: %2h", R, s1, s2, s1s2mux, newDist, Accumulate, acc);
	end

	pe dut(.clock(clock),
			.R(R),
			.s1(s1),
			.s2(s2),
			.s1s2mux(s1s2mux),
			.newDist(newDist),
			.Accumulate(Accumulate),
			.Rpipe(Rpipe));

endmodule
