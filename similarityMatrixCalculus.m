sm = zeros(size(M,1),size(M,1));

for i = 1:size(M,1)
    for j = 1:size(M,1)
        
        
        sm(i,j) = computeSimilarity(icm(i,:),icm(j,:),0);
        
        
    end
    
    
end