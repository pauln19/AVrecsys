%Per ogni utente, devo prendere le sue interazioni,
load('urm.mat');
load('itemMap.mat');
load('itemprofiles.mat');
load('user_id.mat');

%final recommendations matrix
rec = [user_id zeros(size(user_id,1),5)];

%recommandable items indexes and number
itemsAvailable = itemprofiles(itemprofiles(:,11) == 1);
nIA = size(itemsAvailable,1);

%loop on every target user
for indexUser = 1:size(user_id)
    
    %pick interactions for that user
    indexInteractions = find(interactions(:,1) == user_id(indexUser));
    userInteractionsTmp = unique([interactions(indexInteractions,2) interactions(indexInteractions,3)],'rows');
    %items recommandable for the user
    remainingItems = setdiff(itemsAvailable,userInteractionsTmp);
    
    %group by items with the max value of interactions (between 1 and 3)
    [uv,~,idx] = unique(userInteractionsTmp(:,1));
    v = accumarray(idx,userInteractionsTmp(:,2),[],@max);
    userInteractions = [uv v];
    
    for remitems = 1:size(remainingItems,1);
        
        computeRating(remainingItems(remitems), userInteractions);
        
    end
    
    
    
end


function [rating] = computeRating(item,userInteractions)

for j = 1:size(userInteractions)
    
    a = computeSimilarity(item,userInteractions(j,1));
    num = [num userInteractions(j,2) * a];
    den = den + a;
    
end

rating = num/den;

end

function [sim] = computeSimilarity(item1, item2)

% user1 = interactions((interactions(:,2) == item1));
% user2 = interactions((interactions(:,2) == item2));
% 
% user = intersect(user1, user2);
% 
% interactions(interactions(:,2) == item1,3)

row1 = cell2mat(values(itemMap,num2cell(item1)));
row2 = cell2mat(values(itemMap,num2cell(item2)));

row1 = full(URM(row1,:));
row2 = full(URM(row2,:));

sim = dot(row1,row2)/ (norm(row1) * norm(row2));

end