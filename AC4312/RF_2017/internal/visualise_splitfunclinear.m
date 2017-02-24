function visualise_splitfunclinear(idx_best,data,a,b,ig_best,iter,index) % Draw the split line
r = [min(data(:,index(1))) max(data(:,index(1)))]; % Data range

subplot(2,2,1);

if (size(data,2)>4)
y1 = a*r(1) + b;
y2 = a*r(2) + b;

 plot([r(1) r(2)],[y1 y2],'r');
    
plot(data(~idx_best,index(1)), data(~idx_best,index(2)), '*', 'MarkerEdgeColor', [.8 .6 .6], 'MarkerSize', 5);
hold on;
plot(data(idx_best,index(1)), data(idx_best,index(2)), '+', 'MarkerEdgeColor', [.6 .6 .8], 'MarkerSize', 5);

else
plot(data(~idx_best,index(1)), data(~idx_best,index(2)), '*', 'MarkerEdgeColor', [.8 .6 .6], 'MarkerSize', 10);
hold on;
plot(data(idx_best,index(1)), data(idx_best,index(2)), '+', 'MarkerEdgeColor', [.6 .6 .8], 'MarkerSize', 10);
hold on;
plot(data(data(:,end)==1,index(1)), data(data(:,end)==1,index(2)), 'o', 'MarkerFaceColor', [.9 .3 .3], 'MarkerEdgeColor','k');
hold on;
plot(data(data(:,end)==2,index(1)), data(data(:,end)==2,index(2)), 'o', 'MarkerFaceColor', [.3 .9 .3], 'MarkerEdgeColor','k');
hold on;
plot(data(data(:,end)==3,index(1)), data(data(:,end)==3,index(2)), 'o', 'MarkerFaceColor', [.3 .3 .9], 'MarkerEdgeColor','k');
axis([-1.5 1.5 -1.5 1.5]);
r = [-1.5 1.5]; 
y1 = a*r(1) + b;
y2 = a*r(2) + b;

 plot([r(1) r(2)],[y1 y2],'r');
end

if ~iter
    title(sprintf('BEST Split [%i] and [%i] . IG = %4.2f',index(1),index(2),ig_best));
else
    title(sprintf('Trial %i - Split [%i] and [%i]. IG = %4.2f',iter,index(1),index(2),ig_best));
end

xlabel(strcat('feature ', num2str(index(1))));
ylabel(strcat('feature ', num2str(index(2))));

% axis([min(data(:,index(1))) max(data(:,index(1))) min(data(:,index(2))) max(data(:,index(2)))]);
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