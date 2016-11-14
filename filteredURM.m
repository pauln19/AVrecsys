%Creating an urm filtered (only users that we have to recommend, and active
%items)
load('interactions.mat');
load('user_id.mat');
load('itemprofiles.mat');

v = [1:size(user_id,1)].';
userMap = containers.Map(sort(user_id(:,1)),v);

activeJobs = itemprofiles(itemprofiles(:,11)==1);
v = [1:size(activeJobs,1)].';
itemMap = containers.Map(activeJobs(:,1),v);

%filtering the interactions removing the ones who don't have the users and
%items taken in consideration
%i1 = interactions(ismember(activeJobs(:,1), interactions(:,2)),:);
availableInteractions = interactions(ismember(interactions(:,2),activeJobs(:,1)),:);
availableInteractions = availableInteractions(ismember(availableInteractions(:,1), user_id(:,1)),:);
sparseI = zeros(1,size(availableInteractions,1));
sparseJ = zeros(1,size(availableInteractions,1));
sparseV = zeros(1,size(availableInteractions,1));

for i = 1:size(availableInteractions,1)
    
    user = values(userMap,num2cell(availableInteractions(i,1)));
    item = values(itemMap,num2cell(availableInteractions(i,2)));
    
    sparseI(1,i) = cell2mat(user);
    sparseJ(1,i) = cell2mat(item);
    sparseV(1,i) = availableInteractions(i,3);
    
end

FilteredURM = sparse(sparseI, sparseJ, sparseV);