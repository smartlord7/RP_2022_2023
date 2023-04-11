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
data = zscore(data);

colARM = find(col_names == "ARM") - 2;
colPRM = find(col_names == "PRM") - 2;
data.X = data.X([colARM, colPRM], :);
prm = data.X(2, :);
arm = data.X(1, :);
idxARMw1 = find(data.y == 1);
idxARMw2 = find(data.y == 2);
ARMw1 = arm(:, idxARMw1);
ARMw2 = arm(:, idxARMw2);

figure;
histfit(ARMw1);
hold on;
histfit(ARMw2);
hold off;

data1 = data.X(:, find(data.y == 1));
data2 = data.X(:, find(data.y == 2));
m1 = mean(data1, 2);
g1 =  @(x) (m1') * x - 0.5 * (m1') * m1;
m2 = mean(data2, 2);
g2 =  @(x) (m2') * x - 0.5 * (m2') * m2;

g1Val = g1(data1);
g2Val = g2(data1);
d = g1Val - g2Val;
acc1 = size(find(d > 0), 2);
acc1 / size(data1, 2) * 100

g1Val = g1(data2);
g2Val = g2(data2);
d = g1Val - g2Val;
acc2 = size(find(d < 0), 2);
acc2 / size(data2, 2) * 100

cov1 = cov(data1');
cov2 = cov(data2');
g1 =  @(x) (inv(cov1)) * m1 * x' - 0.5 * m1 * cov1 * m1;
g2 =  @(x) (inv(cov2)) * m2 * x' - 0.5 * m2 * cov2 * m2;

g1Val = g1(data2);
g2Val = g2(data2);
d = g1Val - g2Val;
acc2 = size(find(d < 0), 2);
acc2 / size(data2, 2) * 100




