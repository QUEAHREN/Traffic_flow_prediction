data = xlsread("Data.xlsx");
t = 30;

RMSE = zeros(10,1);
for k = 1:10
    [~, ~, RMSE(k)] = Model_KNN(data, t, k, 0);
end

[minvalue, idx_min] = min(RMSE);
Model_KNN(data, t, idx_min, 1);