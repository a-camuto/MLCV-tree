% Jack's main file

%% Load data
clear; 
init;
[data_train, data_test] = getData('Toy_Spiral');  
 
%% Split first node
T = 4;
D = 2;

param.num = T;
param.depth = D;
param.splitNum = 3;
param.split = 'Axis Aligned';

figure(1)
plot_toydata(data_train);
trees = growTrees(data_train,param);
for t = 1:T
    idx = trees(t).node.idx;
    for i = 1:length(idx)
        data_t(i,:) = data_train(idx(i),:);
    end
    figure(2)
    clf
    plot_toydata(data_t)
%     figure(3)
%     clf
%     for L = 1:9
%         try
%         subplot(3,3,L);
%         bar(trees(1).leaf(L).prob);
%         axis([0.5 3.5 0 1]);
%         end
%     end
    pause
end



%% Evaluate novel data points
% grab data points (these are the guideline points - so change?)
test_point = [-.5 -.7; .4 .3; -.7 .4; .5 -.5];
for n=1:4
    leaves = testTrees([test_point(n,:) 0],trees);
    % average the class distributions of leaf nodes of all trees
    p_rf = trees(1).prob(leaves,:);
    p_rf_sum = sum(p_rf)/length(trees);
end

%% Q3
[data_train,data_test]=getData('Caltech');
