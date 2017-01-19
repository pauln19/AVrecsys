function [icm] = computeICM(itemprofiles,tags)

%Tolgo item inattivi
%itemprofiles(itemprofiles(:,11) == 0,:) = [];

% %Prendo i tag
% itemprofiles = itemprofiles(:,12:end);

% Questo per utenti
itemprofiles = itemprofiles(:,2:end);

tags = sort(tags);
I = [];
J = [];
% I = zeros(1,nnz(itemprofiles));
% J = zeros(1,nnz(itemprofiles));

tagsMap = containers.Map(tags',[1:numel(tags)]);

%Utenti?
for i = 1:size(itemprofiles,1)
    
    %Prende riga e quelli nnz
    [~,~,itemTags] = find(itemprofiles(i,:));
    
    %Prendi solo i top tag
    remTags = intersect(itemTags,tags);
    
    if ~isempty(remTags)
        
        I = [I repmat(i,1,numel(remTags))];
        J = [J cell2mat(values(tagsMap,num2cell(remTags)))'];
        
    end
    
end

V = ones(1,numel(I));

icm = sparse(I,J,V,40000,100);