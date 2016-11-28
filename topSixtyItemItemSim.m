%This function creates and stores the top 50 items items similarity

%rows = available jobs
%cols = top 50 jobs
% 
load('itemprofiles.mat');
load('URM_2.mat');
load('itemMap.mat');

% URM = logical(URM);

itemsAvailable = itemprofiles(itemprofiles(:,11) == 1,1);
topSixty = cell(size(itemsAvailable,1),50);
topSixty(:) = {0};

for item1 = 1:size(itemsAvailable,1)
    
    tmp(:,1) = itemprofiles(:,1);
    tmp(:,2) = 0;
    
    for item2 = 1:size(itemprofiles,1)
        
        if ~ (itemsAvailable(item1) == itemprofiles(item2,1))
            
            tmp(item2,2) = computeSimilarityAssociationRule...
                (itemsAvailable(item1), itemprofiles(item2,1), itemMap, URM);
            
        end
        
    end
    
    [sortedSim, sortIndex] = sort(tmp(:,2),'descend');
    sortedJobs = tmp(sortIndex,1);
    
    for i = 1:50
        
        topSixty{item1,i} = {sortedJobs(i),sortedSim(i)};
        
    end
    
    
end

