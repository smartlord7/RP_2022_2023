DIRECTORY_DATA = "data/";
EXTENSION_XLS = ".XLS";
PATH_DATASET_CORK_STOPPERS = DIRECTORY_DATA + "CORK_STOPPERS" + EXTENSION_XLS;
EXCEL_SEPARATOR_DATA = "Data";

[xls_data, col_names] = xlsread(PATH_DATASET_CORK_STOPPERS, EXCEL_SEPARATOR_DATA);

data = struct;
data.X = xls_data(:,3:end)';
data.y = xls_data(:,2)';
data.dim = size(data.X, 1);
data.num_data = size(data.X, 2);
data.name = "Cork Stoppers Dataset";


figure;
ppatterns(data);
xlabel(col_names(3));
ylabel(col_names(4));
zlabel(col_names(5));

data2 = data;
data2.X = data.X([6 10],:);

figure;
ppatterns(data2);
xlabel(col_names(8));
ylabel(col_names(12));

X = data2.X';
opts = statset('Display','final');
[idx, C] = kmeans(X,3,'Distance','cityblock',...
    'Replicates',5,'Options',opts);

figure;
plot(X(idx==1,1),X(idx==1,2), X(idx==1,3),'r.','MarkerSize',12)
hold on
plot(X(idx==2,1),X(idx==2,2), X(idx==2,3), 'g.','MarkerSize',12)
hold on
plot(X(idx==3,1) ,X(idx==3,2), X(idx==3,3), 'b.','MarkerSize',12)
plot(C(:,1),C(:,2), C(:,3),'kx',...
     'MarkerSize',15,'LineWidth',3) 
legend('Cluster 1','Cluster 2', 'Cluster 3', 'Centroids',...
       'Location','NW')
title 'Cluster Assignments and Centroids'
hold off
