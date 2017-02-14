function subsets = bagging(T,S,replacement,nt)

n = length(S); 
if ~exist('replacement','var')
  replacement=false;
end

if(replacement)
    
    for t=1:T
    random = 1+round(rand(nt,1)*(n-1)); 
    subsets(:,:,t) = S(random,:);  
    end
elseif(~replacement && nt>n) 
    error('Subset length is too long');
else 
    for t=1:T
        Snew = S; 
        for i=1:nt
    random = 1+round(rand*(length(Snew)-1)); 
    subsets(i,:,t) = Snew(random,:);  
    Snew(random,:) = []; 
        end
    end 
    
end 
end 