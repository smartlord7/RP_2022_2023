EXTENSION_MAT = ".mat";
PATH_DATA = "data/";
PATH_ARTIFICIAL_DATA = PATH_DATA + "artificial" + EXTENSION_MAT;

fileData = load(PATH_ARTIFICIAL_DATA);
x = fileData.artificial;
data = struct;
data.X = x';
data.y = [];
data.dim = size(x, 2);
data.num_data = size(x, 1);

normData = zscore(data);
nx = normData.X;

figure;
title('Original/Normalized data')
xlabel('Feature 1');
ylabel('Feature 2');
zlabel('Feature 3');
plot3(x(:, 1), x(:, 2), x(:, 3), 'o');
hold on;
plot3(nx(:, 1), nx(:, 2), nx(:, 3), 'x');
hold off;

pcaModel = pca(normData.X, 2);
eigenValues = pcaModel.eigval;
eigenVectors = pcaModel.W;

proj = linproj(nx, pcaModel)';
figure;
plot(proj(:, 1), proj(:, 2), 'o');

pcaModel2 = pca(normData.X, 1);
eigenValues2 = pcaModel2.eigval;
eigenVectors2 = pcaModel2.W;

proj2 = linproj(nx, pcaModel2)';
figure;
plot(proj2(:, 1), 'o');



