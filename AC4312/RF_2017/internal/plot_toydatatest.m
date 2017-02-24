function  plot_toydatatest( data )
plot(data(data(:,end)==1,1), data(data(:,end)==1,2), '.', 'MarkerFaceColor', [.9 .5 .5], 'MarkerEdgeColor',[.9 .5 .5]);
hold on;
plot(data(data(:,end)==2,1), data(data(:,end)==2,2), '.', 'MarkerFaceColor', [.5 .9 .5], 'MarkerEdgeColor',[.5 .9 .5]);
hold on;
plot(data(data(:,end)==3,1), data(data(:,end)==3,2), '.', 'MarkerFaceColor', [.5 .5 .9], 'MarkerEdgeColor',[.5 .5 .9]);
axis([-1.5 1.5 -1.5 1.5]);
end