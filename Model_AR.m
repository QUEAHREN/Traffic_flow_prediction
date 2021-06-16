function [A, sigma2, N] = Model_AR (x, p)
    [N,~] = size(x);
    Y = x(p+1:N, 1);
    for i = p:-1:1
        X(:,p-i+1) = x(i:N-p+i-1, 1);
    end
    A = inv(X'*X)*X'*Y;
    sigma2 = ((Y - X*A)'*(Y - X*A))./(N - p);

end