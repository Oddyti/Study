function [x_train, y_train, x_test, y_test] = train_test_split(data, k)
    [m,n] = size(data);
    idx = randperm(n);
    x_train= data(1:m-1,idx(1:floor(n*k)));
    y_train = data(m, idx(1:floor(n*k)));
    x_test= data(1:m-1,idx(floor(n*k)+1:end));
    y_test = data(m, idx(floor(n*k)+1:end));
end
