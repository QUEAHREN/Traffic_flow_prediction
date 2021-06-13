%GM(1,1)
%����¼��
data = xlsread("Data.xlsx");

set(0,'defaultfigurecolor','w');
for i = 1:31
   x(i,1) =  data(20 + (i-1)*24, 3);
   t(i, 1) = i;
end
c=5000;        %ƽ��ֵ�����ݼ����жϽ�������޸�
x0=x+c;
n=length(x0);
%�������жϣ������Ƿ��ʺ���GM(1,1)��ģ
lamda=x0(1:n-1)./x0(2:n);
range=minmax(lamda);
%�ж��Ƿ��ʺ���һ�׻�ɫģ�ͽ�ģ
if range(1,1)<exp(-(2/(n+2)))||range(1,2)>exp(2/(n+2))
    error('����û�������ɫģ�͵ķ�Χ��');
else  disp('����G(1,1)��ģ');
end
%��AGO�ۼӴ���
x1=cumsum(x0);
for i=2:n
    z(i)=0.5*(x1(i)+x1(i-1));
end
B=[-z(2:n)',ones(n-1,1)];
Y=x0(2:n)';
%����С���˷���չϵ���ͻ�ɫ������
u = pinv(B'*B)*B'*Y;
forecast1=(x1(1)-u(2)./u(1)).*exp(-u(1).*([0:n+36]))+u(2)./u(1);

for i=1:n+36
   exchange(i+1)=forecast1(i+1)-forecast1(i);
end
exchange(1)=forecast1(1);
forecast=exchange-c;  %���Ԥ���ֵ
result=round(forecast)

epsilon=x0-forecast;        %����в�
delta=abs(epsilon./x0);     %����������

%����ģ�����
Q=mean(delta)                       %������Q���鷨
C=std(epsilon,1)/std(x0,1)          %�����C���鷨��std-�����׼��
%С������P���鷨
S1=std(x0,1);
S1_new=S1*0.6745;
temp_P=find(abs(epsilon-mean(epsilon))<S1_new);
P=length(temp_P)/n


%����ԭʼ�������ɫģ��Ԥ��ֵ�ó����в�������ͼ
plot(1:n,x,'ro','markersize',11);
hold on;
plot(1:n,forecast,'k-','linewidth',2.5);
grid on;
axis tight;
ylabel('����');
legend('ԭʼ����','ģ������');


