function [r, xi_vals] = initiate_policy(b, Bsize, alpha, S, type, threshold)
% type = 1 : Tie Breaking based on Runtime
% type = 2 : Classic SQ(d) with threshold
% type = 3 : Tie Breaking with threshold
% type = 4 : Only balance on time in service, tie breaking using number of jobs
% type = 5 : Expected Workload

r=length(b)-1;
xi_vals=zeros(r+1, Bsize);

if type==1
    for k=1:r+1
        for l = 1:Bsize
            xi_vals(k,l)=k+l*(r+1);
        end
    end
elseif type==2
    for k=1:r+1
        for l = 1:Bsize
            xi_vals(k,l)=l+(Bsize+1)*(b(k) >= threshold);
        end
    end
elseif type==3
    for k=1:r+1
        for l=1:Bsize
            xi_vals(k,l)=  k + l*(r+1) + (b(k) >= threshold) * Bsize * (r+1);
        end
    end
elseif type == 4
    for k=1:r+1
        for l=1:Bsize
               xi_vals(k,l)= k * (Bsize+1) + l;      
        end
    end
else
    S_inv=S^(-1);
    for k=1:r+1
        for l=1:Bsize
            xi_vals(k,l)=E_cond(alpha, S, S_inv, b(k)) - b(k) + (l-1);
        end
    end
end

end