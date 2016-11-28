% load('itemprofiles.mat');
% load('interactions.mat');
% 
% itemsAvailable = itemprofiles(itemprofiles(:,11) == 1);
% 
% itemsInteracted = sort(interactions(:,2));
% 
% occItemsInteracted = histc(itemsInteracted,unique(itemsInteracted));
% 
% temp = horzcat(occItemsInteracted,unique(itemsInteracted));
% 
% [M , I] = sort(temp(:,1),'descend');
% temp = temp(I,:);
% 
% top_k = sort(temp(1:150,2));
% 
% simMatTopK = zeros(numel(itemsAvailable),numel(top_k));
% 
% for i = 1:numel(itemsAvailable)
%     
%     for j = 1:numel(top_k)
%         
%         simMatTopK(i,j) = computeSimilarityAssociationRule(itemsAvailable(i),top_k(j));
%         
%     end
%     
% end

load('itemprofiles.mat');

itemsAvailable = itemprofiles(itemprofiles(:,11) == 1);

simMatrix = spalloc(size(itemprofiles,1),size(itemsAvailable,1),20 * size(itemsAvailable,1));

helpVector = zeros(1,size(simMatrix,2));

for i = 1:size(simMatrix,2)
    
    for j = 1:size(simMatrix,1)
        
        helpVector(1,j) = computeSimilarityAssociationRule(itemsAvailable(i,1),itemprofiles(j,1));
        
    end
    
    simMatrix(:,i) = helpVector;
    [~,index] = sort(helpVector);
    simMatrix(index(end:-1:21),i) = 0;
    
end

