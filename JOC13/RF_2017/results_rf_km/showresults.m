clearvars
%% K-means surface plots
km1 = load('results_km1.mat');
figure(1)
km_surf(km1.results_km);
km2 = load('results_km2.mat');
figure(2)
km_surf(km2.results_km);
%% RF surface plots
rf1 = load('results_rf1.mat');
rf_surf(rf1.results_rf);
rf2 = load('results_rf2.mat');
rf_surf(rf2.results_rf);


