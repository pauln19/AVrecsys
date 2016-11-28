%Region is the integer representing the user region
function [ recc ] = mostPopularPerRegion( region, userInteractions, n)
load('mostPopularInDe.mat');
load('mostPopularInAt.mat');
load('mostPopularInCh.mat');
load('mostPopularInNoNDach.mat');
%MOSTPOPULARPERUSER Summary of this function goes here
    switch region
        case 1
            recommandableItems = setdiff(mostPopularInDe(:,1), userInteractions(:,1),'stable');
            recc = recommandableItems(1:n);
        case 2
            %do something with at
            recommandableItems = setdiff(mostPopularInAt(:,1), userInteractions(:,1),'stable');
            recc = recommandableItems(1:n);
        case 3
            %do something with ch
            recommandableItems = setdiff(mostPopularInCh(:,1), userInteractions(:,1),'stable');
            recc = recommandableItems(1:n);
        otherwise
            %do something with non_dach
            recommandableItems = setdiff(mostPopularInNoNDach(:,1), userInteractions(:,1),'stable');
            recc = recommandableItems(1:n);
    end
end