% %ERRORE: URM ha ultima interazione con l'utente (non tiene conto di
% %interazioni multiple tra user e item

load('usercareerlevel.mat');
load('interactions.mat');
load('itemMap.mat');

v = [1:size(usercareerlevel,1)].';
userMap = containers.Map(sort(usercareerlevel(:,1)),v);

% v = [1:size(M,1)].';
% itemMap = containers.Map(M(:,1),v);

sparseI = zeros(1,size(interactions,1));
sparseJ = zeros(1,size(interactions,1));
sparseV = zeros(1,size(interactions,1));

for i = 1:size(interactions,1)
    
    user = values(userMap,num2cell(interactions(i,1)));
    item = values(itemMap,num2cell(interactions(i,2)));
    
    sparseI(1,i) = cell2mat(user);
    sparseJ(1,i) = cell2mat(item);
    sparseV(1,i) = interactions(i,3);
    
end

[S, ~, ic] = unique([sparseI.' sparseJ.'],'rows');
Sb = zeros(1,size(S,1));

for i = 1:size(sparseV,2)
    
    Sb(1,ic(i,1)) = Sb(1,ic(i,1)) + sparseV(1,i);
    
end

URM = sparse(S(:,1), S(:,2), Sb);