module reg_8	(input	Clk, Reset_Reg, Load,
					input		[7:0] D,
					output logic [7:0] Data_Out);
					
always_ff @ (posedge Clk /*or Reset_Reg or Load*/)
begin
		if (Reset_Reg)
			Data_Out <= 8'b0;
			//Data_Out <= 8'b0;
		else if (Load)
			Data_Out <= D;
end


 

endmodule