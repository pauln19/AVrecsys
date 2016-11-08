rec = [user_id zeros(size(user_id,1),5)];

for indexUser = 1:size(user_id)
    %retrieve user id
    user = user_id(indexUser,1);
    %user discipline and industry
    id = userdiscind(userdiscind(:,1) == user,:);
    
    region = usercountries(usercountries(:,1) == user,2);
    
    fiveBestJobs = mostPopularPerRegion( region, 5 );
    rec(indexUser,:) = [rec(indexUser) fiveBestJobs];
end