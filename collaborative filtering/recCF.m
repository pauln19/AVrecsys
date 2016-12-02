%Per ogni utente, devo prendere le sue interazioni;
%creo keyset con num2cell;
%prendo dalla mappa le celle con le top60 delle interazioni;
%filtro quelle non attive e che utente non ha votato;
%pseudo group by sommando il rating tra le varie interazioni che rimangono
function [rec] = recCF(user_id, jobIntByTarUser2, topSimilarItems, itemprofiles)

top = [1053452 2778525 1244196 1386412 657183];

%final recommendations matrix
rec = [user_id zeros(numel(user_id),5)];

%Items with the 1 flag
itemsAvailableIndex = find(itemprofiles(:,11) == 1);

%Loop on all the users to recommend
for userIndex = 10000:numel(user_id)
    
    %Pick /userIndex\ interactions and transform into keySet
    userInteractionsIndex = jobIntByTarUser2{userIndex};
    
    if ~isempty(userInteractionsIndex)
        
        %Pick the items that are still active and that the user hasn't
        %interacted yet
        remainingIndex = setdiff(itemsAvailableIndex(:,1),userInteractionsIndex);
        
        %Look on the /topSimilarItems\ the most similar items to the
        %interactions
        v = values(topSimilarItems, num2cell(userInteractionsIndex));
        
        %v is a 1 x #interactions cell array and every element has 2 cell:
        %v{}{1,1} with a 1x60 interactions id
        %v{}{1,2} with a 60x1 similarities
        itemsSimilarities = [];
        
        for i = 1:numel(v)
            
            items = (v{1,i}{1,1})';
            similarities = v{1,i}{1,2};
            
            [items, ia, ~] = intersect(items,remainingIndex);
            similarities = similarities(ia);
            
            itemsSimilarities = [itemsSimilarities; items similarities];
            
        end
        
        [uv,~,idx] = unique(itemsSimilarities(:,1));
        v = accumarray(idx,itemsSimilarities(:,2),[],@sum);
        itemsSimilarities = [uv v];
        
        [~, ia] = sort(itemsSimilarities(:,2));
        
        itemIndex = itemsSimilarities(ia,1);
        
        switch numel(itemIndex)
            case 0
                rec(userIndex, 2:end) = top;
            case 1
                rec(userIndex, 2:end) = [itemprofiles(itemIndex,1) top(1:4)];
            case 2
                rec(userIndex, 2:end) = [itemprofiles(itemIndex,1)' top(1:3)];
            case 3
                rec(userIndex, 2:end) = [itemprofiles(itemIndex,1)' top(1:2)];
            case 4
                rec(userIndex, 2:end) = [itemprofiles(itemIndex,1)' top(1)];
            otherwise
                rec(userIndex, 2:end) = itemprofiles(itemIndex(1:5),1);
        end
        
    else
        rec(userIndex, 2:end) = top;
    end
    
end