%Per ogni utente, devo prendere le sue interazioni,

load('itemprofiles.mat');
load('user_id.mat');
load('interactions.mat');

%final recommendations matrix
rec = [user_id zeros(size(user_id,1),5)];

%recommandable items indexes and number
itemsAvailable = itemprofiles(itemprofiles(:,11) == 1);

%loop on every target user
for indexUser = 1:size(user_id)
    
    %5 best jobs per user
    fiveBestRat = [0 0 0 0 0];
    fiveBestJobs = [0 0 0 0 0];
    
    %pick interactions for that user
    indexInteractions = find(interactions(:,1) == user_id(indexUser));
    userInteractionsTmp = unique([interactions(indexInteractions,2) ... 
        interactions(indexInteractions,3)],'rows');
    %items recommandable for the user
    remainingItems = setdiff(itemsAvailable,userInteractionsTmp);
    
    %group by items with the max value of interactions (between 1 and 3)
    [uv,~,idx] = unique(userInteractionsTmp(:,1));
    v = accumarray(idx,userInteractionsTmp(:,2),[],@max);
    userInteractions = [uv v];
    
    for remitems = 1:size(remainingItems,1);
        
        estRat = computeRating(remainingItems(remitems), userInteractions);
        if estRat > min(fiveBestRat)
            
            [m,i] = min(fiveBestRat);
            fiveBestRat(i) = estRat;
            fiveBestJobs(i) = remainingItems(remitems);
            
        end
        
    end
    
    %sort by estimate rating
    [sortedFiveBestRat, sortIndex] = sort(fiveBestRat,'descend');
    sortedFiveBestJobs = fiveBestJobs(sortIndex);
    
    tmp = find(sortedFiveBestJobs == 0);
    sortedFiveBestJobs(tmp) = mostPopularPerRegion(region,size(tmp,2));
    
    rec(indexUser,:) = [rec(indexUser) sortedFiveBestJobs];
    
end