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

dim = data.dim;
hAll = zeros(1, dim);
for i=(1:dim)
    [p, table, stats] = kruskalwallis(data.X(i, :), data.y, 'off');
    h = table{2, 5};
    hAll(i) = h;
end

[out, idx] = sort(hAll, 'descend');
for i=(1:dim)
    feature = string(col_names(i + 2));
    fprintf("%d - %s - H=%.4f\n", i, feature, out(i));
end

figure;
[r, p] = corrplot(data.X');
figure;
heatmap(col_names(3:end), col_names(3:end), r);

normData = zscore(data);
for i=(1:dim)
    figure;
    feature = string(col_names(i + 2));
    x = normData.X(i, :)';
    histfit(x);
    title(feature);
    h = kstest(x);
    fprintf("%s normal? %d\n", feature, h);
    figure;
    cdfplot(x)
    hold on;
    x_values = linspace(min(x),max(x));
    plot(x_values,normcdf(x_values,0,1),'r-')
    title(feature);
    legend('Empirical CDF','Standard Normal CDF','Location','best');
end


