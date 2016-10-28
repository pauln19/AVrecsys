%Region is the integer representing the user region
function [ recc ] = mostPopularPerRegion( region )
    
%MOSTPOPULARPERUSER Summary of this function goes here
    switch region
        case 1
            recc = mostPopularInDe(1:5);
        case 2
            %do something with at
            recc = mostPopularInAt(1:5);
        case 3
            %do something with ch
            recc = mostPopularInCh(1:5);
        case 4
            %do something with non_dach
            recc = mostPopularInCh(1:5);
    end
end

