function [base] = GroupLatticeBase(s,n)
% s is dimension of lattice
% n is number of points
% base is generating vector




g = generatorp(n);
kg = (n-1)/(2*s);
m = powmod(g,kg,n);

base = ones(1,s);
for jj=2:s
    base(jj)=powmod(m,(jj-1),n);   
end
 

