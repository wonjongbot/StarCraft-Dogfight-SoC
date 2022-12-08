//-------------------------------------------------------------------------
//    tank.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 298 Lab 7                                         --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------


module  tank ( input Reset, frame_clk,
					input forward, backward,
					input [9:0] motionx, motiony, start_x, start_y,
               output [9:0]  BallX, BallY, BallS );
    
    logic [9:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion, Ball_Size;
	 
    parameter [9:0] Ball_X_Center=320;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center=240;  // Center position on the Y axis
    parameter [9:0] Ball_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max=479;     // Bottommost point on the Y axis
    parameter [9:0] Ball_X_Step=3;      // Step size on the X axis
    parameter [9:0] Ball_Y_Step=3;      // Step size on the Y axis

    assign Ball_Size = 16;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
	 
	 logic clkdiv;
	//This cuts the 60hz clock in half to generate a 30hz clock  
    always_ff @ (posedge frame_clk or posedge Reset )
    begin 
        if (Reset) 
            clkdiv <= 1'b0;
        else 
            clkdiv <= ~ (clkdiv);
    end
   
    always_ff @ (posedge Reset or posedge clkdiv )
    begin: Move_Ball
        if (Reset)  // Asynchronous Reset
        begin 
            Ball_Y_Motion <= 10'd0; //Ball_Y_Step;
				Ball_X_Motion <= 10'd0; //Ball_X_Step;
				Ball_Y_Pos <= start_y;
				Ball_X_Pos <= start_x;
        end
           
        else 
        begin 
				 if ( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max )begin  // Ball is at the bottom edge, BOUNCE!
					  Ball_Y_Motion <= (~ (Ball_Y_Step) + 1'b1);  // 2's complement.
					  Ball_X_Motion <= 0 ;
					  end
					  
				 else if ( (Ball_Y_Pos - Ball_Size) <= Ball_Y_Min )begin  // Ball is at the top edge, BOUNCE!
					  Ball_Y_Motion <= Ball_Y_Step;
					  Ball_X_Motion <= 0 ;
					  end
					  
				  else if ( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )begin  // Ball is at the Right edge, BOUNCE!
					  Ball_X_Motion <= (~ (Ball_X_Step) + 1'b1);  // 2's complement.
					  Ball_Y_Motion <= 0 ;
					  end
					  
				 else if ( (Ball_X_Pos - Ball_Size) <= Ball_X_Min )begin  // Ball is at the Left edge, BOUNCE!
					  Ball_X_Motion <= Ball_X_Step;
					  Ball_Y_Motion <= 0 ;
					  end
					  
				 else 
					  Ball_Y_Motion <= Ball_Y_Motion;  // Ball is somewhere in the middle, don't bounce, just keep moving
					  
				 
					if(backward)
						begin
//////////////
				 if ( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max )begin  // Ball is at the bottom edge, BOUNCE!
					  Ball_Y_Motion <= (~ (Ball_Y_Step) + 1'b1);  // 2's complement.
					  Ball_X_Motion <= 0 ;
					  end
					  
				 else if ( (Ball_Y_Pos - Ball_Size) <= Ball_Y_Min )begin  // Ball is at the top edge, BOUNCE!
					  Ball_Y_Motion <= Ball_Y_Step;
					  Ball_X_Motion <= 0 ;
					  end
					  
				  else if ( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )begin  // Ball is at the Right edge, BOUNCE!
					  Ball_X_Motion <= (~ (Ball_X_Step) + 1'b1);  // 2's complement.
					  Ball_Y_Motion <= 0 ;
					  end
					  
				 else if ( (Ball_X_Pos - Ball_Size) <= Ball_X_Min )begin  // Ball is at the Left edge, BOUNCE!
					  Ball_X_Motion <= Ball_X_Step;
					  Ball_Y_Motion <= 0 ;
					  end
//////////////
					else begin
							Ball_Y_Motion <= (~motiony)+1;//S
							Ball_X_Motion <= (~motionx)+1;
							end
						end
					else if(forward)
						begin
							Ball_Y_Motion <= motiony;//W
							Ball_X_Motion <= motionx;
						end	  
					else
					begin
							Ball_Y_Motion <= 0;
							Ball_X_Motion <= 0;
					end
				 
				 Ball_Y_Pos <= (Ball_Y_Pos + Ball_Y_Motion);  // Update ball position
				 Ball_X_Pos <= (Ball_X_Pos + Ball_X_Motion);
			
			
	  /**************************************************************************************
	    ATTENTION! Please answer the following quesiton in your lab report! Points will be allocated for the answers!
		 Hidden Question #2/2:
          Note that Ball_Y_Motion in the above statement may have been changed at the same clock edge
          that is causing the assignment of Ball_Y_pos.  Will the new value of Ball_Y_Motion be used,
          or the old?  How will this impact behavior of the ball during a bounce, and how might that 
          interact with a response to a keypress?  Can you fix it?  Give an answer in your Post-Lab.
      **************************************************************************************/
      
			
		end  
    end
       
    assign BallX = Ball_X_Pos;
   
    assign BallY = Ball_Y_Pos;
   
    assign BallS = Ball_Size;
    

endmodule
