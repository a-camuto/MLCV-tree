%% Load data
init;
[data_train, data_test] = getData('Toy_Spiral');

%% Bagging
T=4; % number of data subsets
n_t=20
replacement=true;
%S_t=bagging(T,data_train,replacement,n_t);
S_t = data_train

param.num = 1;         % Number of trees
param.depth = 2;        % trees depth
param.splitNum = 1;     % Number of split functions to try
param.split = 'none';     % Currently support 'information gain' only
%% Growing trees
for i= 1:T
    
    figure
    plot_toydata(S_t(:,:,i));
    trees(i) = growTrees(S_t(:,:,i),param);
    idx = trees(1).node(2).idx;
    NS_t = zeros(length(idx),size(S_t,2));
    for j = 1:length(idx)
        NS_t(j,:)= S_t(idx(j),:,i);
    end
    figure
    plot_toydata(NS_t)
end 