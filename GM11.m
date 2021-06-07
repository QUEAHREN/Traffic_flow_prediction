function x_pre = GM11(x0)
x0 = x0(:);
n = length(x0);
x1 = cumsum(x0);
for i = 1:n-1
    G(i,1) = -(x1(i)+x1(i+1))/2;
    G(i,2) = 1;
end
Y = x0(2:end);
belta = pinv(G'*G)*G'*Y;
a = belta(1);
u = belta(2);
%predict
x_pre1 = zeros(n,1);
x_pre = x_pre1;
for k = 0:n-1
    x_pre1(k+1) = (x0(1)-u/a)*exp(-a*k)+u/a;
end
x_pre(1) = x0(1);
for k = 1:n-1
    x_pre(k+1) = x_pre1(k+1)-x_pre1(k);
end