function [output] = E_cond(alpha, A, A_inv, w)
%

if length(w)==1
    output=w+(alpha*(-A_inv)*(expm(A*w))*ones(length(alpha),1))/(alpha*expm(A*w)*ones(length(alpha),1));
else
    output=zeros(size(w));
    for j = 1:length(w)
        ww=w(j);
        output(j)=ww+(alpha*(-A_inv)*(expm(A*ww))*ones(length(alpha),1))/(alpha*expm(A*ww)*ones(length(alpha),1));
    end
end

end