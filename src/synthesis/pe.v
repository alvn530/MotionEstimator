module PE (clock, R, s1, s2, s1s2mux, newDist, Accumulate, Rpipe);
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