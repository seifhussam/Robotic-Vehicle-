module	clk_generator (delay,CLOCK_50);
output reg delay =1'b0;
input CLOCK_50;
reg	[25:0] count;
always @(posedge CLOCK_50)
begin
if(count==26'd25000000)
begin
count<=0;
delay<=~delay;
end
else
count<=count+1;
end
endmodule 