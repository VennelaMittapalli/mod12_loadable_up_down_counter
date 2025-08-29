module top;

import count_pkg::*;

reg clock;
count_if CIF(clock);

test t_h;

counter DUV(.clock(clock), .din(CIF.din), .load(CIF.load),.up_down(CIF.up_down), .resetn(CIF.resetn), .count(CIF.count));
//counter DUV(.clock(clock), .din(CIF.din), .load(;
initial begin
clock = 1'b0;
forever #10 clock = ~clock;
end

initial begin
if($test$plusargs("TEST1"))
begin
t_h = new(CIF,CIF,CIF);
no_of_transactions = 7;
t_h.build();
t_h.run();
$finish;
end
end

endmodule
