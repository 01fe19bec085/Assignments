module pipe_tb;

parameter N=10;
wire [N-1:0] F;
reg [N-1:0] A,B,C,D;
reg clk;

pipe_ex mypipe (F,A,B,C,D,clk);
initial clk=0;
always #10 clk=~clk;

initial 
begin
#5 A=10; B=12; C=6; D=3;
#20 A=10; B=10; C=5; D=3;
#20 A=20; B=11; C=1; D=4;
#20 A=15; B=10; C=8; D=2;
end

initial
begin
$dumpfile ("pipe.vcd");
$dumpvars(0, pipe_tb);
$monitor ("Time:%d, F=%d",$time,F);
#300 $finish;
end
endmodule

module pipe_ex(F,A,B,C,D,clk);
parameter N=10;
input [N-1:0] A,B,C,D;
input clk;
output [N-1:0] F;
reg [N-1:0] L12_x1,L12_x2,L12_D,L23_x3,L23_D,L34_F;
assign F=L34_F;
always@(posedge clk)  //**Stage1**
begin
L12_x1 <= #4 A+B;
L12_x2 <= #4 C-D;
L12_D  <= D;
end
always@(posedge clk)  //**Stage2**
begin
L23_x3 <= #4 L12_x1 + L12_x2;
L23_D <= L12_D;
end
always@(posedge clk)  //**Stage3**
L34_F<= #6 L23_x3 * L23_D;
endmodule



