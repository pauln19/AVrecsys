for i = 1:size(indexZeros,2)
    
   sparseJ(indexZeros(i)-i+1) = [];
   sparseI(indexZeros(i)-i+1) = [];
    
end