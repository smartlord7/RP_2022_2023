clear
close all

[xls_data,col_names]=xlsread("/data/CORK_STOPPERS.XLS", "Data");

col_names=col_names(3:end);

data.X=xls_data(:,3:end)';
data.y=xls_data(:,2)';
data.dim=size(data.X,1);
data.num_data=size(data.X,2);
data.name='Cork Stoppers dataset';

data.X =normalize(data.X, 'zscore');

rank = cell(data.dim,2);
 
for i=1:data.dim
    [p, atab,stats]=kruskalwallis(data.X(i,:), data.y, 'off');
    rank{i,1}=col_names{i};
    rank{i,2}=atab{2,5};
    %atab;
end
 
[Y,I] = sort([rank{:,2}],2,'descend');
stotal=[sprintf('K-W Feature Ranking:\n')];
%Get string with rankings
for i=1:data.dim
    stotal=[stotal,sprintf('%s-->%.2f\n', rank{I(i),1}, rank{I(i),2})];
end
%display table
disp(stotal);

% ix=randperm(data.num_data); %randomize index
% 
% ixte=ix(1:floor(numel(ix)*0.5)); %testing index
% ixtr=ix(floor(numel(ix)*0.5)+1:end); %trainingset index
% 
% data_te.X=[data.X(1,ixte); data.X(5,ixte)];
% data_te.y=data.y(1,ixte);
% data_te.dim=size(data_te.X,1);
% data_te.num_data=size(data_te.X,2);
% data_te.name='Dataset for testing';
% 
% data_tr.X = [data.X(1,ixtr); data.X(5,ixtr)];
% data_tr.y = data.y(1,ixtr);
% data_tr.dim = size(data_tr.X,1);
% data_tr.num_data = size(data_tr.X,2);
% data_tr.name = 'dataset for training';

% model = knnrule(data_tr,1);
% figure; ppatterns(data_te); pboundary(model);
% xlabel(rank{I(1),1})
% ylabel(rank{I(2),1})
% %evaluate in the testing data classifier
% ypred = knnclass(data_te.X,model);
% %text(-1.4,-1.4, sprintf('vizinhos = %d, Erro em teste=%'));
% 
% clear model
% model = knnrule(data_tr,8);
% figure; ppatterns(data_te); pboundary(model);
% xlabel(rank{I(1),1})
% ylabel(rank{I(2),1})
% %evaluate in the testing data classifier
% ypred = knnclass(data_te.X,model);
% %text(-1.4,-1.4, sprintf('vizinhos = %d, Erro em teste=%'));

err = [];
models = [];
n_run = 50;
n_k = 100;

for j=1:n_run
    
    
    ix=randperm(data.num_data); %randomize index
    ixte=ix(1:floor(numel(ix)*0.5)); %testing index
    ixtr=ix(floor(numel(ix)*0.5)+1:end); %trainingset index
    data_te.X=[data.X(1,ixte); data.X(5,ixte)];
    data_te.y=data.y(ixte);
    data_te.dim=size(data_te.X,1);
    data_te.num_data=size(data_te.X,2);
    data_te.name='Dataset for testing';
    data_tr.X=[data.X(1,ixtr); data.X(5,ixtr)];
    data_tr.y=data.y(ixtr);
    data_tr.dim=size(data_tr.X,1);
    data_tr.num_data=size(data_tr.X,2);
    data_tr.name='Dataset for testing';

    for i=1:n_k
        disp(sprintf('=========\nrun=%d\nK=%f\n===========', j,i));
        clear model
        model = knnrule(data_tr,i);
        models = [models,model];
        %figure; ppatterns(data_te); pboundary(model);
        %xlabel(rank{I(1),1})
        %ylabel(rank{I(2),1})
        %evaluate in the testing data classifier
        ypred = knnclass(data_te.X,model);
        err(j,i)=cerror(ypred,data_te.y)*100;
        plot(err(j,1:i))
        xlabel('Numero de vizinhos');
        ylabel('erro em treino');
    end
end

med_err=mean(err,1);
std_err=std(err,[],1);
figure;errorbar(1:n_k,med_err,std_err)
hold on;

xlabel('Numero de vizinhos');
ylabel('erro em teste');
ix=find(med_err==min(med_err));
hold on;
plot(ix(1), min(med_err), 'ro');

figure; ppatterns(data_te); pboundary(models(ix(1)));hold on;
xlabel('ART');
ylabel('PRM');
text(-1.4,-1.4, sprintf('vizinhos = %d, Erro em teste=%.2f%%', ix(1), min(med_err)));
title('best classifier');
