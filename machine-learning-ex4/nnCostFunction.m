function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1)); %25*401
Theta2_grad = zeros(size(Theta2)); %10*26


% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%


% Forward Propagation:
a1 = [ones(m,1),X]; %??X??????????????X????????5000*401
a2 = sigmoid(a1*Theta1'); %a2??5000*25
a2 = [ones(m,1),a2]; %??a2??????????????a2????????5000*26
a3 = sigmoid(a2*Theta2'); %a3??5000*10

% Cost Function w/o Regularization
%????1??
c=1:num_labels; % c= [1,2,3...10]
for i=1:m
  y_recoded = (c==y(i)); %y(i)??1~10??????c==y(i)????????[0,0,1,...0]??
  J = J -(log(a3(i,:))*y_recoded(:) + log(1-a3(i,:))*(1-y_recoded(:)))/m;
end
%????2??
%c=1:num_labels;
%for i=1:m
%  Y(i,:) = (c==y(i)); % c==y(i)????????[0,0,1,...0]??????Y??5000*10
%end
%J = -(log(a3(:))' * Y(:) + log(1-(a3(:))') * (1-Y(:)))/m; %a3(:)??Y(:)????50000*1

% Cost Function w Regularization
Theta1_nobias=Theta1(:, (2:end)); %????Theta1????????????????????25*400
Theta2_nobias=Theta2(:, (2:end)); %????Theta2????????????????????10*25
RegofTheta=sum(sum(Theta1_nobias.*Theta1_nobias)) + sum(sum(Theta2_nobias.*Theta2_nobias)); 
%??Theta1_nobias??Theta2_nobias????????????????????????
J = J + lambda/(2*m)*RegofTheta;%????Regularization????Cost function




% Back Propagation w/o regularization
D1 = D2 = 0;
for t = 1:m
  a1 = [1,X(t,:)]; %??Xt????????????X????????1*401

  z2 = a1*Theta1';%theta1??25*401??????z2??1*25
  a2 = [1, sigmoid(z2)]; %??a2????????????a2????????1*26

  z3 = a2*Theta2'; %z3??1*10
  a3 = sigmoid(z3);
  
  c = 1:num_labels; % c= [1,2,3...10]
  d3 =  a3 - (c==y(t)); %y(i)??1~10??????c==y(t)????????[0,0,1,...0]??d3??1*10
  d2 = d3 * Theta2_nobias .* sigmoidGradient(z2); %d2??1*25??????????????????bias??Theta

  D1 = D1 + d2' * a1; 
  D2 = D2 + d3' * a2;  
end

Theta1_grad = D1/m; % Theta1_grad??25*401
Theta2_grad = D2/m; % Theta2_nobias??10*26


% Back Propagation w/ Regularization
Theta1_grad = Theta1_grad + lambda/m* [zeros(size(Theta1_nobias (:,1))), Theta1_nobias]; 
%zeros(size(Theta1_nobias (:,1)))??????Theta1_nobias??????????????
Theta2_grad = Theta2_grad + lambda/m* [zeros(size(Theta2_nobias (:,1))), Theta2_nobias];
% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
