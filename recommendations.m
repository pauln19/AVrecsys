rec = user_id;

for indexUser = 1:size(user_id)
    
    fiveBestRat = [0 0 0 0 0];
    fiveBestJobs = [0 0 0 0 0];
    
    user = user_id(indexUser,1);
    indexInteractions = find(interactions(:,1) == user);
    
    if (indexInteractions == 0)
        
        region = usercountries(usercountries(:,1) == user,2);
        fiveBestJobs = mostPopularPerRegion( region );
        
    else
        interactedItems = interactions(indexInteractions,2);
        
        for items = 1:size(icm,1)
            if M(items,11) == 1
                
                denSumSim = 0;
                numSumSim = 0;
                
                for i = 1:numel(interactedItems)
                    
                    k = find(M(:,1) == interactedItems(i));
                    
                    sim = computeSimilarity(icm(k,:),icm(items,:),0);
                    
                    numSumSim = numSumSim + interactions(indexInteractions(i),3) * sim;
                    
                    denSumSim = denSumSim + sim;
                    
                end
                
                estRat = numSumSim/denSumSim;
                
                if estRat > min(fiveBestRat)
                    
                    [m,i] = min(fiveBestRat);
                    fiveBestRat(i) = estRat;
                    fiveBestJobs(i) = M(items,1);
                    
                end
            end
        end
    end
    
    [sortedFiveBestRat, sortIndex] = sort(fiveBestRat);
    sortedFiveBestJobs = fiveBestJobs(sortIndex);
    rec(indexUser) = [rec(indexUser) sortedFiveBestJobs];
    
end