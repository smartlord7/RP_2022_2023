PATH_DATA = "data/";
EXTENSION_DATA = ".mat";
PATH_TRN_DATA = PATH_DATA + "riply_trn" + EXTENSION_DATA;
PATH_TST_DATA = PATH_DATA + "riply_tst" + EXTENSION_DATA;

trn_data = load(PATH_TRN_DATA);
trn_data = to_bin_classification(trn_data, 2);
model = mlcgmm(trn_data);

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

gauss_model = mlcgmm(trn_data);
quad_model = bayesdf(gauss_model);

figure;
ppatterns(trn_data); % scatter data
hold on;
pboundary(quad_model); % gaussian decision boundary

y_pred_trn = quadclass(trn_data.X, quad_model); % train the bayesian classifier
y_pred_trn = y_pred_trn - 1;

[mse_trn, accuracy_trn, specificity_trn, sensitivity_trn, f_measure_trn] = eval_classifier(y_pred_trn, trn_data.y, "confusion_train.png");
text(-1.4,1, sprintf(['Accuracy = %.2f%%\n' ...
    'MSE:  = %.2f%%\n' ...
    'Specificity = %.2f%%\n' ...
    'Sensitivity = %.2f%%\n' ...
    'F-measure = %.2f%%\n'], mse_trn * 100, accuracy_trn * 100, specificity_trn * 100, sensitivity_trn * 100, f_measure_trn * 100));

tst_data = load(PATH_TST_DATA); % test the bayesian classifier
tst_data = to_bin_classification(tst_data, 2);

figure;
ppatterns(tst_data);
pboundary(quad_model);

[mse_tst, accuracy_tst, specificity_tst, sensitivity_tst, f_measure_tst] = eval_classifier(y_pred_tst, tst_data.y, "confusion_test.png");
text(-1.4,1, sprintf(['Accuracy = %.2f%%\n' ...
    'MSE:  = %.2f%%\n' ...
    'Specificity = %.2f%%\n' ...
    'Sensitivity = %.2f%%\n' ...
    'F-measure = %.2f%%\n'], accuracy_tst * 100, mse_tst * 100, specificity_tst * 100, sensitivity_tst * 100, f_measure_tst * 100));
y_pred_tst = quadclass(tst_data.X, quad_model);
y_pred_tst = y_pred_tst - 1;

