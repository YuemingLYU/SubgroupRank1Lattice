%    Coherence Test




s = 25 ;  % dimension of test problem  d= 2*s


Coherence=zeros(3,10);
STDCoherence=Coherence;
a= primes(6*10^4);
NN = zeros(1,10);



MT= 50;     % number of indepedent runs


for jj=1:10
   jj
   m=a(find(mod(a-1,s)==0 &a>= s));
   n=m(jj);        
   NN(jj)=n*2;        % number of points
 
 
   % test of subgroup-based spherical lattice
   
    [base] = GroupSphereLatticeBase(s,n);  % get generating vector
   F = fft(eye(n))/sqrt(s);
   F = F(1+base,:);
   V = [[real(F);imag(F)],[-imag(F);real(F)]];
   Cor = abs(V'*V);
   Cor(logical(eye(n*2)))=-10;
   Coherence(1,jj)= max(Cor(:));
   
    
  

   % % test of Lyu Spherical lattice
 
   [base,~] = LogEnergyOP_Demo(s,n,5);  % get generating vector
   F = fft(eye(n))/sqrt(s);
   F = F(1+base,:);
   V = [[real(F);imag(F)],[-imag(F);real(F)]];
   Cor = abs(V'*V);
   Cor(logical(eye(n*2)))=-10;
   Coherence(2,jj)= max(Cor(:));
   

      
    % % test of Monte Carlo sampling
   tmp =zeros(1,MT);
   for kk=1:MT   
       V = randn(2*s,2*n); 
      Cor =  abs( 1-pdist2(V',V','cosine') );  
      Cor(logical(eye(n*2)))=-10;
      tmp(kk)=max(Cor(:));
   end
   Coherence(3,jj)= mean(tmp);
   STDCoherence(3,jj) = std(tmp);
    

 
    
end  

Coherence
STDCoherence
save(strcat(['CoherenceTest_',num2str(2*s)]),'Coherence','STDCoherence','NN');