//-------------------------------------------------------------------------
//    Ball.sv                                                            --
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


module  ball ( input Reset, frame_clk, 
					input [7:0]key_in,
               output [9:0]  BallX, BallY, BallS );
    
    logic [9:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion, Ball_Size;
	 
    parameter [9:0] Ball_X_Center=320;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center=240;  // Center position on the Y axis
    parameter [9:0] Ball_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max=479;     // Bottommost point on the Y axis
    parameter [9:0] Ball_X_Step=1;      // Step size on the X axis
    parameter [9:0] Ball_Y_Step=1;      // Step size on the Y axis

    assign Ball_Size = 4;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
/*   
	 always_comb
	 begin 
		if (key_in == 8'b00011010) //up
			Ball_Y_Motion <= Ball_Y_Step;
		else if (key_in == 8'b00010110) //down
			Ball_Y_Motion <= (~ (Ball_Y_Step) + 1'b1);
		else if (key_in == 8'b00000100)//left
			Ball_X_Motion <= Ball_X_Step;
		else if (key_in == 8'b00000111)//right
			Ball_X_Motion <= (~ (Ball_X_Step) + 1'b1);

		
		default:
			begin
				Ball_X_Motion <= Ball_X_Motion;
				Ball_Y_Motion <= Ball_Y_Motion;
			end
		endcase
	 end
*/	 
	
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Ball
        if (Reset)  // Asynchronous Reset
        begin 
            Ball_Y_Motion <= 10'd0; //Ball_Y_Step;
				Ball_X_Motion <= 10'd0; //Ball_X_Step;
				Ball_Y_Pos <= Ball_Y_Center;
				Ball_X_Pos <= Ball_X_Center;
        end
           
        else if(1)
			begin
			if (key_in == 8'b00011010) //up
				begin
				Ball_Y_Motion <= (~ (Ball_Y_Step) + 1'b1);
				Ball_X_Motion <= 1'b0;
				end
			else if (key_in == 8'b00010110) //down
				begin
				Ball_Y_Motion <= Ball_Y_Step;
				Ball_X_Motion <= 1'b0;
				end
			else if (key_in == 8'b00000100)//left
				begin 
				Ball_X_Motion <= (~ (Ball_X_Step) + 1'b1);
				Ball_Y_Motion <= 1'b0;
				end
			else if (key_in == 8'b00000111)//right
			   begin
				Ball_X_Motion <= Ball_X_Step;
				Ball_Y_Motion <= 1'b0;
				end
			
			else if (1)
			begin
////////////////////////////////////Y bounce/////////////////////////////////////
				if( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
					Ball_Y_Motion <= (~ (Ball_Y_Step) + 1'b1);  // 2's complement.
					
				else if ( (Ball_Y_Pos - Ball_Size) <= Ball_Y_Min )  // Ball is at the top edge, BOUNCE!
					Ball_Y_Motion <= Ball_Y_Step;
					
				else
					Ball_Y_Motion <= Ball_Y_Motion;
/////////////////////////////////////////////////////X bounce/////////////////////////////					
				if ( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )  // Ball is at the right edge, BOUNCE!
					Ball_X_Motion <= (~ (Ball_X_Step) + 1'b1);  // 2's complement.
					  
				else if ( (Ball_X_Pos - Ball_Size) <= Ball_X_Min )  // Ball is at the left edge, BOUNCE!
					Ball_X_Motion <= Ball_X_Step;
					
				else
					Ball_X_Motion <= Ball_X_Motion;	 
				 
				/* begin
					  Ball_Y_Motion <= Ball_Y_Motion;  // Ball is somewhere in the middle, don't bounce, just keep moving					  				 
					  Ball_X_Motion <= Ball_X_Motion;  // You need to remove this and make both X and Y respond to keyboard input
				 end */
///////////////////////////////////// Update ball position//////////////////////////////////
				 if(1)
				 begin
					Ball_Y_Pos <= (Ball_Y_Pos + Ball_Y_Motion);  
					Ball_X_Pos <= (Ball_X_Pos + Ball_X_Motion);
				 end
				 
				end
			end
		end
 
/*
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Ball
        if (Reset)  // Asynchronous Reset
        begin 
            Ball_Y_Motion <= 10'd0; //Ball_Y_Step;
				Ball_X_Motion <= 10'd1; //Ball_X_Step;
				Ball_Y_Pos <= Ball_Y_Center;
				Ball_X_Pos <= Ball_X_Center;
        end
           
        else 
        begin 					
		      if (key_in == 8'b00011010)//UP
					Ball_Y_Pos <= (Ball_Y_Pos + 10); 
				
				/*
					begin
						Ball_X_Motion <= 10'd0;
						Ball_Y_Motion <=10'd1;
				
					if ( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
						Ball_Y_Motion <= (~ (Ball_Y_Step) + 1'b1);  // 2's complement.					  
					else if ( (Ball_Y_Pos - Ball_Size) <= Ball_Y_Min )  // Ball is at the top edge, BOUNCE!
						Ball_Y_Motion <= Ball_Y_Step;					  
					else 
						Ball_Y_Motion <= Ball_Y_Motion;  // Ball is somewhere in the middle, don't bounce, just keep moving
					end
					
				 else if (key_in == 8'b00010110)//DOWN
					begin
						Ball_X_Motion <= 10'd0;
						Ball_Y_Motion <= 10'b1111111111;
				
					if ( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
						Ball_Y_Motion <= (~ (Ball_Y_Step) + 1'b1);  // 2's complement.					  
					else if ( (Ball_Y_Pos - Ball_Size) <= Ball_Y_Min )  // Ball is at the top edge, BOUNCE!
						Ball_Y_Motion <= Ball_Y_Step;					  
					else 
						Ball_Y_Motion <= Ball_Y_Motion;  // Ball is somewhere in the middle, don't bounce, just keep moving
					end
				
				 else if (key_in == 8'b00000100)//LEFT
					begin
						Ball_X_Motion <= 10'b1111111111;
						Ball_Y_Motion <= 10'd0;	
						
						if ( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )  // Ball is at the right edge, BOUNCE!
							Ball_X_Motion <= (~ (Ball_X_Step) + 1'b1);  // 2's complement.					  
						else if ( (Ball_X_Pos - Ball_Size) <= Ball_X_Min )  // Ball is at the left edge, BOUNCE!
							Ball_X_Motion <= Ball_X_Step;					  
						else 
							Ball_X_Motion <= Ball_X_Motion;  // Ball is somewhere in the middle, don't bounce, just keep moving
	             end	
					 
				 else if (key_in == 8'b00000111)//RIGHT
					begin
						Ball_X_Motion <= 10'd1;
						Ball_Y_Motion <= 10'd0;	
						
						if ( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )  // Ball is at the right edge, BOUNCE!
							Ball_X_Motion <= (~ (Ball_X_Step) + 1'b1);  // 2's complement.					  
						else if ( (Ball_X_Pos - Ball_Size) <= Ball_X_Min )  // Ball is at the left edge, BOUNCE!
							Ball_X_Motion <= Ball_X_Step;					  
						else 
							Ball_X_Motion <= Ball_X_Motion;  // Ball is somewhere in the middle, don't bounce, just keep moving
				   end
				 else //OTHER
						if ( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
							Ball_Y_Motion <= (~ (Ball_Y_Step) + 1'b1);  // 2's complement.
					
						else if ( (Ball_Y_Pos - Ball_Size) <= Ball_Y_Min )  // Ball is at the top edge, BOUNCE!
							Ball_Y_Motion <= Ball_Y_Step;
					
						else
							Ball_Y_Motion <= Ball_Y_Motion;
					
						if ( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )  // Ball is at the right edge, BOUNCE!
							Ball_X_Motion <= (~ (Ball_X_Step) + 1'b1);  // 2's complement.
					  
						else if ( (Ball_X_Pos - Ball_Size) <= Ball_X_Min )  // Ball is at the left edge, BOUNCE!
								Ball_X_Motion <= Ball_X_Step;
					
						else
							Ball_X_Motion <= Ball_X_Motion;	 
				 
						begin
							Ball_Y_Motion <= Ball_Y_Motion;  // Ball is somewhere in the middle, don't bounce, just keep moving					  				 
							Ball_X_Motion <= Ball_X_Motion;  // You need to remove this and make both X and Y respond to keyboard input
						end 				  
			
				// Ball_X_Motion <= Ball_X_Motion;  // You need to remove this and make both X and Y respond to keyboard input
				 
				 Ball_Y_Pos <= (Ball_Y_Pos + Ball_Y_Motion);  // Update ball position
				 Ball_X_Pos <= (Ball_X_Pos + Ball_X_Motion);
			
				*/
	  /**************************************************************************************
	    ATTENTION! Please answer the following quesiton in your lab report! Points will be allocated for the answers!
		 Hidden Question #2/2:
          Note that Ball_Y_Motion in the above statement may have been changed at the same clock edge
          that is causing the assignment of Ball_Y_pos.  Will the new value of Ball_Y_Motion be used,
          or the old?  How will this impact behavior of the ball during a bounce, and how might that 
          interact with a response to a keypress?  Can you fix it?  Give an answer in your Post-Lab.
      **************************************************************************************/
      
			

       
    assign BallX = Ball_X_Pos;
   
    assign BallY = Ball_Y_Pos;
   
    assign BallS = Ball_Size;
    

endmodule
