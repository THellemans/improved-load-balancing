function [k_indxs, l_indxs, r, greater, greater_or_eq, xi] = sorted_kl_indxs(SCV, f, k_PH, type,Delta,RepMax,Bsize,threshold)
% type = 1 : SQ(d)-RTB
% type = 2 : SQ(d)-RE(T)
% type = 3 : SQ(d)-RTB-RE(T)
% type = 4 : LAS(d)
% type = 5 : LAS(d)-QTB
% type = 6 : JIQ(d)-RE(T)
% type = 7 : LEW(d)
% type = 8 : SQ(d)

% We sort k_indxs & l_indxs such that for all i we have
% xi(k_indxs(i), l_indxs(i)) <= xi(k_indxs(i), l_indxs(i))
% moreover, we associate to each index i, two additional indexes,
% greater_or_eq(i) : this is the smallest index j for which 
% xi(k_indxs(j),l_indxs(j)) = xi(k_indxs(i), l_indxs(i))
% greater(i) : this is the smallest index j for which
% xi(k_indxs(j),l_indxs(j)) > xi(k_indxs(i), l_indxs(i))


EX=1;
[alpha, A, ~, ~] = hyper_erlang_init(EX, SCV, f, k_PH);

r=ceil(RepMax/Delta);
k_indxs=zeros(1, Bsize*(r+1));
l_indxs=zeros(size(k_indxs));
b=zeros(size(k_indxs));
k=0; l=1;
for i=1:Bsize*(r+1)
    b(i)=Delta*k;
    k=k+1;
    k_indxs(i)=k;
    l_indxs(i)=l;
    if (k == r+1)
        k=0;
        l=l+1;
    end
end


if type==1
    xi=k_indxs + l_indxs * (r+1);
elseif type==2
    xi=l_indxs+(Bsize+1)*(b >= threshold);
elseif type == 3
    xi=(r+2)*l_indxs+k_indxs+(Bsize+1)*(r+2)*(b>=threshold);
elseif type==4
    xi=k_indxs;
elseif type==5
    xi=k_indxs*(Bsize+1) + l_indxs;
elseif type == 6
    xi=(b >= threshold) + (l_indxs >= 1);
elseif type == 7
    A_inv=A^(-1);
    xi=zeros(size(k_indxs));
    for i=1:length(k_indxs)
       xi(i)=E_cond(alpha, A, A_inv, b(k_indxs(i))) - b(k_indxs(i)) + (l_indxs(i)-1);
    end
else
    xi = l_indxs;
end

[~, sort_indxs]=sort(xi);
k_indxs=k_indxs(sort_indxs);
l_indxs=l_indxs(sort_indxs);
xi=xi(sort_indxs);

greater_or_eq=zeros(size(k_indxs));
greater_or_eq(1)=1;
greater=zeros(size(k_indxs));

for i=1:length(k_indxs)
    for j=max(i+1, greater(max(i-1,1))):length(k_indxs)
        if (xi(j) > xi(i)) || (j == length(k_indxs))
            greater(i)=j;
            break;
        end
    end
    
    for j=(i-1):-1:0
        if (j == 0) || (xi(j) < xi(i))
            greater_or_eq(i)=min(j+1, length(k_indxs));
            break
        end
    end
end
greater(end)=length(k_indxs);

end