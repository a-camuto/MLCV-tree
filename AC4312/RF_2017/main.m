%% Load data
clear; 
init;
close all;
[data_train, data_test] = getData('Toy_Spiral');  
 
%% Bagging
T=4; % number of data subsets 
S_t=bagging(T,data_train,false,50);
figure
for i=1:T
subplot(T/2,T/2,i)
plot_toydata(S_t(:,:,i)); 
end 

figure
plot_toydata(data_train)
figure
plot_toydata(data_test)

for i=1:4
param.num = T;         % Number of trees
param.depth = 2;        % trees depth
param.splitNum = 1; 
if i==1% Number of split functions to try
param.split = 'Axis Aligned'; % Currently support 'information gain' only
elseif i==2
param.split = 'Linear'; % Currently support 'information gain' only
elseif i==3
param.split = 'Non Linear'; % Currently support 'information gain' only
else 
param.split = 'Two Pixel'; % Currently support 'information gain' only
end  
trees = growTrees(data_train,param);
figure 
for L = 1:9
try
subplot(3,3,L);
bar(trees(1).leaf(L).prob);
axis([0.5 3.5 0 1]);
end
end
end 


%% Func
for i=1:4
    for T = 2:4:10
        depth_ind = 1;
        for depth = 2:4:10
            figure_ind = 1; 
            for splitNum = 1:10:21
                param.num = T;         % Number of trees
                param.depth = depth;        % trees depth
                param.splitNum = splitNum; 
                if i==1% Number of split functions to try
                param.split = 'Axis Aligned'; % Currently support 'information gain' only
                elseif i==2
                param.split = 'Linear'; % Currently support 'information gain' only
                elseif i==3
                param.split = 'Non Linear'; % Currently support 'information gain' only
                else 
                param.split = 'Two Pixel'; % Currently support 'information gain' only
                end  
                trees = growTrees(data_train,param);
                for n=1:size(data_test,1)
                    leaves = testTrees(data_test(n,:),trees);
                    % average the class distributions of leaf nodes of all trees
                    p_rf = trees(1).prob(leaves,:);
                    p_rf_sum = sum(p_rf)/length(trees);
                    [L,predict(n,figure_ind,depth_ind)] = max(p_rf_sum); 
                end
            figure_ind = figure_ind +1; 
            end         
        depth_ind = depth_ind + 1; 
        end 
        figure    
        suptitle(strcat('Split is: ', param.split, ', T= ', num2str(T)));
        for l=1:depth_ind-1
            for j=1:figure_ind-1
                subplot(figure_ind-1,depth_ind-1,(l-1)*(depth_ind-1)+ j)
                data_test(:,3) = predict(:,j,l); 
                plot_toydatatest(data_test); 
                title(strcat('Depth :', num2str(2+(l-1)*4),', SplitNum :',num2str(1+(j-1)*10  )));
            end
        end 
        data_test(:,3) = zeros(1,size(data_test,1));
         figure_ind = 1; 
            for splitNum = 1:5:11
param.num = T;         % Number of trees
param.depth = depth;        % trees depth
param.splitNum = splitNum; 
if i==1% Number of split functions to try
param.split = 'Axis Aligned'; % Currently support 'information gain' only
elseif i==2
param.split = 'Linear'; % Currently support 'information gain' only
elseif i==3
param.split = 'Non Linear'; % Currently support 'information gain' only
else 
param.split = 'Two Pixel'; % Currently support 'information gain' only
end  
trees = growTrees(data_train,param);
for n=1:size(data_test,1)
    leaves = testTrees(data_test(n,:),trees);
    % average the class distributions of leaf nodes of all trees
    p_rf = trees(1).prob(leaves,:);
    p_rf_sum = sum(p_rf)/length(trees);
    [L,predict(n,figure_ind,depth_ind)] = max(p_rf_sum); 
end
figure_ind = figure_ind +1; 
            end 
            
    depth_ind = depth_ind + 1; 
        end 
    figure    
   suptitle(strcat('Split is: ', param.split, ', T= ', num2str(T)));

    for l=1:depth_ind-1
    for j=1:figure_ind-1
        subplot(figure_ind-1,depth_ind-1,(l-1)*(depth_ind-1)+ j)
        data_test(:,3) = predict(:,j,l); 
        plot_toydatatest(data_test); 
        title(strcat('Depth :', num2str(2+(l-1)*4),', SplitNum :',num2str(1+(j-1)*5  )));
    end
    end 
    data_test(:,3) = zeros(1,size(data_test,1));
    end 
% trees(i) = growTrees(data_train,param);

%stopping criteria == pram.depth
% test_point = [-.5 -.7; .4 .3; -.7 .4; .5 -.5];




