item = 1;
sixOffset = 6;
i = 1;

while i+sixOffset <= size(sparseI,2)
    
    if(sparseI(1,i+sixOffset) == item)
        var = sparseJ(1,i+sixOffset);
        sparseJ(1,i+sixOffset) = var + 75;
    else
        item = item+1;
        sixOffset = sixOffset + 6;
    end
    
    i = i + 1;
    
end