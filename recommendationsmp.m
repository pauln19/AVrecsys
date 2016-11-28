load('interactions.mat');
load('n_interactionsPerItem.mat');
load('user_id.mat');

rec = [user_id zeros(size(user_id,1),5)];

for indexUser = 1:size(user_id)
    %retrieve user id
    user = user_id(indexUser,1);
    %user discipline and industry
    %id = userdiscind(userdiscind(:,1) == user,:);
    
    userInteractions = interactions(interactions(:,1) == user_id(indexUser),2);
    %region = usercountries(usercountries(:,1) == user,2);
    tmp = setdiff(n_interactionsPerItem(:,2),...
        intersect(n_interactionsPerItem(:,2),userInteractions(:,1)),'stable');
    
    fiveBestJobs = tmp(1:5,1).';
    rec(indexUser,:) = [rec(indexUser) fiveBestJobs];
end

writeRecommendationFile('submit',rec);