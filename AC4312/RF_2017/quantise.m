function data = quantise(desc,C)

for i = 1:size(desc,2)
    sub = zeros(1,size(C,2)); 
    for j = 1:size(C,2)
    sub(j) = norm(double(desc(:,i))-double(C(:,j))); 
    end 
    [M,data(i)] = min(sub);
    
end 

end 