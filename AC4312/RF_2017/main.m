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
param.split = 'Linear';     % Currently support 'information gain' only

for i= 1:T
    figure
plot_toydata(S_t(:,:,i)); 
trees(i) = growTrees(S_t(:,:,i),param);
% trees(i) = growTrees(data_train,param);

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

test_point = [-.5 -.7; .4 .3; -.7 .4; .5 -.5];
for n=1:4
    leaves = testTrees([test_point(n,:) 0],trees);
    % average the class distributions of leaf nodes of all trees
    p_rf = trees(1).prob(leaves,:);
    p_rf_sum = sum(p_rf)/length(trees);
end




%%%%%%%%%%%%%%%%%%%%%%
% Train Random Forest

% Grow all trees
