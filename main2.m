clear;
close all;

PATH_Test_DATA = "data/Test/";
PATH_TEST_DATA = "data/test/";
EXTENSION_DATA = ".JPG";
NUM_CLASS_PEACH = 1;
NUM_CLASS_ORANGE = 2;
NUM_CLASS_APPLE = 3;
NUM_CLASS_STRAWBERRY = 4;
CLASSES = [NUM_CLASS_PEACH NUM_CLASS_ORANGE NUM_CLASS_APPLE NUM_CLASS_STRAWBERRY];
CLASSES_LABELS = ["Peach", "Orange", "Apple", "Strawberry"];
CLASSES_INFO = ["Peach" PATH_Test_DATA + "PEACHES/" PATH_TEST_DATA + "PEACHES/";
           "Orange" PATH_Test_DATA + "ORANGES/" PATH_TEST_DATA + "ORANGES/";
           "Apple" PATH_Test_DATA + "APPLES/" PATH_TEST_DATA + "APPLES/"
           "Strawberry" PATH_Test_DATA + "STRAWBERRIES/" PATH_TEST_DATA + "STRAWBERRIES/"];


peachesTest = readImages(CLASSES_INFO(NUM_CLASS_PEACH, 2), EXTENSION_DATA);
peaches_y = ones(size(peachesTest, 1), 1) * NUM_CLASS_PEACH;
orangesTest = readImages(CLASSES_INFO(NUM_CLASS_ORANGE, 2), EXTENSION_DATA);
oranges_y = ones(size(orangesTest, 1), 1) * NUM_CLASS_ORANGE;
applesTest = readImages(CLASSES_INFO(NUM_CLASS_APPLE, 2), EXTENSION_DATA);
apples_y = ones(size(applesTest, 1), 1) * NUM_CLASS_APPLE;
strawberriesTest = readImages(CLASSES_INFO(NUM_CLASS_STRAWBERRY, 2), EXTENSION_DATA);
strawberries_y = ones(size(strawberriesTest, 1), 1) * NUM_CLASS_STRAWBERRY;
trn_data = struct;
trn_data.X = [peachesTest; orangesTest; applesTest; strawberriesTest]';
trn_data.X = trn_data.X([1, 7], :);
trn_data.y = [peaches_y; oranges_y; apples_y; strawberries_y]';
trn_data.num_data = size(trn_data.X, 2);
trn_data.dim = size(trn_data.X, 1);


model = mlcgmm(trn_data);

figure;
ppatterns(trn_data); % scatter data
hold on;

gauss_model = mlcgmm(trn_data);
quad_model = bayesdf(gauss_model);

figure;
ppatterns(trn_data); % scatter data
hold on;
pgauss(model); % gaussian contour
hold on;

figure;
ppatterns(trn_data); % scatter data
hold on;
pgmm(model); % gaussian mixture model

figure;
ppatterns(trn_data); % scatter data
hold on;
pgmm(model, {'visual', 'surf'}); % gaussian mixture model

figure;
ppatterns(trn_data); % scatter data
hold on;
pboundary(quad_model); % gaussian decision boundary

y = trn_data.y;
y_pred_trn = quadclass(trn_data.X, quad_model); % Test the bayesian classifier
error = cerror(y, y_pred_trn);
fprintf("Test error: %.3f%%", error * 100);
hold off;

peachesTest = readImages(CLASSES_INFO(NUM_CLASS_PEACH, 3), EXTENSION_DATA);
peaches_y = ones(size(peachesTest, 1), 1) * NUM_CLASS_PEACH;
orangesTest = readImages(CLASSES_INFO(NUM_CLASS_ORANGE, 3), EXTENSION_DATA);
oranges_y = ones(size(orangesTest, 1), 1) * NUM_CLASS_ORANGE;
applesTest = readImages(CLASSES_INFO(NUM_CLASS_APPLE, 3), EXTENSION_DATA);
apples_y = ones(size(applesTest, 1), 1) * NUM_CLASS_APPLE;
strawberriesTest = readImages(CLASSES_INFO(NUM_CLASS_STRAWBERRY, 3), EXTENSION_DATA);
strawberries_y = ones(size(strawberriesTest, 1), 3) * NUM_CLASS_STRAWBERRY;
tst_data = struct;
tst_data.X = [peachesTest; orangesTest; applesTest; strawberriesTest]';
tst_data.X = tst_data.X([1, 7], :);
tst_data.y = [peaches_y; oranges_y; apples_y; strawberries_y]';
tst_data.num_data = size(tst_data.X, 2);
tst_data.dim = size(tst_data.X, 1);

y_pred_tst = quadclass(tst_data.X, quad_model);
error = cerror(y, y_pred_tst);
fprintf("Test error: %.3f%%", error * 100);
