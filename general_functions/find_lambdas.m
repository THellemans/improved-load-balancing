function [lambdas, x, u, v, w] = find_lambdas(B, r, lam, d, probs, k_indxs, l_indxs, greater, greater_or_eq)
% type == 'tie_breaking' or type == 'expected_workload'

x=zeros(size(k_indxs));
u=zeros(size(x));
v=zeros(size(x));

for i =1:length(k_indxs)
    x(i)=probs(k_indxs(i), l_indxs(i));
end

u(end)=x(end);

prev_idx_u=length(k_indxs);
prev_idx_v=length(k_indxs)+1;
for i=length(k_indxs)-1:(-1):1
    
    u_idx=greater_or_eq(i);
    v_idx=greater(i);
    
    u(i)=u(i+1);
    if prev_idx_u ~= u_idx
        for j=u_idx:(prev_idx_u-1)
            u(i)=u(i)+x(j);
        end
        prev_idx_u=u_idx;
    end
    
    v(i)=v(i+1);
    if prev_idx_v ~= v_idx
        for j=v_idx:(prev_idx_v-1)
            v(i)=v(i)+x(j);
        end
        prev_idx_v=v_idx;
    end
end

w=u-v;

%lambdas=zeros(r+1,B);
Jdist=zeros(r+1,B);
for i=1:(length(k_indxs))
    k=k_indxs(i); l=l_indxs(i);
    for j=0:(d-1)
        Jdist(k, l)=Jdist(k,l)+1/(j+1)*nchoosek(d-1, j) * w(i)^(j) * v(i)^(d-1-j);
    end
    
end
lambdas=Jdist*lam*d;
lambdas(:, B)=0;

end