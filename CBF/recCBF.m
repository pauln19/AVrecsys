function [rec] = recCBF( similarityMatrixUser, similarityMatrixItem, ...
    cfSim, user_id, interactions, weightCF, weightCBI, ...
    weightCBU )
%RECCBF Summary of this function goes here
%   Detailed explanation goes here

% hybridSim = containers.Map('KeyType','double','ValueType','any');

similarityMatrixUser(:,3) = similarityMatrixUser(:,3) * weightCBU / max(similarityMatrixUser(:,3));

similarityMatrixItem(:,3) = similarityMatrixItem(:,3) * weightCBI / max(similarityMatrixItem(:,3));

tmp = cell2mat(values(cfSim)');

maximumCF = max(tmp(:,2));

clear tmp;

rec = zeros(numel(user_id),6);

interactions = unique(interactions,'rows');

for u = user_id'
    
    tic
    
    %%%%%%%%%%%%%%%% BEGIN OF CBU %%%%%%%%%%%%%%%%%%%%
    
    %most similar users with sim value
    msu = similarityMatrixUser(similarityMatrixUser(:,1) == u,2:3);
    
    %Indexes of items interacted by msu (a: logical indexes in interactions
    %b: at the correspondent interactions index, index in msu)
    [a,b] = ismember(interactions(:,1),msu(:,1));
    
    %Items interacted by msu with the msu similarity times the weight
    userUserSim = [interactions(a,2), msu(b(find(b)),2)];
    
    %%%%%%%%%%%%%%%%% END OF CBU %%%%%%%%%%%%%%%%%%%
    
    %%%%%%%%%%%%%%%% BEGIN OF CBI %%%%%%%%%%%%%%%%%%
    
    % items interacted by u
    msi = unique(interactions(interactions(:,1) == u,2));
    
    %Similar items to msi with their similarities
    itemItemSim = similarityMatrixItem(ismember(similarityMatrixItem(:,1),msi),2:3);
    
    %%%%%%%%%%%%%%%%% END OF CBI %%%%%%%%%%%%%%%%%%%
    
    %Add the cf results if present
    if isKey(cfSim,u)
        userItemSim = cell2mat(values(cfSim,{u}));
        userItemSim(:,2) = userItemSim(:,2) / maximumCF * weightCF;
        sim = [userUserSim; itemItemSim; userItemSim];
    else
        sim = [userUserSim; itemItemSim];
    end
    
    %Delete already interacted items
    sim(ismember(sim(:,1),msi),:) = [];
    
    %Accumarray and sorting by sim
    [uv,~,idx] = unique(sim(:,1));
    v = accumarray(idx,sim(:,2),[],@sum);
    [v,idx] = sort(v,'descend');
    sim = [uv(idx) v];
    
    
    if size(sim,1) >= 5
        rec(user_id == u,:) = [u, sim(1:5,1)'];
    else
        rec(user_id == u,1) = u;
    end
    
    toc
end

