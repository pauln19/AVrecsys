load('FilteredURM.mat')
x = pdist(FilteredURM, 'cosine');
y = squareform(x);
linkage = linkage(y);

T = cluster(linkage, 'maxclust', 20);
