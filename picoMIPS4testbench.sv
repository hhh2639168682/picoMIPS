module picoMIPS4test_tb;

	logic fastclk;
	logic [9:0]SW;
	logic [7:0]LED;
	
	shortreal Ra,Ia,Rb,Ib,Rw,Iw;
	int Ry,Iy,Rz,Iz;
	picoMIPS4test picoMIPS4test_1(
				.fastclk(fastclk), 
				.SW(SW),
				.LED(LED)); 
				
  initial 
     begin
			fastclk =  0;
			#5ns  forever #5ns fastclk = ~fastclk;
	  end
	  
	initial 
		begin
			SW    =  '0 ; 
			//LED =  '0 ;
		   SW[9] = 1'b1;
			repeat(10)@(posedge fastclk);
			#1;
			SW[9] = 1'b0;
			repeat(20)@(posedge fastclk);
			SW[8] = 1'b1;						// pull down the switch 

			SW[7:0] =8'b0100_0000; //prepare the Re_w 
			
			repeat(5)@(posedge fastclk);
			SW[8] = 1'b0;                 // pull up the switch 
			
			//repeat(20)@(posedge fastclk);
			//SW[8] = 1'b1;						// pull down the switch 
			
			repeat(5)@(posedge fastclk);
			SW[7:0] =8'b1100_0000;		//prepare the Im_w  

			repeat(20)@(posedge fastclk);
			SW[8] = 1'b0;                 // pull up the switch 
			
			repeat(20)@(posedge fastclk);
			SW[8] = 1'b1;						// pull down the switch 

			repeat(5)@(posedge fastclk);
			SW[7:0] =8'b0000_1010;		//prepare the Re_b 

			repeat(5)@(posedge fastclk);
			SW[8] = 1'b0;                 // pull up the switch 
			
			repeat(20)@(posedge fastclk);
			SW[8] = 1'b1;						// pull down the switch

			repeat(5)@(posedge fastclk);
			SW[7:0] =8'b0000_0100;		//prepare the Im_b

			repeat(5)@(posedge fastclk);
			SW[8] = 1'b0;                 // pull up the switch 
			
			repeat(20)@(posedge fastclk);
			SW[8] = 1'b1;						// pull down the switch

			repeat(5)@(posedge fastclk);
			SW[7:0] =8'b0000_0001;		//prepare the Re_a	

			repeat(5)@(posedge fastclk);
			SW[8] = 1'b0;                 // pull up the switch 
			
			repeat(20)@(posedge fastclk);
			SW[8] = 1'b1;						// pull down the switch

			repeat(5)@(posedge fastclk);
			SW[7:0] =8'b0000_1000;		//prepare the Im_a	

			repeat(5)@(posedge fastclk);
			SW[8] = 1'b0;                 // pull up the switch 
			
			repeat(20)@(posedge fastclk);
			SW[8] = 1'b1;						// pull down the switch
		
			repeat(5)@(posedge fastclk);
			SW[8] = 1'b0;                 // pull up the switch 
			
			repeat(20)@(posedge fastclk);
			SW[8] = 1'b1;						// pull down the switch

			repeat(5)@(posedge fastclk);
			SW[8] = 1'b0;                 // pull up the switch 
			
			repeat(20)@(posedge fastclk);
			SW[8] = 1'b1;						// pull down the switch
		
			repeat(5)@(posedge fastclk);
			SW[8] = 1'b0;                 // pull up the switch 
			
			repeat(20)@(posedge fastclk);
			SW[8] = 1'b1;						// pull down the switch
			
			repeat(20)@(posedge fastclk);
			SW[8] = 1'b1;						// pull down the switch
		
			repeat(5)@(posedge fastclk);
			SW[8] = 1'b0;                 // pull up the switch 
			
			repeat(20)@(posedge fastclk);
			SW[8] = 1'b1;						// pull down the switch

			repeat(5)@(posedge fastclk);
			SW[8] = 1'b0;                 // pull up the switch 
			
			repeat(20)@(posedge fastclk);
			SW[8] = 1'b1;						// pull down the switch
		
			repeat(5)@(posedge fastclk);
			SW[8] = 1'b0;                 // pull up the switch 
			
			repeat(20)@(posedge fastclk);
			SW[8] = 1'b1;						// pull down the switch
			
			/*
			SW[7:0] =8'd5; //prepare the first number 
			repeat(5)@(posedge fastclk);
			SW[8] = 1'b1; 						//come back to the instuction zero
			
			
			repeat(5)@(posedge fastclk);
			SW[8] = 1'b0;	
			
			
			@(posedge fastclk);
			SW[7:0] =8'd5;	
			
			repeat(5)@(posedge fastclk);
			SW[8] = 1'b1;	
			
					    repeat(5)@(posedge fastclk);
			SW[8] = 1'b0; 
			
						repeat(10)@(posedge fastclk);
			SW[8] = 1'b1; 
			
						repeat(5)@(posedge fastclk);
			SW[8] = 1'b0; */
			
			
			
			repeat(20)@(posedge fastclk);
			$stop;
			
			
		end
int MUX1,MUX2,MUX3,MUX4;
		
	initial 
		begin
			Ra = 1 ;
			Ia = 1 ;
			Rb = 1 ;
			Ib = 1 ;
			Rw = -0.5 ;
			Iw = -0.5 ;
			
			MUX1=Ib*Iw;
			MUX2=Rb*Rw;
			MUX3=Rb*Iw;
			MUX4=Rw*Ib;
			$display("Ry = %d \n",MUX1);
			$display("Ry = %d \n",MUX2);
			$display("Ry = %d \n",MUX3);
			$display("Ry = %d \n",MUX4);
			
			Ry = Ra - MUX1 + MUX2;
			Iy = Ia + MUX3 + MUX4;
			
			Rz = Ra + Ib*Iw - Rb*Rw;
			Iz = Ia - (Rb*Iw + Rw*Ib);
			$display("Ry = %f \n",Ry);
			$display("Iy = %f \n",Iy);
			$display("Rz = %f \n",Rz);
			$display("Iz = %f \n",Iz);
		end	
			

endmodule 