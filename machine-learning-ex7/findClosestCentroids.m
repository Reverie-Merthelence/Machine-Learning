function idx = findClosestCentroids(X, centroids)
%FINDCLOSESTCENTROIDS computes the centroid memberships for every example
%   idx = FINDCLOSESTCENTROIDS (X, centroids) returns the closest centroids
%   in idx for a dataset X where each row is a single example. idx = m x 1 
%   vector of centroid assignments (i.e. each entry in range [1..K])
%

% Set K
K = size(centroids, 1);

% You need to return the following variables correctly.
idx = zeros(size(X,1), 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Go over every example, find its closest centroid, and store
%               the index inside idx at the appropriate location.
%               Concretely, idx(i) should contain the index of the centroid
%               closest to example i. Hence, it should be a value in the 
%               range 1..K
%
% Note: You can use a for-loop over the examples to compute this.
%


for i = 1:size(X,1)
  mincost=100000; %mincost用来存储最小的两个向量差的模
  J=0;%J存储了最小的模的centroids序号
  for j = 1:K
    if mincost > norm(X(i,:)-centroids(j,:)) %norm计算两个向量差值的模。
      mincost = norm(X(i,:)-centroids(j,:));
      J = j;
    endif
  endfor
  idx(i)=J;





% =============================================================

end

