function [J, grad] = linearRegCostFunction(X, y, theta, lambda)
%LINEARREGCOSTFUNCTION Compute cost and gradient for regularized linear 
%regression with multiple variables
%   [J, grad] = LINEARREGCOSTFUNCTION(X, y, theta, lambda) computes the 
%   cost of using theta as the parameter for linear regression to fit the 
%   data points in X and y. Returns the cost in J and the gradient in grad

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost and gradient of regularized linear 
%               regression for a particular choice of theta.
%
%               You should set J to the cost and grad to the gradient.
%


J = 1/(2*m)*(sum ((X*theta-y).^2) + lambda * theta(2:end, :)'*theta(2:end, :));
% X=m*(n+1), theta=(n+1)*1, theta(2:end,:)指的是从第二行到最后一行

theta_col = size(theta,2); %获取theta的列数

theta_firstrowzero=[zeros(1, theta_col); theta(2:end, :)];%两层的矩阵叠加：把theta的第一行变成0
grad = 1/m* (X'*(X*theta-y) + lambda * theta_firstrowzero);
% 




% =========================================================================

grad = grad(:);

end
