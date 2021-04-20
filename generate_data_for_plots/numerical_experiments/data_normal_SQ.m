function [EW] = data_normal_SQ(d, lambda,SCV,f,k_PH,Bsize, tol)
%

if length(lambda) > 1
    iter=lambda; choice=1;
elseif length(SCV) > 1
    iter=SCV; choice=2;
elseif length(f) > 1
    iter=f; choice=3;
elseif length(d) > 1
    iter=d; choice=4;
else
    choice=5;
end

if ~exist('jtype', 'var')
    jtype = 1;  %HExp(SCV, f) jobs
    q=1/2; EX1=1;  k_PH=1; % dummy values
end

EW=zeros(1, length(iter));

if choice == 5
    [~, ER] = SQ_PH(lam, d, qbound, SCV, f, k_PH, tol);
    EW(:)=ER-1;
else
    for i=1:length(iter)
        if choice == 1
            lambda=iter(i);
        elseif choice == 2
            SCV=iter(i);
        elseif choice==3
            f=iter(i);
        elseif choice == 4
            d=d_iter(i);
        end
        [~, ER] = SQ_PH(lambda, d, Bsize, SCV, f, k_PH, tol);
        EW(i)=ER-1;
    end
end

end

