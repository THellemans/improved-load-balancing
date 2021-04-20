function [convoluted] = convolution(f,g,delta)
%This function assumes len(f)=len(g) and computes int_0^s f(u) g(s-u) du
%for s = 0,delta,...,delta*(len(f)-1)
M=length(f);
f(2*M-1)=0;
g(2*M-1)=0;
convoluted=delta*ifft(fft(f).*fft(g));
convoluted=[0,convoluted(2:M)];


end