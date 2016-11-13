function [ output_args ] = writeRecommendationFile( file_name, ouputs )
%Function that prints out the file
%   Detailed explanation goes here
fileId = fopen(strcat(file_name,'.csv'),'w');
fprintf(fileId, 'user_id,recommended_items\n');
for i=1:10000
        fprintf(fileId, '%i,%i %i %i %i %i\n',ouputs(i,1), ouputs(i,2:6));
end
    
end

