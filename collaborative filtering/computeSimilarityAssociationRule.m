function [sim] = computeSimilarityAssociationRule(item1, item2)

load('interactions.mat');

vector = unique(interactions(interactions(:,2) == item2,1));

sim = numel(intersect(interactions(interactions(:,2) == item1,1),vector)) / (numel(vector) + 3);

end