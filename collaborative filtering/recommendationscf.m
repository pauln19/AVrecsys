%Per ogni utente, devo prendere le sue interazioni,

load('itemprofiles.mat');
load('user_id.mat');
load('interactions.mat');
load('useryearsExp.mat');
load('n_interactionsPerItem.mat');

%final recommendations matrix
rec = [user_id zeros(size(user_id,1),5)];

%recommandable items indexes and number
itemsAvailable = itemprofiles(itemprofiles(:,11) == 1,1:2);

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
    [remainingItems, index] = setdiff(itemsAvailable(:,1),userInteractionsTmp);
    remainingItems(:,2) = itemsAvailable(index,2);
    
    %filter by years of experience
    remainingItems = remainingItems(remainingItems(:,2) ...
        < useryearsExp(useryearsExp(:,1) == user_id(indexUser),2),1);
    
    %filter by top 150 interacted
    remainingItems = intersect(n_interactionsPerItem(:,2),remainingItems,'stable');
    
    topRemainingItems = remainingItems(1:100,1);
    
    %group by items with the max value of interactions (between 1 and 3)
    [uv,~,idx] = unique(userInteractionsTmp(:,1));
    v = accumarray(idx,userInteractionsTmp(:,2),[],@max);
    userInteractions = [uv v];
    
    for remitems = 1:size(topRemainingItems,1);
        
        estRat = computeRating(topRemainingItems(remitems), userInteractions);
        if estRat > min(fiveBestRat)
            
            [~,i] = min(fiveBestRat);
            fiveBestRat(i) = estRat;
            fiveBestJobs(i) = topRemainingItems(remitems);
            
        end
        
    end
    
    %sort by estimate rating
    [sortedFiveBestRat, sortIndex] = sort(fiveBestRat,'descend');
    sortedFiveBestJobs = fiveBestJobs(sortIndex);
    
    rec(indexUser,:) = [rec(indexUser) sortedFiveBestJobs];
    
end