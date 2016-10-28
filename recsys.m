%tags = importColCsv('C:\Users\Khanh Huy Paolo Tran\Documents\MATLAB\RecSys\tagsIds.csv');
tags1 = importColCsv('C:\Users\Khanh Huy Paolo Tran\Documents\MATLAB\RecSys\tags1.csv');
tags2 = importColCsv('C:\Users\Khanh Huy Paolo Tran\Documents\MATLAB\RecSys\tags2.csv');

tags = union(tags1,tags2);

%number of tags
icmCols = size(tags,1);

%number of jobs
icmRows = size(M,1);

vector = [1:icmCols].';

%mapping tags and colummn value
mapTags = containers.Map(tags,vector);

sparseI = [];
sparseJ = [];

for i = 1:icmRows
    for j = 2:6
        switch j
            case 2
                sparseI = [sparseI i];
                sparseJ = [sparseJ M(i,j)];
                
            case 3
                sparseI = [sparseI i];
                sparseJ = [sparseJ M(i,j) + 6];
                
            case 4
                sparseI = [sparseI i];
                sparseJ = [sparseJ M(i,j) + 28];
                
            case 5
                sparseI = [sparseI i];
                sparseJ = [sparseJ M(i,j) + 51];
                
            case 6
                sparseI = [sparseI i];
                sparseJ = [sparseJ M(i,j) + 55];
        end
        %S = sparse(i,j,v) generates a sparse matrix S from the triplets i, j, and v such that S(i(k),j(k)) = v(k).
        % posizioni su ICM: i = items; j = attributes;
    end
    
    j = 9;
    sparseI = [sparseI i];
    sparseJ = [sparseJ M(i,j) + 70];
    
    % MANCA OFFSET DI 75
    for j = 12:size(M,2)
        if M(i,j) ~= 0
            sparseI = [sparseI i];
            sparseJ = [sparseJ cell2mat(values(mapTags,num2cell(M(i,j))))];
        end
        
    end
end
