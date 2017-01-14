function [] = tfidf( itemprofiles, tags )
%TFIDF Summary of this function goes here
%   Detailed explanation goes here

n_items = size(itemprofiles,1);
itemprofiles = itemprofiles(:,2:end);
%itemprofiles = itemprofiles(:,12:end);
idx = 1;

for i = tags'
    
    %rows sono gli item con l'attributo i
    [rows, ~] = find(itemprofiles == i(1,1));
    
    tf = 0;
    
    for j = unique(rows)'
        
        tf = tf + numel(find(itemprofiles(j,:) == i))/nnz(itemprofiles(j,:));
        
    end
    
    idf = log(n_items/tags(idx,3));
    tags(idx,4) = tags(idx,2) * tf * idf;
    idx = idx + 1;
    
end

end

