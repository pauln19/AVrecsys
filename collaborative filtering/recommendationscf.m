%Per ogni utente, devo prendere le sue interazioni,

load('itemprofiles.mat');
load('user_id.mat');
load('interactions.mat');
load('useryearsExp.mat');
load('n_interactionsPerItem.mat');
load('jobInteractedByTargetUser.mat');
load('jobInteractedByTargetUserIndex.mat');
load('itemMap.mat');
load('URM_2.mat');
load('usercountries.mat');

URM = logical(URM);
URM = double(URM);

%final recommendations matrix
%rec = [user_id zeros(size(user_id,1),5)];
load('rec1763.mat');

%recommandable items id and number
itemsAvailable = itemprofiles(itemprofiles(:,11) == 1,1);
itemsAvailableIndex = find(itemprofiles(:,11) == 1);

%loop on every target user
for indexUser = 1764:size(user_id)
    
    %5 best jobs per user
    fiveBestRat = [0 0 0 0 0];
    fiveBestJobs = [0 0 0 0 0];
    sortedFiveBestJobs = [0 0 0 0 0];
    
    %pick interactions for that user
    userInteractions = jobIntByTarUser{indexUser};
    userInteractionsIndex = jobIntByTarUser2{indexUser};
    %     indexInteractions = find(interactions(:,1) == user_id(indexUser));
    %     userInteractionsTmp = unique([interactions(indexInteractions,2) ...
    %         interactions(indexInteractions,3)],'rows');
    %items recommandable for the user
    %     [remainingItems, index] = setdiff(itemsAvailable(:,1),userInteractionsTmp);
    
    [remainingItems, ~] = setdiff(itemsAvailable(:,1),userInteractions);
    remainingIndex = setdiff(itemsAvailableIndex(:,1),userInteractionsIndex);
    
%     [remainingItems, index] = setdiff(itemsAvailable(:,1),userInteractions);
%     remainingItems(:,2) = itemsAvailable(index,2);
%     
%     %filter by years of experience
%     if useryearsExp(useryearsExp(:,1) == user_id(indexUser),2) ~= 0
%         remainingItems = remainingItems(remainingItems(:,2) ...
%             < useryearsExp(useryearsExp(:,1) == user_id(indexUser),2),1);
%     end
%     %filter by top 150 interacted
%     remainingItems = intersect(n_interactionsPerItem(:,2),remainingItems,'stable');
%     
%     topRemainingItems = remainingItems(1:min(150,length(remainingItems)),1);
    
    %     %group by items with the max value of interactions (between 1 and 3)
    %     [uv,~,idx] = unique(userInteractionsTmp(:,1));
    %     v = accumarray(idx,userInteractionsTmp(:,2),[],@max);
    %     userInteractions = [uv v];
    
    if isempty(userInteractions)
        
        sortedFiveBestJobs = mostPopularPerRegion(usercountries(usercountries(:,1) == user_id(indexUser),2),...
            userInteractions.', 5).';
        
    else
        
        
%         for remitems = 1:size(topRemainingItems,1)
        for remitems = 1:size(remainingItems,1)
            
%             estRat = computeRating(topRemainingItems(remitems), userInteractions, itemMap, URM);
%             estRat = computeRating(remainingItems(remitems), userInteractions, itemMap, URM);
            estRat = computeRating(remainingIndex(remitems), userInteractionsIndex, itemMap, URM);
            if estRat > min(fiveBestRat)
                
                [~,i] = min(fiveBestRat);
                fiveBestRat(i) = estRat;
%                 fiveBestJobs(i) = topRemainingItems(remitems);
                fiveBestJobs(i) = remainingItems(remitems);
                
            end
            
        end
        
        %sort by estimate rating
        [sortedFiveBestRat, sortIndex] = sort(fiveBestRat,'descend');
        sortedFiveBestJobs = fiveBestJobs(sortIndex);
        
    end
    
    sortedFiveBestJobs(sortedFiveBestJobs == 0) = mostPopularPerRegion(...
        usercountries(usercountries(:,1) == user_id(indexUser),2),...
        userInteractions.',size(find(sortedFiveBestJobs == 0),2));
    
    rec(indexUser,:) = [rec(indexUser) sortedFiveBestJobs];
    
end