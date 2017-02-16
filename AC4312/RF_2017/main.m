%% Load data
clear; 
init;
[data_train, data_test] = getData('Toy_Spiral');  
 
%% Bagging
T=4; % number of data subsets 
replacement=true;
S_t=bagging(T,data_train,false,50);

param.num = 1;         % Number of trees
param.depth = 2;        % trees depth
param.splitNum = 8;     % Number of split functions to try
param.split = 'Non Linear';     % Currently support 'information gain' only

for i= 1:T
    figure
plot_toydata(S_t(:,:,i)); 
% trees(i) = growTrees(S_t(:,:,i),param);
trees(i) = growTrees(data_train,param);

end 

%stopping criteria == pram.depth

figure
for L = 1:9
try
subplot(3,3,L);
bar(trees(1).leaf(L).prob);
axis([0.5 3.5 0 1]);
end
end



%%%%%%%%%%%%%%%%%%%%%%
% Train Random Forest

% Grow all trees
