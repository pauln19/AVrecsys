% for i = 1:size(jobInteracted) 
%            row = full(icm(jobInteracted(i,1) == M(:,1),:));
%            trainingSet(:,i) = row;
%            %trainingSet(i,:) = icm(find(jobInteracted(i,1) == M(:,1)),:);
%            target(i) = interactions(jobInteracted(i,1) == M(:,1),3);
% end



%inizializzo la rete neurale
net = feedforwardnet(10);
%net.performFcn = 'mse';
net.trainParam.epochs = 100;
net.divideFcn = '';
net.trainParam.showWindow=0; 

% values(itemMap, id_Job) -> index rows in icm for that job
for j=1:10000
    %prendo le interazioni dell'utente che sto analizzando
    userInteraction = find(interactions(:,1) == user_id(j));
    job = interactions(userInteraction,2);
    %job not interacted with
    %jobInteracted = find(not(ismember(interactions(:,1),userInteraction(:,1))));
    jobInteracted = intersect(job(:,1), M(:,1));
    if(size(jobInteracted,1)>15)
        jobNotInteracted = setdiff(M(:,1), jobInteracted(:,1));
        jobIdsToTest = intersect(jobNotInteracted(:,1), M(find(M(:,11)==1),1));
        rowsInIcm = cell2mat(values(itemMap, num2cell(jobIdsToTest)));
        jobToTest = icm(rowsInIcm,:).';
        finalJobToTest = jobToTest(:,1:9999);
        clear jobToTest;
        random = randi(size(jobNotInteracted,1), size(jobInteracted,1), 1);
        %target = zeros(1,size(jobInteracted,1)*2);
        target = interactions(ismember(jobInteracted(:,1),interactions(:,2)),3).';
        %index = find(jobInteracted(:,1) == M(:,1));
        %trainingSet = sparse(size(jobInteracted,1) + 500, 45110);
        %trainingSet = zeros(45111, size(jobInteracted,1));
        %Vedere sopra per la vecchia versione con il for
        indexJobInteractedIcm = cell2mat(values(itemMap, num2cell(jobInteracted)));
        trainingSet = icm(indexJobInteractedIcm,:).';
        
        notInteractedItems = icm(random, :);
        trainingSet = horzcat(trainingSet, full(notInteractedItems).');
        %target(size(jobInteracted):end) = -1;
        A(1:1, 1:size(jobInteracted)) = -1; 
        target = horzcat(target, A);
        clear A;
        [net,tr] = train(net, full(trainingSet), target);
        out = sim(net, finalJobToTest);
    end  
end
