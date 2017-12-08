 module motorDrive ( output reg
    in1,
     in2,
      in3,
       in4,
        in5, 
        in6,
         in7,
          in8,
           left,
            right, 
             input fir,
						rir,
						    lir,
						     clk
         )  ;
         always@(posedge clk) 
         begin 
			if (fir)
			begin 
			if (~rir)
			begin 
				in1 =1'b1 ; 
				in2 = 1'b0 ; 
				in3 = 1'b1 ; 
				in4 = 1'b0 ; 
				in5 = 1'b1 ; 
				in6 = 1'b0 ; 
				in7 = 1'b1 ; 
				in8 = 1'b0 ;
				right = 1 ; 
				left = 0 ;
			end 
			else 
			if (~lir) 
			begin
						  in1 = 1'b0 ; 
						  in2 = 1'b1 ; 
						  in3 = 1'b0 ; 
						  in4 = 1'b1 ; 
						  in5 = 1'b0 ; 
						  in6 = 1'b1 ; 
						  in7 = 1'b0 ; 
						  in8 = 1'b1 ; 
						  left = 1 ; 
						  right = 0 ; 
			end 
			else 
			begin 
						  in1 = 1'b0 ; 
						  in2 = 1'b0 ; 
						  in3 = 1'b0 ; 
						  in4 = 1'b0 ; 
						  in5 = 1'b0 ; 
						  in6 = 1'b0 ; 
						  in7 = 1'b0 ; 
						  in8 = 1'b0 ;
			end 
			end 
			else 
			begin 
			in1 = 0 ; 
			in2 = 1 ; 
			in3 = 0 ;
			in4 = 1 ; 
			in5 = 1 ; 
			in6 =0 ; 
			in7 = 1 ;
			in8 = 0 ; 
			left = 1 ; 
			right = 1 ;
			end 
			end  

 endmodule 