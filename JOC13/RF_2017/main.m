%% Load data
init;
[data_train, data_test] = getData('Toy_Spiral');

%% Bagging
T=4; % number of data subsets
n_t=20
replacement=true;
S_t=bagging(T,data_train,replacement,n_t);

param.num = 1;         % Number of trees
param.depth = 5;        % trees depth
param.splitNum = 3;     % Number of split functions to try
param.split = 'IG';     % Currently support 'information gain' only
%% Growing trees
for i= 1:1
    figure
    plot_toydata(S_t(:,:,i));
    trees(i) = growTrees(S_t(:,:,i),param);
    idx = trees(1).node(1).idx;
    for j = 1:length(idx)-1
        NS_t(j,:)= S_t(idx(j),:,i);
    end
    figure
    plot_toydata(NS_t(:,:,i))
end 