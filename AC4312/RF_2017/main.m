%% Load data
init;
[data_train, data_test] = getData('Toy_Spiral');

%% Bagging
T=4; % number of data subsets
replacement=true;
S_t=bagging(T,data_train,replacement,20);


for i= 1:T
    figure
plot_toydata(S_t(:,:,i));
end 
