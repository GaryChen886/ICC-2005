`timescale 1ns/10ps
`define abs(a,b) ((a>b)? a-b : b-a )
module CS(Y, X, reset, clk);

    input clk, reset; 
    input [7:0]X;
    output reg [9:0] Y;
  //--------------------------------------
  //  \^o^/   Write your code here~  \^o^/
  //--------------------------------------
    integer i, j;
    reg [7:0] XS [9:1] ;   //8bits * 9
    reg [12:0] sum;
    reg [7:0] avg,appr;
    reg [3:0] cnt;
    
    always @(posedge clk or posedge reset)begin
        if(reset)begin
            for(i = 1;i <= 9;i = i+1)
                XS[i] <= 0;
            sum <= 0;
            avg <= 0;
            appr <= 0;
            i <= 0;
            cnt <= 0;
        end
        else begin
            for(i = 9;i > 2;i = i - 1)
                XS[i] <= XS[i-1];
            XS[1] <= X;
            sum <= sum - XS[11] + X;
        end
    end
    always @(*)begin
        avg = sum / 9;
        appr = XS[1];
        for(j = 2; j <= 9;j = j + 1)begin
            if( `abs(avg,XS[j])<`abs(avg,appr) )
                appr = XS[j];
        end
        Y = (sum + appr<<3 + appr)/8;
    end
endmodule
