%final recommendations matrix
rec = [user_id zeros(size(user_id,1),5)];

%loop on every target user
for indexUser = 1:size(user_id)
    
    %5 best jobs per user
    fiveBestRat = [0 0 0 0 0];
    fiveBestJobs = [0 0 0 0 0];
    
    %retrieve user id
    user = user_id(indexUser,1);
    %user discipline and industry
    id = userdiscind(userdiscind(:,1) == user,:);
    
    %user experience row
    userExp = useryearsExp(indexUser, 2);
    %pick interactions for that user
    indexInteractions = find(interactions(:,1) == user);
    
    %if no interactions, then most popular
    if (indexInteractions == 0)
        
        region = usercountries(usercountries(:,1) == user,2);
        fiveBestJobs = mostPopularPerRegion( region );
        
    else
        %pick interacted items
        interactedItems = interactions(indexInteractions,2);
        
        %pick every item
        for items = 1:size(icm,1)
            %if job is available, then continue
            if M(items,11) == 1
                
                if (id(2) == M(items,4) && id(3) == M(items,5)) || userExp> M(items,2) %|| id(1) == 0 || id(2) == 0
                    
                    denSumSim = 0;
                    numSumSim = 0;
                    
                    for i = 1:numel(interactedItems)
                        %pick interacted job
                        k = find(M(:,1) == interactedItems(i));
                        %do s_ji
                        sim = computeSimilarity(icm(k,:),icm(items,:),0);
                        %interactions = rating
                        numSumSim = numSumSim + interactions(indexInteractions(i),3) * sim;
                        
                        denSumSim = denSumSim + sim;
                        
                    end
                    
                    estRat = numSumSim/denSumSim;
                    %replace the minimum one if lower
                    if estRat > min(fiveBestRat)
                        
                        [m,i] = min(fiveBestRat);
                        fiveBestRat(i) = estRat;
                        fiveBestJobs(i) = M(items,1);
                        
                    end
                end
            end
        end
    end
    %sort by estimate rating
    [sortedFiveBestRat, sortIndex] = sort(fiveBestRat);
    sortedFiveBestJobs = fiveBestJobs(sortIndex);
    rec(indexUser,:) = [rec(indexUser) sortedFiveBestJobs];
    
end