%%%%%%%%%%%%%%%%%%%%%%
% Train Random Forest

% Grow all trees


%%%%%%%%%%%%%%%%%%%%%

%% Data 
[data_train, data_test] = getData('Caltech');

T=10; % number of data subsets 

param.num = T;         % Number of trees
param.depth = 10;        % trees depth
param.splitNum = 10;     % Number of split functions to try
param.split = 'Non Linear';

trees = growTrees(data_train,param);


for n=1:size(data_test,1)
    leaves = testTrees([data_test(n,:) 0],trees);
    % average the class distributions of leaf nodes of all trees
    p_rf = trees(1).prob(leaves,:);
    p_rf_sum(n,:) = sum(p_rf)/length(trees);
    [A, class(n)] = max(p_rf_sum(n,:)); 
end
%% Kmeans codebook 


for book_size = 128:128:256
[data_train,data_test]=getData('Caltech','kmeans',book_size);
for i=1:4
    for T = 2:4:10 % Trees to try
        depth_ind = 1;
        
        for depth = 2:4:10 % Depths to try
            figure_ind = 1; 
            for splitNum = 1:10:21 % Number of split functions to try
                param.num = T; % Number of trees
                param.depth = depth; % Depth of trees
                param.splitNum = splitNum; 
                if i==1
                param.split = 'Axis Aligned';
                elseif i==2
                param.split = 'Linear';
                elseif i==3
                param.split = 'Non Linear';
                else 
                param.split = 'Two Pixel';
                end  
                trees = growTrees(data_train,param);
                for n=1:size(data_test,1)
                    leaves = testTrees(data_test(n,:),trees);
                    % average the class distributions of leaf nodes of all trees
                    p_rf = trees(1).prob(leaves,:);
                    p_rf_sum = sum(p_rf)/length(trees);
                    [L,predict(n,figure_ind,depth_ind)] = max(p_rf_sum); 
                end
                formatted_labels = zeros(size(data_test,1),10); 
                formatted_predictions = zeros(size(data_test,1),10); 
                for non_zero = 1:size(data_test,1)
                    formatted_labels(non_zero,data_test(non_zero,size(data_test,2))) = 1; 
                    formatted_predictions(non_zero,predict(non_zero,figure_ind,depth_ind)) = 1; 
                end 
                figure
                plotconfusion(transpose(formatted_labels),transpose(formatted_predictions)); 
               title(strcat('Codebook of size:',num2str(book_size), ' Split is: ', param.split, ', T= ', num2str(T), ' Depth: ', num2str(depth),' SplitNum: ',num2str(splitNum)));
                
            figure_ind = figure_ind +1; 
            end         
        depth_ind = depth_ind + 1; 
        end 
    end 
end
end 

%% RF codebook
for book_size = 10:10:20
[data_train,data_test]=getData('Caltech','rf',book_size);
for i=1:4
    for T = 2:10:20 % Trees to try
        depth_ind = 1;
        for depth = 2:10:20 % Depths to try
            figure_ind = 1; 
            for splitNum = 1:10:40 % Number of split functions to try
                param.num = T; % Number of trees
                param.depth = depth; % Depth of trees
                param.splitNum = splitNum; 
                if i==1
                param.split = 'Axis Aligned';
                elseif i==2
                param.split = 'Linear';
                elseif i==3
                param.split = 'Non Linear';
                else 
                param.split = 'Two Pixel';
                end  
                trees = growTrees(data_train,param);
                for n=1:size(data_test,1)
                    leaves = testTrees(data_test(n,:),trees);
                    % average the class distributions of leaf nodes of all trees
                    p_rf = trees(1).prob(leaves,:);
                    p_rf_sum = sum(p_rf)/length(trees);
                    [L,predict(n,figure_ind,depth_ind)] = max(p_rf_sum); 
                end
                formatted_labels = zeros(size(data_test,1),10); 
                formatted_predictions = zeros(size(data_test,1),10); 
                for non_zero = 1:size(data_test,1)
                    formatted_labels(non_zero,data_test(non_zero,size(data_test,2))) = 1; 
                    formatted_predictions(non_zero,predict(non_zero,figure_ind,depth_ind)) = 1; 
                end 
                figure
                plotconfusion(transpose(formatted_labels),transpose(formatted_predictions)); 
               title(strcat('Codebook Forest of size:',num2str(book_size), ' Split is: ', param.split, ', T= ', num2str(T), ' Depth: ', num2str(depth),' SplitNum: ',num2str(splitNum)));
                
            figure_ind = figure_ind +1; 
            end         
        depth_ind = depth_ind + 1; 
        end 
    end 
end
end 





