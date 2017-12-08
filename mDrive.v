module mDrive (output reg
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
             turning,
             arrived ,
             fled ,
             rled , 
             lled ,
              output reg [1:0] cori,
      input fir,
       rir,
        lir,
         clk
         ,input [32:0] sX ,
						sY 
						,dX ,
						dY
      ) ; 
 reg goLeft , goRight , goLeft1 ,goRight1,goLeft2,goRight2; 
reg enableMD ; 
reg [39:0]  mapx [39:0];
reg [1:0] pori;
reg [1:0] fpref;
reg [1:0] spref; 
integer maxLeft ; 
integer maxRight ;
reg case1 ; 
reg case2 ; 
reg case3 ; 
reg case4 ;   
integer temp1,temp2,temp3,temp4 ; 
reg initiateMap ;
integer j,i,j1,i1,i2,j2,i3,j3,i4,j4; 
reg in1F , in2F , in3F , in4F, in5F , in6F, in7F , in8F  ; 
reg in1R , in2R , in3R , in4R, in5R , in6R, in7R , in8R  ; 
reg in1L , in2L , in3L , in4L, in5L , in6L, in7L , in8L  ; 
reg in1B , in2B , in3B , in4B, in5B , in6B, in7B , in8B  ; 
reg fEnable , lEnable , rEnable,bEnable  = 0 ; 

// case

always@(i1)    
begin  
		if (j1 < temp1) 
		begin 
		if (i1 >0) 
		begin 
		// my code
			if( ~mapx [i][j] &&  ~mapx[i-1][j] &&  ~mapx[i][j+1] && ~mapx[i-1][j+1] )  // lw mesh fadya 
			begin 
			maxLeft = maxLeft +1 ;
			i1 = i1-1  ;
			case1 = 1'b0 ;  
			end 
			else  
			case1 = 1'b1 ; 
		end 
		else 
		begin
		j1 = j1 +2 ; 
		 i1 = sX-1  ;
		 end 
		end 
		
		else 
		case1 = 1'b1 ; 
		 
end 
// case 2'b01 

always @(i2) 
begin
		if (j2 < temp2) 
		begin 
		if (i2 < 38) 
		begin 
		// my code
			if( ~mapx [i2][j2] &&  ~mapx[i2+1][j2] &&  ~mapx[i2][j2+1] && ~mapx[i2+1][j2+1] )  // lw mesh fadya 
			begin 
			maxRight = maxRight +1 ;
			i2 = i2+1; 
			case2 = 1'b0 ;
			end 
			else  
			case2 = 1'b1 ; 
		end 
		else 
		begin
		j2 = j2+2 ; 
		 i2 = sX+1  ; 
		 end
		end 
		else case2 = 1'b1 ;
end 

 //check case1 and case 2 
always @ (case1 or case2) 
begin 
		if (case1 && case2 ) 
		begin
		 if (maxRight > maxLeft) 
			 goLeft1 = 1'b1 ; 
			 else 
			 goRight1 = 1'b1 ; 
		end 
end 

// case 4 
always @(i4) 
begin 
	if (j4 > temp4) 
		begin 
		if (i4<38) 
		begin 
		// my code
		if( ~mapx [i4][j4] &&  ~mapx[i4+1][j4] &&  ~mapx[i4][j4+1] && ~mapx[i4+1][j4+1] ) 
			begin 
			maxRight = maxRight +1 ;
			i4 = i4+1 ; 
			case4 = 1'b0 ;
			end 
			else  
			case4 = 1'b1 ; 
		end 
		else 
		begin
		j4 = j4-2 ; 
		 i4 = sX+1  ;
		 end 
		end 
		else 
		case4 = 1'b1 ;
		
end 
// case 3

always @(i3 ) 
begin 
	if (j3 > temp3) 
		begin 
		if (i3>0) 
		begin 
		// my code
		if( ~mapx [i3][j3] &&  ~mapx[i3-1][j3] &&  ~mapx[i3][j3+1] && ~mapx[i3-1][j3+1] ) 
			begin 
			maxLeft = maxLeft +1 ;
			i3 = i3-1 ; 
			case3 = 1'b0 ;
			end 
			else  
			case3 = 1'b1 ; 
		end 
		else
		begin 
		j3 = j3-2 ; 
		 i3 = sX-1  ; 
		 end 
		end 
		else 
		case3 = 1'b1 ; 
end 
// check case 3 and 4
always @(case3 or case4 ) 
begin 
	if (case3 && case4 ) 
			begin
			 if (maxRight > maxLeft) 
			 goLeft2 = 1'b1 ; 
			 else 
			 goRight2 = 1'b1 ; 
			end 
end 

