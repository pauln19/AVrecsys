
load('usercareerlevel.mat');
load('interactions.mat');
load('itemprofiles.mat');

%   Map between user ids and indexes
v = [1:size(usercareerlevel,1)].';
userMap = containers.Map(sort(usercareerlevel(:,1)),v);

%   Map between item ids and indexes
v = [1:size(itemprofiles,1)].';
itemMap = containers.Map(itemprofiles(:,1),v);

sparseI = zeros(1,size(interactions,1));
sparseJ = zeros(1,size(interactions,1));
sparseV = zeros(1,size(interactions,1));

%   Loop through all the interactions
for i = 1:size(interactions,1)
    
    %   Pick the indexes of user of the interaction and of the item
    user = values(userMap,num2cell(interactions(i,1)));
    item = values(itemMap,num2cell(interactions(i,2)));
    
    sparseI(1,i) = cell2mat(user);
    sparseJ(1,i) = cell2mat(item);
    sparseV(1,i) = interactions(i,3);
end

[uv,~,idx] = unique([sparseI.' sparseJ.'],'rows');
v = accumarray(idx,sparseV(1,:),[],@sum);

URM = sparse(uv(:,1), uv(:,2), v);

% 
% [S, ~, ic] = unique([sparseI.' sparseJ.'],'rows');
% Sb = zeros(1,size(S,1));
% 
% for i = 1:size(sparseV,2)
%     
%     Sb(1,ic(i,1)) = Sb(1,ic(i,1)) + sparseV(1,i);
%     
% end
% 
% URM = sparse(S(:,1), S(:,2), Sb);