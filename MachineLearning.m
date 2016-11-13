% for i = 1:size(jobInteracted) 
%            row = full(icm(jobInteracted(i,1) == M(:,1),:));
%            trainingSet(:,i) = row;
%            %trainingSet(i,:) = icm(find(jobInteracted(i,1) == M(:,1)),:);
%            target(i) = interactions(jobInteracted(i,1) == M(:,1),3);
% end


load('icm.mat');
load('interactions.mat');
load('user_id.mat');
load('itemMap.mat');
load('itemProfiles.mat');
load('usercountries.mat');
%inizializzo la rete neurale
net = feedforwardnet(10);
%net.performFcn = 'mse';
net.trainParam.epochs = 100;
net.divideFcn = '';
net.trainParam.showWindow=0; 
out = zeros(10000,6);
% values(itemMap, id_Job) -> index rows in icm for that job
for j=1:10000
    clear A;
    %prendo le interazioni dell'utente che sto analizzando
    userInteraction = find(interactions(:,1) == user_id(j));
    job = interactions(userInteraction,2);
    %job not interacted with
    %jobInteracted = find(not(ismember(interactions(:,1),userInteraction(:,1))));
    jobInteracted = intersect(job(:,1), itemprofiles(:,1));
    jobNotInteracted = setdiff(itemprofiles(:,1), jobInteracted(:,1));
    %substituing item profiles with M
    if(size(jobInteracted,1)>25)
        jobIdsToTest = intersect(jobNotInteracted(:,1), itemprofiles(find(itemprofiles(:,11)==1),1));
        rowsInIcm = cell2mat(values(itemMap, num2cell(jobIdsToTest)));
        jobToTest = icm(rowsInIcm,:).';
        randomToTest = randi(size(jobToTest,1),9999,1);
        finalJobToTest = jobToTest(:,randomToTest);
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
        A(1:1, 1:size(jobInteracted,1)) = -1; 
        target = horzcat(target, A);
        [net] = train(net, full(trainingSet), target);
        outcomes = sim(net, full(finalJobToTest));
        [Y, I] = sort(outcomes,'descend');
        I = I(1:5);
        chosenIds = jobIdsToTest(randomToTest).';
        out(j,:) = [user_id(j) chosenIds(I)];
    else
        userRegion = usercountries(find(usercountries(:,1) == user_id(j)),2);
        out(j,:) = [user_id(j) mostPopularPerRegion(userRegion, jobNotInteracted).'];
        
    end
end
