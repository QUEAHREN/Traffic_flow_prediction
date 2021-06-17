function [A, sigma2, N] = Model_AR (x, p)

    [N,~] = size(x);
    %预处理
    Y = x(p+1:N, 1);
    for i = p:-1:1
        X(:,p-i+1) = x(i:N-p+i-1, 1);
    end
    
    %参数a的最小二乘估计
    A = inv(X'*X)*X'*Y;
    %误差方差的最小二乘估计
    sigma2 = ((Y - X*A)'*(Y - X*A))./(N - p);

end