addpath('../../general_functions')
clear variables
w_range=linspace(0,30,10^3);

%% MErlang(10, 1/2, k) job sizes for k=1,3,5,10, 15

SCV=10; f=1/2;
k_PHs=[1,3,5,10,15];
E_cond_w=zeros(length(k_PHs), length(w_range));

idxs=1:length(k_PHs);
for idx = idxs
    k_PH=k_PHs(idx);
    [alpha, A, ~, ~] = hyper_erlang_init(1, SCV, f, k_PH);
    mu=-A*ones(length(alpha), 1);
    A_inv=A^(-1); 
    [E_cond_w(idx,:)] = E_cond(alpha, A, A_inv, w_range) - w_range;
end
save('../../data/fig14c.mat', 'E_cond_w', 'w_range')