load('itemprofiles.mat');
load('interactions.mat');

itemsAvailable = itemprofiles(itemprofiles(:,11) == 1);

itemsInteracted = sort(interactions(:,2));

occItemsInteracted = histc(itemsInteracted,unique(itemsInteracted));

temp = horzcat(occItemsInteracted,unique(itemsInteracted));

[M , I] = sort(temp(:,1),'descend');
temp = temp(I,:);

top_k = sort(temp(1:150,2));

simMatTopK = zeros(numel(itemsAvailable),numel(top_k));

for i = 1:numel(itemsAvailable)
    
    for j = 1:numel(top_k)
        
        simMatTopK(i,j) = computeSimilarityAssociationRule(itemsAvailable(i),top_k(j));
        
    end
    
end