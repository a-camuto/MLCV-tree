function codebook_confusion(CB_T,CB_D,CB_S)
fprintf(strcat('|T:',num2str(CB_T),'|D:',num2str(CB_D),'|S:',num2str(CB_S),'|\n'))
[data_train,data_test]=getData_treeVar('Caltech','rf',CB_T,CB_D,CB_S);
% Choose RF classifier fixed parameters
param.num = 10;
param.depth = 3;
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
    [~,predict(n)] = max(p_rf_sum); 
end
formatted_labels = zeros(size(data_test,1),10); 
formatted_predictions = zeros(size(data_test,1),10); 
for non_zero = 1:size(data_test,1)
    formatted_labels(non_zero,data_test(non_zero,size(data_test,2))) = 1; 
    formatted_predictions(non_zero,predict(non_zero)) = 1; 
end 
figure
plotconfusion(transpose(formatted_labels),transpose(formatted_predictions)); 
title(strcat('RF codebook trees: ', num2str(CB_T), ', depth: ', num2str(CB_D),', split number: ',num2str(CB_S)));
fprintf('Press any key to continue')
pause
end

