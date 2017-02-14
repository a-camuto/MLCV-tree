% Jack's main file

%% Load data
clear; 
init;
[data_train, data_test] = getData('Toy_Spiral');  
 
%% Grow trees

param.num = 4;
param.depth = 2;
param.splitNum = 3;
param.split = 'IG';

plot_toydata(data_train);
trees = growTrees(data_train,param);

