%ERRORE: URM ha ultima interazione con l'utente (non tiene conto di
%interazioni multiple tra user e item

v = [1:size(usercareerlevel,1)].';
userMap = containers.Map(sort(usercareerlevel(:,1)),v);

v = [1:size(M,1)].';
itemMap = containers.Map(M(:,1),v);

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

URM = sparse(sparseI, sparseJ, sparseV);