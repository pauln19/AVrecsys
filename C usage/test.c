//This function creates and stores the top 60 items items similarity

//rows = available jobs
//cols = top 60 jobs

#include <stdio.h>
#include <stdlib.h>
//#include "mat.h"



int main(int argc, char **argv)
{
    //MATFile *pmat;
    printf("ciao");
    //pmat = matopen('C:\Users\Khanh Huy Paolo Tran\Documents\MATLAB\AVrecsys\itemprofiles.mat',"r");
    
}
// load('URM_2.mat');
// load('itemMap.mat');
// 
// itemsAvailable = itemprofiles(itemprofiles(:,11) == 1,1);
// 
// for item1 = 1:size(itemsAvailable,1)
//     
//     topSixty = cell(60,1);
//     topSixty(:) = {0};
//     
//     for item2 = 1:size(itemprofiles,1)
//         
//         tmp(:,1) = itemprofiles(:,1);
//         tmp(:,2) = 0;
//         
//         if ~ (itemsAvailable(item1) == itemprofiles(item2,1))
//             
//             tmp(item2,2) = computeSimilarityAssociationRule...
//                 (itemsAvailable(item1), itemprofiles(item2,1), itemMap, URM);
//             
//         end
//         
//     end
//     
//     [sortedSim, sortIndex] = sort(tmp,'descend');
//     sortedJobs = tmp(sortIndex,1);
//     
// end
// 
