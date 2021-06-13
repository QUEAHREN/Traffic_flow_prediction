function [A,Sgm2] = Model_AR (x,P)

%  x   - �������ݣ�������
%  P   - AR ����,����
%  A   - AR ϵ��[a1 a2 ...aP]��������;
% Sgm2 - ����
A  = zeros(1,P);  % ��ʼ����������������
Rx = Rxx(x,P);    % ����ع��ƣ�size = P+1

% p = 1 ʱ���Yule-Walker���̽�,ע�⣬MATLAB�±��1��ʼ
A(1) = - Rx(1+1)/Rx(0+1);
Sgm2  = Rx(0+1)*(1 - A(1)^2);

% p = 1->P ʱ��ĵ���,ע�⣬MATLAB�±��1��ʼ
for p = 1:P-1
    k = 1:p;
    K = -(Rx((p+1)+1) + A(k)*Rx((p+1-k)+1))/Sgm2;
    Sgm2 = Sgm2 * (1 - K*K);
    
    A(k) = A(k) + K * A(p+1-k);
    A(p+1) = K;
end