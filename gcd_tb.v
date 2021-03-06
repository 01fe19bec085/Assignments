module gcd_tb;
reg[15:0]data_in;
reg clk,start;
wire done;
reg [15:0] A,B;
gcd_GCD DP(ge,lt,eq,ldA,ldB,sel1,sel2,sel_in,data_in,clk);
controller CON(ldA,ldB,sel1,sel2,sel_in,done,clk,lt,gt,eq,start);
initial begin
clk=1'b0;
#3 start =1'b1;
#1000 $finish;
end
always #5 clk=~clk;
initial begin
#12 data_in=143;
#10 data_in=78;
end
initial begin
$monitor($time,"%d %b",DP.Aout,done);
$dumpfile("gcd.vcd");
$dumpvars(0,gcd_tb);
end
endmodule

module GCD(gt,lt,eq,ldA,ldB,sel1,sel2,sel_in,data_in,clk);
input ldA,ldB,sel1,sel2,sel_in,clk;
input [15:0] data_in;
output gt,lt,eq;
wire[15:0] Aout,Bout,X,Y,Bus,SubOut;
PIPO A (Aout,Bus,ldA,clk);
PIPO B (Bout,Bus,ldB,clk);
MUX MUX_in1 (X,Aout,Bout,sel1);
MUX MUX_in2 (Y,Aout,Bout,sel2);
MUX MUX_load (Bus,Subout,data_in,sel_in);
SUB SB(Subout,X,Y);
COMPARE COMP(lt,gt,eq,Aout,Bout);
endmodule

module PIPO (data_out,data_in,load,clk);
input[15:0] data_in;
input load,clk;
output reg [15:0] data_out;
always @(posedge clk)
 if (load) data_out<=data_in;
endmodule

module SUB(out,in1,in2);
input[15:0] in1,in2;
output reg[15:0] out;
always @(*)
 out=in1-in2;
endmodule

module COMPARE(lt,gt,eq,data1,data2);
input[15:0] data1,data2;
output lt,gt,eq ;
assign lt=data1<data2;
assign gt=data1>data2;
assign eq=data1==data2;
endmodule

module MUX(out,in0,in1,sel);
input[15:0] in0,in1;
input sel;
output [15:0] out;
assign out=sel ? in1:in0;
endmodule

