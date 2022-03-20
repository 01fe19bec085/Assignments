module MUL_datapath(eqz,lda,ldp,ldb,clr_p,dec_b,data_in,clk);
input lda,ldb,clr_p,dec_b,clk;
input [15:0] data_in;
output eqz;
wire [15:0] X,Y,Z,Bout,bus;
PIPO1 A(X,bus,lda,clk);
PIPO2 B(Y,Z,ldp,clr_p,clk);
CNTR B(Bout,bus,ldb,dec_b,clk);
ADD AD(X,Y,Z);
eqz comp(eqz,Bout);
end module

