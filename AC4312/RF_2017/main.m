%% Load data
init;
[data_train, data_test] = getData('Toy_Spiral');

%% Bagging
T=4; % number of data subsets
replacement=true;
S_t=bagging(T,data_train,replacement,20);

param.num = 1;         % Number of trees
param.depth = 5;        % trees depth
param.splitNum = 3;     % Number of split functions to try
param.split = 'IG';     % Currently support 'information gain' only

for i= 1:T
    figure
plot_toydata(S_t(:,:,i));
trees(i) = growTrees(S_t(:,:,i),param);
end 




%%%%%%%%%%%%%%%%%%%%%%
% Train Random Forest

% Grow all trees
