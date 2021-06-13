function Rx = Rxx(x,P)
% x      - �Ա���
% P      - �������Ŀ
% Rxx[m] = sum(x[n]*x[n+m])
%         (n = 0->inf,m = 0->P)

N  = length(x);

sizex = size(x);
if sizex(1)==1
    % x Ϊ��������ôRxҲΪ������
    Rx = zeros(1,P+1); 
    
    for m = 0:P
        Rx(m+1) = x(m+1:N)*x(1:N-m)';
    end
    
elseif sizex(2)==1
    % x Ϊ��������ôRxҲΪ������
    Rx = zeros(P+1,1); 
    for m = 0:P
        Rx(m+1) = x(m+1:N)'*x(1:N-m);
    end
    
end