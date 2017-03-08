function results = evaluate(data_test,data_train,param, book_size, plot)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
tic 
result= struct();
trees = growTrees(data_train,param);

train_time = toc; 
 for n=1:size(data_test,1)
                    leaves = testTrees(data_test(n,:),trees);
  
                    % average the class distributions of leaf nodes of all trees
                    p_rf = trees(1).prob(leaves(leaves~=0),:);
                    p_rf_sum = sum(p_rf)/length(trees);
                    [L,predict(n,figure_ind,depth_ind)] = max(p_rf_sum); 
 end
 test_time = toc - train_time;     

                formatted_labels = zeros(size(data_test,1),10); 
                formatted_predictions = zeros(size(data_test,1),10); 
                for non_zero = 1:size(data_test,1)
                formatted_labels(non_zero,data_test(non_zero,size(data_test,2))) = 1; 
                formatted_predictions(non_zero,predict(non_zero,figure_ind,depth_ind)) = 1; 
                end 
                
if(plot)    
   plotconfusion(transpose(formatted_labels),transpose(formatted_predictions));                  
   title(strcat('Codebook of size:',num2str(book_size), ' Split is: ', param.split, ', T= ', num2str(T), ' Depth: ', num2str(depth),' SplitNum: ',num2str(splitNum)));
end 

 [C,CM,IND,PER] = confusion(transpose(formatted_labels),transpose(formatted_predictions));
 results.split = param.split; 
 param.book_size = book_size; 
 results.splitNum =  param.splitNum; 
 results.num = param.num; 
 results.depth = param.depth; 
 results.accuracy = 1-C;
 results.train_time = train_time;
 results.test_time = train_time; 
%  [ i, T, depth, splitNum, 1-C, train_time, train_time];

 
       
                
end

