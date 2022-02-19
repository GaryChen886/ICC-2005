`timescale 1ns/10ps
`define abs(a,b) ((a>b)? a-b : b-a )
module CS(Y, X, reset, clk);
	input clk, reset;
	input 	[7:0] X;
	output reg [9:0] Y;

	reg [7:0] XS [8:0];
	reg [13:0] sum;
	reg [7:0] avg; 
	reg [7:0] appr; 
	integer i,j;
//--------------------------------------
//  \^o^/   Write your code here~  \^o^/
//--------------------------------------
	always @(posedge clk or posedge reset) begin
		if(reset)begin
			for(i=0;i<9;i=i+1)
				XS[i] <= 0;
			sum <= 0;
			i <= 0;
		end
		else begin
			sum <= sum - XS[0] + X;
			for(i=0;i<8;i=i+1)
				XS[i] <= XS[i+1];
			XS[8] = X;
		end
	end
	always @(*) begin
		appr = 0;
		avg = sum/9;
		for(j=0;j<9;j=j+1)
			if(`abs(XS[j],avg) < `abs(appr,avg))
				appr = XS[j];
		Y = (sum + {appr,3'b0})>>3;
	end
endmodule
