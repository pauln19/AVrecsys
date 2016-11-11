function [sim] = computeSimilarity(item1, item2)
load('itemMap.mat');
load('urm.mat');

col1 = cell2mat(values(itemMap,num2cell(item1)));
col2 = cell2mat(values(itemMap,num2cell(item2)));

col1 = full(URM(:,col1)).';
col2 = full(URM(:,col2)).';

sim = dot(col1,col2)/ (norm(col1) * norm(col2));

end