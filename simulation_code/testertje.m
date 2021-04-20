addpath('../general_functions')
d=2; N=10; lam=0.5; EX=1; SCV=10; f=1/2; k_PH=2; nruns=2; runlen=10^7/N; type=3; Delta=0.1; RepMax=20; Bsize=1000; threshold=2;

[qls_dist,mresp,mwait]=simulSQd_HErlang_mex(d,N,lam,EX,SCV,f,k_PH,nruns,runlen,type,Delta,RepMax,Bsize,threshold);
mwait
%[qls_dist,mresp,mwait]=simulSQd_HEXP(d,N,lam,EX,SCV,f,nruns,runlen,type,Delta,RepMax,Bsize,threshold);
%mwait