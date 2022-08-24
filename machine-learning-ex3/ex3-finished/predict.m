function p = predict(Theta1, Theta2, X)
%PREDICT Predict the label of an input given a trained neural network
%   p = PREDICT(Theta1, Theta2, X) outputs the predicted label of X given the
%   trained weights of a neural network (Theta1, Theta2)

% Useful values
m = size(X, 1);
num_labels = size(Theta2, 1);

% You need to return the following variables correctly 
p = zeros(size(X, 1), 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Complete the following code to make predictions using
%               your learned neural network. You should set p to a 
%               vector containing labels between 1 to num_labels.
%
% Hint: The max function might come in useful. In particular, the max
%       function can also return the index of the max element, for more
%       information see 'help max'. If your examples are in rows, then, you
%       can use max(A, [], 2) to obtain the max for each row.
%


X=[ones(size(X, 1),1), X]; %往X左边加入一列，变成5000x401
a2=sigmoid(X*Theta1'); % 5000x25
a2=[ones(size(X, 1),1), a2]; %往a2左边加入一列，变成5000x26
a3=sigmoid(a2*Theta2'); %a3有5000x10
[maxnum, p]=max(a3,[],2); %对于每一个训练例子，都有10列。1列中的最大值的所在索引就代表是什么数字。





% =========================================================================


end
