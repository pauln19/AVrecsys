load('interactions.mat');
load('user_id.mat');

for indexUser = 1:size(user_id)
    
    indexInteractions = find(interactions(:,1) == user_id(indexUser));
    userInteractionsTmp = unique([interactions(indexInteractions,2) ... 
        interactions(indexInteractions,3)],'rows');
    
    [uv,~,~] = unique(userInteractionsTmp(:,1));
    %v = accumarray(idx,userInteractionsTmp(:,2),[],@max);
    userInteractions{indexUser} = uv.';
    
    
end