%prendo le interazioni di un utente dummy che sarebbe l'utente con più
%interazioni

userInteraction = find(interactions(:,1) == 1210107);
job = interactions(userInteraction,2);
%job not interacted with
%jobInteracted = find(not(ismember(interactions(:,1),userInteraction(:,1))));
jobInteracted = intersect(job(:,1), M(:,1));
jobNotInteracted = setdiff(M(:,1), jobInteracted(:,1));
random = randi(167499, 500, 1);
target = zeros(size(jobInteracted,1)+500,1);
%index = find(jobInteracted(:,1) == M(:,1));
%trainingSet = sparse(size(jobInteracted,1) + 500, 45110);
trainingSet = zeros(size(jobInteracted,1)+500, 45110);
for i = 1:size(jobInteracted) 
   row = full(icm(find(jobInteracted(i,1) == M(:,1)),2:end));
   trainingSet(i,:) = row;
   %trainingSet(i,:) = icm(find(jobInteracted(i,1) == M(:,1)),:);
   target(i) = interactions(find(jobInteracted(i,1) == M(:,1)),3);
end
j =  int16(1);
for i=size(jobInteracted):size(jobInteracted)+499
     trainingSet(i) = icm(random(j));
     target(i) = -1;
      j= j+1
end