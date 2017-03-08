%% Load data
clear; 
init;
close all;
[data_train, data_test] = getData('Toy_Spiral');  
 
%% Bagging
T=4; % number of data subsets 
S_t=bagging(T,data_train,true,50);
figure
subplot(T/2,T/2,1)
plot_toydata(data_train)
for i=2:T
subplot(T/2,T/2,i)
plot_toydata(S_t(:,:,i)); 
<<<<<<< HEAD
end  
plot_toydata(S_t(:,:,i));
title(strcat('Subset:',num2str(i)))
=======
title(strcat('Subset:',num2str(i)))
end 
>>>>>>> origin/master

figure
plot_toydata(data_train)
title('Training Data')
figure
plot_toydata(data_test)
title('Testing Data')

%% 
for i=1:4
    param.num = T;         % Number of trees
    param.depth = 5;        % trees depth
    param.splitNum = 5;  
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

%% Visualise data distribution 
param.num = 4;         % Number of trees
param.depth = 5;        % trees depth
param.splitNum = 1;
trees = growTrees(data_train,param);


for n=1:size(data_train,1)
                    leaves = testTrees(data_train(n,:),trees);
                    % average the class distributions of leaf nodes of all trees
                    p_rf = trees(1).prob(leaves(leaves~=0),:);
                    p_rf_sum = sum(p_rf)/length(trees);
                    [L,predict(n)] = max(p_rf_sum); 
           figure  
end 
     for L = 1:4
        try
            subplot(2,2,L);
            bar(trees(1).prob(leaves(leaves~=0),:));
            
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
                    p_rf = trees(1).prob(leaves(leaves~=0),:);
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
         
    end
    end 
% trees(i) = growTrees(data_train,param);

%stopping criteria == pram.depth
% test_point = [-.5 -.7; .4 .3; -.7 .4; .5 -.5];


%% Func 2
 for depth = 2:4:10
    for splitNum = 1:10:21
                        depth_ind = 1;
        for i=1:4
                    figure_ind = 1; 

            for T = 2:4:10
       
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
                    p_rf = trees(1).prob(leaves(leaves~=0),:);
                    p_rf_sum = sum(p_rf)/length(trees);
                    [L,predict(n,figure_ind,depth_ind)] = max(p_rf_sum); 
                end
            figure_ind = figure_ind +1; 
            end         
        depth_ind = depth_ind + 1; 
        end 
        figure    
        suptitle(strcat('Depth :', num2str(depth),', SplitNum :',num2str(splitNum)));
        for l=1:depth_ind-1
            for j=1:figure_ind-1
                subplot(depth_ind-1,figure_ind-1,(l-1)*(figure_ind-1)+ j)
                data_test(:,3) = predict(:,j,l); 
                plot_toydatatest(data_test); 
                if l==1% Number of split functions to try
                param.split = 'Axis Aligned'; % Currently support 'information gain' only
                elseif l==2
                param.split = 'Linear'; % Currently support 'information gain' only
                elseif l==3
                param.split = 'Non Linear'; % Currently support 'information gain' only
                else 
                param.split = 'Two Pixel'; % Currently support 'information gain' only
                end  
               title( strcat('Split is: ', param.split, ', T= ', num2str(2+4*(j-1))));
            end
        end 
        data_test(:,3) = zeros(1,size(data_test,1));
         
    end
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

results =[];
for book_size = 128:128:(256+128)
[data_train,data_test]=getData('Caltech','kmeans',book_size, 0, 0,0);
for i=1:4
    for T = 2:5:102 % Trees to try
        depth_ind = 1;
        
        for depth = 4:2:16 % Depths to try
            figure_ind = 1; 
            splitNum = 81;
%             for splitNum = 1:20:101 % Number of split functions to try
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
                results{end+1} = evaluate(data_test,data_train,param, book_size);

%             end         

        end 
    end 
end
end 

<<<<<<< HEAD
indices = find(results(:,5)==81); 
lesser_res = results(indices,:); 
x= lesser_res(:,3);
y= lesser_res(:,4);
z= lesser_res(:,6);

