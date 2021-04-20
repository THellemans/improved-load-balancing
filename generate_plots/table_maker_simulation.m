clear variables
N_iter=[10 50 100 500 1000 2000];

EW_table=zeros(7,length(N_iter)+1);
EW_table(1,1:(end-1))=N_iter;

for n=1:7
    load(strcat("../data/simulation",int2str(n),".mat"))
    EW_table(n+1,:)=EW;
end

EW_table

