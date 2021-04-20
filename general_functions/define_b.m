function [b, r] = define_b(Delta, RepMax)
%

r=ceil(RepMax/Delta);
b=zeros(r+1, 1);
for i=1:r
    b(i+1)=Delta*i;
end

end