always @ (posedge clk)
 begin  
		if(enableMD) 
		begin  
	if((sX < dX + 1 && sX > dX -1) && (sY < dY + 1 && sY > dY - 1)) 
	begin
	in1B = 1'b0 ;
	in2B = 1'b0 ;
	in3B = 1'b0 ;
	in4B = 1'b0 ;
	in5B = 1'b0 ;
	in6B = 1'b0 ; 
	in7B = 1'b0 ;
	in8B = 1'b0 ; 
	bEnable = 1'b1 ; 
    arrived = 1'b1 ;
	//disable all four motors because i arrived							
	end  
else
//didnt arrive								
	begin 
	if ( fir || ( fpref == spref) )
	//if i cant keep going because there's an obstacle ahead or I finished x alone or y alone 
	
	// remember to brake before turning ...   check 
	begin
		  
			  if (spref == 2'b01) 
			//finished the y
			begin
			// --> either fir == 1 or I finished Y distance ;) 
				if (~rir) 
				goRight = 1'b1 ; 
				 else goLeft = 1'b1 ;
				 
				 
			  end 
						
						else if (spref == 2'b10)
						begin															
						// --> either fir == 1 or I finished Y distance ;) 
						if (~lir)
						goLeft = 1'b1 ; 
						    else  
							goRight = 1'b1 ; 
						  
																						 
						end
						   
						    else if (spref==2'b00) 
						    begin 
						    // distance x finished ;) 
						    if ((pori==2'b00 )&& (fir == 1'b0)) 
						    begin 
												
												in1F = 1'b1 ; 
												in2F = 1'b0 ;
												in3F = 1'b1 ; 
												in4F = 1'b0 ; 
												in5F = 1'b1 ; 
												in6F = 1'b0 ; 
												in7F = 1'b1 ; 
												in8F = 1'b0 ;
												fEnable = 1'b1 ; 
												fEnable = 1'b0 ;	
						    end
										
										 else
											 begin 
											 // check left 
											 maxLeft= 0 ;
											  
											 if (sY+6 <38)
											 temp1 = sY+6;
											 else 
											 temp1 = 38;
											 
											 j1 = sY+4 ; 
											 i1 = sX-1 ; 
										  
											 
											 maxRight= 0 ;
											 
											 if (sY+6 <38)
											 temp2 = sY+6;
											 else 
											 temp2 = 38;
												// *
											 j2 = sY+4 ; 
											 i2 = sX+1 ; 
															
											end
									  
									 
                          end
                          
                          
                          //--------------------------------------------- 
                          // now if spref is in the -ve Y direction ... 
								else if (spref==2'b11) 
								 begin 
						    // distance x finished ;) 
						    if ((pori== 2'b11) && (fir == 1'b0)) 
						    begin 
												 
												in1F = 1'b1 ; 
												in2F = 1'b0 ;
												in3F = 1'b1 ; 
												in4F = 1'b0 ; 
												in5F = 1'b1 ; 
												in6F = 1'b0 ; 
												in7F = 1'b1 ; 
												in8F = 1'b0 ;
												fEnable = 1'b1 ; 
												fEnable = 1'b0 ;
						    end
						     else 
						     begin 
						     // check left 
						     
						     maxLeft= 0 ;
						     if (sY-6 >0)
						     temp3 = sY-6;
						     else 
						     temp3 = 0; 
						     
						     j3 = sY-4 ; 
						     i3 = sX-1 ; 
						    
							 maxRight= 0 ;
						      
						     if (sY-6 >0 )
						     temp4 = sY-6;
						     else 
						     temp4 = 0; 
						     
						     j4 = sY-4 ; 
						     i4 = sX+1 ; 
						  
						     end
									  
									 
                          
                          
								  end
											
	 							
			   
			    
							// keep going 
				end								
											 	
              else if ( (pori != fpref) && (pori != spref) ) 
              // considering case going against your pref  
			  begin
			 
			  // you are here .. 
			  //  Start Yasmin  , when moving against my two pref .. 
				   
					if (spref == 2'b01 ) 
					begin 
				  // check left sensor 
				  if (~lir) 
						  goLeft= 1'b1 ;
						   
				  
					end 
					
					else if (spref == 2'b10 ) 
					begin 
				// check right sensor 
				
			     if (~rir) 
			      
			     goRight = 1'b1 ; 
			     
 
				 
					end 
			  
					  
			  
			  end 
												 
												else begin 
												// keep going .... 
												
											
												
												in1F = 1'b1 ; 
												in2F = 1'b0 ;
												in3F = 1'b1 ; 
												in4F = 1'b0 ; 
												in5F = 1'b1 ; 
												in6F = 1'b0 ; 
												in7F = 1'b1 ; 
												in8F = 1'b0 ;
												fEnable = 1'b1 ; 
												fEnable = 1'b0 ;												
													end  

  end

end
end

always @(fir) 
begin
lled = fir ; 
end 

//-----------------------------------------------------------------------------
always @ (sX or sY) 
begin 
if (enableMD) 
	begin
	if (sX < dX)
	//left of the object 	 
	spref = 2'b01 ; //set spref east 
	else 
	//right of the obj
	spref = 2'b10 ; //set spref west
	
	if (sY < dY ) 
	//below obj
	fpref = 2'b00 ; // fpref is north 
	else 
	//above obj
	fpref = 2'b11 ; //fpref is south  

	if ((sY < dY + 1 )&&( sY > dY - 1 ) )	
	fpref = spref ; 
	else if ((sX < dX + 1 )&& (sX > dX -1 )) 
	spref = fpref ; 
	end 
end 


always @(clk or i or j ) 
begin 
        
		if (j < 40 ) 
		begin 
			if (i<40) 
			begin 
			 if (j < 4 && i < 26)
			  mapx [i][j]<=1'b1; 
					  else if ( 7 < i && i < 20 && j >9 &&  j < 16 ) 
						   mapx [i][j]<=1'b1 ; 
							else if (j > 19 && i > 31) 
								 mapx [i][j]<=1'b1 ;   
								 else if (i>13 && i < 22 && j > 19 && j < 34 ) 
									mapx [i][j]<=1'b1 ; 
									else if (j>33 && i>7 && i <22 )  
										mapx[i][j]<=1'b1 ; 
										else 
										mapx[i][j]<=1'b0; 
			
										i = i+1 ; 
			
			end 
				else 
				begin
				i = 0 ; 
				j = j+1 ; 
				end 
		end
			else 
			begin 
			initiateMap = 1'b1 ; 
			enableMD = 1'b1  ;
			end 
end  


always @ (posedge goLeft,posedge goLeft1 , posedge goLeft2) 
begin 
// go left                 
						
						begin 
						 
						  in1L = 1'b1 ; 
						  in2L = 1'b0 ; 
						  in3L = 1'b1 ; 
						  in4L = 1'b0 ; 
						  in5L = 1'b0 ; 
						  in6L = 1'b1 ; 
						  in7L = 1'b0 ; 
						  in8L = 1'b1 ;
						  lEnable = 1'b1 ; 
						  lEnable = 1'b0 ;
						  end 
						  
end  
	
	always@(posedge goRight, posedge goRight1 , posedge goRight2)
				begin 
				
				 
				// go right 
		
				
				in1R =1'b0 ; 
				in2R = 1'b1 ; 
				in3R = 1'b0 ; 
				in4R = 1'b1 ; 
				in5R = 1'b1 ; 
				in6R = 1'b0 ; 
				in7R = 1'b1 ; 
				in8R = 1'b0 ;
				rEnable = 1'b1 ; 
				rEnable = 1'b0 ;  
				end 
				
		always @(rEnable, lEnable , fEnable , bEnable)
		begin 
	if (bEnable) 
	begin 
	in1 = in1B ; 
	in2 = in2B ; 
	in3 = in3B ; 
	in4 = in4B ; 
	in5 = in5B ; 
	in6 = in6B ; 
	in7 = in7B ; 
	in8 = in8B ;
	end 
		else if (rEnable) 
			begin 
				case(pori)
				2'b00: cori = 2'b01 ; 
				2'b01: cori = 2'b11;
				2'b10: cori = 2'b10;
				2'b11: cori = 2'b00;
				endcase
				pori = cori ;
				in1 = in1R ; 
				in2 = in2R ; 
				in3 = in3R ; 
				in4 = in4R ; 
				in5 = in5R ; 
				in6 = in6R ; 
				in7 = in7R ; 
				in8 = in8R ; 
				turning = 1'b1 ; 
				left = 1'b0 ; 
				right = 1'b1 ;
				
			end
			else if (lEnable)
			begin
			
							case(pori)
							2'b00: cori = 2'b10; 
							2'b01: cori = 2'b00;
							2'b10: cori = 2'b11;
							2'b11: cori = 2'b01; 
						  endcase 
						  pori = cori ;
					    in1 = in1L ; 
						in2 = in2L ; 
						in3 = in3L ; 
						in4 = in4L ; 
						in5 = in5L ; 
						in6 = in6L ; 
						in7 = in7L ; 
						in8 = in8L ;
						turning = 1'b1 ; 
						left = 1'b1 ; 
						right = 1'b0 ; 
						 
			end 
			else if (fEnable) 
			begin 
						in1 = in1F ; 
						in2 = in2F ; 
						in3 = in3F ; 
						in4 = in4F ; 
						in5 = in5F ; 
						in6 = in6F ; 
						in7 = in7F ; 
						in8 = in8F ;
						turning = 1'b0 ; 
						left = 1'b0 ; 
						right = 1'b0 ; 
						 
		    end 
		      	
	end 		 	 
  			
endmodule  
