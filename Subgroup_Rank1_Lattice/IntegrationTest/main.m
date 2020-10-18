%% Integral Approximation Test


s = 100 ;  % dimension of test problem


Error=zeros(2,10);
STDerror=Error;
a= primes(6*10^8);
NN = zeros(1,10);



MT= 20;     % number of indepedent runs
 
b=2;c=1;
gexact = @(s, c, b) prod(expm1(c*(1:s).^(-b))./(c*(1:s).^(-b)));

Yt= gexact(s,c,b);   %  exact integral value


 
for jj=1:10
   jj
   m=a(find(mod(a-1,2*s)==0 &a>= 2*s));
   n=m(jj);         % number of points
   NN(jj)=n;        % number of points
 
 
   % test of subgroup-based rank-1 lattice
   tmp =zeros(1,MT);
   [base] = GroupLatticeBase(s,n);  % get generating vector
   for kk=1:MT
       grids =  mod ((0:(n-1))'*base,n)'/n;     
       grids = mod(bsxfun(@plus,grids,rand(s,1)),1);  % random shift
       y = gfun(grids, c, b);   % approximation value     
       tmp(kk)= abs(y-Yt)/Yt;  % error 
   end
   Error(1,jj)= mean(tmp);
   STDerror(1,jj) = std(tmp);
    
    
    
      
     
    % % test of Monte Carlo sampling
   tmp =zeros(1,MT);
   for kk=1:MT   
       grids = rand(s,n);     
       y = gfun(grids, c, b);    
       tmp(kk)= abs(y-Yt)/Yt;
   end
   Error(2,jj)= mean(tmp);
   STDerror(2,jj) = std(tmp);
    

 
    
end  

Error
save(strcat(['AppTest_',num2str(s)]),'Error','STDerror','NN');
    