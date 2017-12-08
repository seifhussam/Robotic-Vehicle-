module rotary_encoder (sX, sY, turning, tick, ori, out_sX, out_sY);

input [1:0] ori ; //orientation of car
input sX, sY; // source co-ordinates in dm(decimeters)
input turning ;


input tick; // one click of the rotary enc
output reg[32:0] out_sX = 0 ;
output reg [32:0]  out_sY = 38 ; //our next position 

//where 20 ticks correspond to 2 decimeter  
reg[4:0] count = 4'b0000;

always@(tick)
begin
if (turning == 1'b0)
	if(count == 10)
	begin
		count = 0;
		if (ori == 2'b00) 
		out_sY = out_sY+1 ; 
		else if (ori == 2'b01) 
		out_sX = out_sX +1 ; 
		else if (ori== 2'b10 ) 
		out_sX = out_sX -1 ;
		else out_sY = out_sY-1 ;  
		
	end //ends the else block
	else 	count = count+1; 	 
end //ends always block
endmodule 