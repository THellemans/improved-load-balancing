function [output] = E_cond_data(data, w)
%

output = mean(data(data >= w));

end