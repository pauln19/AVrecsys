%Region is the integer representing the user region
function [ recc ] = mostPopularPerRegion( region, userInteractions )
load('mostPopularInDe.mat');
load('mostPopularInAt.mat');
load('mostPopularInCh.mat');
load('mostPopularInNoNDach.mat');
%MOSTPOPULARPERUSER Summary of this function goes here
    switch region
        case 1
            recommandableItems = intersect(mostPopularInDe(:,1), userInteractions(:,1),'stable');
            recc = recommandableItems(1:5);
        case 2
            %do something with at
            recommandableItems = intersect(mostPopularInAt(:,1), userInteractions(:,1),'stable');
            recc = recommandableItems(1:5);
        case 3
            %do something with ch
            recommandableItems = intersect(mostPopularInCh(:,1), userInteractions(:,1),'stable');
            recc = recommandableItems(1:5);
        otherwise
            %do something with non_dach
            recommandableItems = intersect(mostPopularInNoNDach(:,1), userInteractions(:,1),'stable');
            recc = recommandableItems(1:5);
    end
end

