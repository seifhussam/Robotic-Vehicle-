module polarBears( output wire in1,in2,in3,in4,in5,in6,in7,in8,left,right,arrived,fled,rled,lled,input inclk,tick ,fir,lir,rir); 
wire [32:0]  dX =38 ; 
wire [32:0] dY = 20 ;
wire [32:0] sX = 0 ; 
wire [32:0] sY = 38;
wire [32:0] sXout ; 
wire [32:0] sYout ; 
wire outclk ;   
wire enableMD ;
wire turning ;
wire [1:0] ori; 
   
 
clk_generator generator (outclk,inclk) ; 
rotary_encoder encoder (sX,sY,turning , tick , ori , sXout , sYout) ; 
mDrive motorDrive(in1,in2,in3,in4,in5,in6,in7,in8,left,right,turning,arrived,fled,rled,lled,ori,fir,rir,lir,outclk,sXout,sYout,dX,dY) ; 
//motorDrive(in1,in2,in3,in4,in5,in6,in7,in8,left,right,fir,lir,rir,outclk); 
endmodule 