dx = 5;
dy = 2;
x_edge=[floor(min(x)):dx:ceil(max(x))];
y_edge=[floor(min(y)):dy:ceil(max(y))];
[X,Y]=meshgrid(x_edge,y_edge);
Z=griddata(x,y,z,X,Y);
surf(X,Y,Z);
colormap(parula(5));



%% RF codebook
results =[];
for book_size = 10:10:20
[data_train,data_test]=getData('Caltech','rf',book_size);
for i=1:4
    for T = 2:50:102 % Trees to try
        for depth = 2:50:102 % Depths to try
            for splitNum = 1:50:101 % Number of split functions to try
=======
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
title(strcat('Subset:',num2str(i)))
end 

figure
plot_toydata(data_train)
title('Training Data')
figure
plot_toydata(data_test)
title('Testing Data')

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
    for T = 2:50:102 % Trees to try
        depth_ind = 1;
        
        for depth = 4:4:12 % Depths to try
            figure_ind = 1; 
            for splitNum = 1:10:100 % Number of split functions to try
>>>>>>> origin/master
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
<<<<<<< HEAD
               
            results{end+1} = evaluate(data_test,data_train,param, book_size);

=======
                trees = growTrees(data_train,param);
                for n=1:size(data_test,1)
                    leaves = testTrees(data_test(n,:),trees);
                    % average the class distributions of leaf nodes of all trees
                    p_rf = trees(1).prob(leaves(leaves~=0),:);
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
>>>>>>> origin/master
            end         
        end 
    end 
end
end 

%% RF codebook
% Apply RF to 128 dimensional descriptor vectors with image category labels
% Use RF leaves as the visual vocabulary

%% Try different parameters of the RF codebook
for CB_T = 2:5:10
    depth_ind = 1;
    for CB_D = 2:5:10
        figure_ind = 1;
        for CB_S = 2:5:10
            [data_train,data_test]=getData_treeVar('Caltech','rf',CB_T,CB_D,CB_S);
            % Choose RF classifier fixed parameters
            param.num = 2;
            param.depth = 2;
            param.splitNum = 3;
            param.split = 'Axis Aligned';
            % Train random forest
            trees = growTrees(data_train,param);
            % Test random forest
            for n=1:size(data_test,1)
                leaves = testTrees(data_test(n,:),trees);
                % average the class distributions of leaf nodes of all trees
                p_rf = trees(1).prob(leaves(leaves~=0),:);
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
            title(strcat('Codebook Forest of size:',num2str(book_size), ' Split is: ', param.split, ', T= ', num2str(CB_T), ' Depth: ', num2str(CB_D),' SplitNum: ',num2str(CB_S)));
            aq1
            figure_ind = figure_ind + 1;
        end
        depth_ind = depth_ind + 1;
    end    
end

%% Try different parameters of the RF classifier

CB_T = 2;
CB_D = 2;
CB_S = 3;
[data_train,data_test]=getData_treeVar('Caltech','rf',CB_T,CB_D,CB_S);

for I=1:4
    for T = 2:50:102 % Trees to try
        depth_ind = 1;
        for D = 2:50:102 % Depths to try
            figure_ind = 1; 
            for S = 1:50:101 % Number of split functions to try
                param.num = T; % Number of trees
                param.depth = D; % Depth of trees
                param.splitNum = S;
                switch I
                    case 1
                        param.split = 'Axis Aligned';
                    case 2
                        param.split = 'Linear';
                    case 3
                        param.split = 'Non Linear';
                    case 4
                        param.split = 'Two Pixel';
                end
                trees = growTrees(data_train,param);
                for n=1:size(data_test,1)
                    leaves = testTrees(data_test(n,:),trees);
                    % average the class distributions of leaf nodes of all trees
                    p_rf = trees(1).prob(leaves(leaves~=0),:);
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
                aq1
            figure_ind = figure_ind +1; 
            end         
        depth_ind = depth_ind + 1; 
        end 
    end 
end