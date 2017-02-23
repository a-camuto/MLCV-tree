function visualise_splitfuncnonlinear(idx_best,data,dim,a,b,c,ig_best,iter,index) % Draw the split line
r = [min(data(:,index(1))) max(data(:,index(1)))]; % Data range

subplot(2,2,1);

x = r(1):0.01:r(2);
y = a.*x.^2+b.*x+c; 

 plot(x,y,'r');
    
hold on;
plot(data(~idx_best,index(1)), data(~idx_best,index(2)), '*', 'MarkerEdgeColor', [.8 .6 .6], 'MarkerSize', 5);
hold on;
plot(data(idx_best,index(1)), data(idx_best,index(2)), '+', 'MarkerEdgeColor', [.6 .6 .8], 'MarkerSize', 5);

if (length(data(1,1:end))<4)
hold on;
plot(data(data(:,end)==1,1), data(data(:,end)==1,2), 'o', 'MarkerFaceColor', [.9 .3 .3], 'MarkerEdgeColor','k');
hold on;
plot(data(data(:,end)==2,1), data(data(:,end)==2,2), 'o', 'MarkerFaceColor', [.3 .9 .3], 'MarkerEdgeColor','k');
hold on;
plot(data(data(:,end)==3,1), data(data(:,end)==3,2), 'o', 'MarkerFaceColor', [.3 .3 .9], 'MarkerEdgeColor','k');
end 

xlabel(strcat('feature ', num2str(index(1))));
ylabel(strcat('feature ', num2str(index(2))));


if ~iter
    title(sprintf('BEST Split [%i]. IG = %4.2f',dim,ig_best));
else
    title(sprintf('Trial %i - Split [%i]. IG = %4.2f',iter,dim,ig_best));
end
% axis([r(1) r(2) r(1) r(2)]); 
hold off;

% histogram of base node
subplot(2,2,2);
tmp = hist(data(:,end), unique(data(:,end)));
bar(tmp);
axis([0.5 max(data(:,end))+0.5 0 max(tmp)]);
title('Class histogram of parent node');
subplot(2,2,3);
bar(hist(data(idx_best,end), unique(data(:,end))));
axis([0.5 max(data(:,end))+0.5 0 max(tmp)]);
title('Class histogram of left child node');
subplot(2,2,4);
bar(hist(data(~idx_best,end), unique(data(:,end))));
axis([0.5 max(data(:,end))+0.5 0 max(tmp)]);
title('Class histogram of right child node');
hold off;
end