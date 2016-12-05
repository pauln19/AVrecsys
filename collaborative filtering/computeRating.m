function [rating] = computeRating(indexItem,userInteractions,URM, similarItems)

% num = zeros(1,size(userInteractions,1));
% den = 0;
% 
% for j = 1:size(userInteractions,1)
%     
%     a = computeSimilarityAssociationRule(userInteractions(j,1),item);
%     num(j) = userInteractions(j,2) * a;
%     den = den + a;
%     
% end
% 
% rating = sum(num)/den;

rating = 0;
for j = userInteractions
    rating = rating + computeSimilarityAssociationRule(j,indexItem,URM);
end
% if (isKey(similarItems, indexItem))
%     
%     v = values(similarItems, num2cell(userInteractions));
%     for j = userInteractions
%         
%         cella = v{1};
%         
%         if find(cella{1} == j)
%             rating = rating + cella{2}(cella{1} == j);
%             
%         else
%         
%             %rating = rating + computeSimilarityAssociationRule(j,indexItem,URM);
%         
%         end
%     end
% end



% if (any(URM(:,indexItem)))
%     %prende la similarity tra le interazioni e l'item che sto considerando 
%     for j = userInteractions
%             rating = rating + values(1);
%     end
% end

end

% function [sim] = computeSimilarity(item1, item2)
% load('itemMap.mat');
% load('urm.mat');
% % user1 = interactions((interactions(:,2) == item1));
% % user2 = interactions((interactions(:,2) == item2));
% % 
% % user = intersect(user1, user2);
% % 
% % interactions(interactions(:,2) == item1,3)
% 
% col1 = cell2mat(values(itemMap,num2cell(item1)));
% col2 = cell2mat(values(itemMap,num2cell(item2)));
% 
% disp(col2);
% 
% col1 = full(URM(:,col1)).';
% col2 = full(URM(:,col2)).';
% 
% sim = dot(col1,col2)/ (norm(col1) * norm(col2));
% 
% end