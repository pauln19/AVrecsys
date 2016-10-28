function [s] = computeSimilarity(v1, v2, h)

%dot product
num = dot(v1,v2);

%product between norms plus shrink
den = norm(v1) * norm(v2) + h;

s = num/den;

end