%GM(1,1)
%数据录入
data = xlsread("Data.xlsx");

set(0,'defaultfigurecolor','w');
for i = 1:31
   x(i,1) =  data(20 + (i-1)*24, 3);
   t(i, 1) = i;
end
c=5000;        %平移值，根据级比判断结果进行修改
x0=x+c;
n=length(x0);
%做级比判断，看看是否适合用GM(1,1)建模
lamda=x0(1:n-1)./x0(2:n);
range=minmax(lamda);
%判断是否适合用一阶灰色模型建模
if range(1,1)<exp(-(2/(n+2)))||range(1,2)>exp(2/(n+2))
    error('级比没有落入灰色模型的范围内');
else  disp('可用G(1,1)建模');
end
%做AGO累加处理
x1=cumsum(x0);
for i=2:n
    z(i)=0.5*(x1(i)+x1(i-1));
end
B=[-z(2:n)',ones(n-1,1)];
Y=x0(2:n)';
%用最小二乘法发展系数和灰色作用量
u = pinv(B'*B)*B'*Y;
forecast1=(x1(1)-u(2)./u(1)).*exp(-u(1).*([0:n+36]))+u(2)./u(1);

for i=1:n+36
   exchange(i+1)=forecast1(i+1)-forecast1(i);
end
exchange(1)=forecast1(1);
forecast=exchange-c;  %输出预测的值
result=round(forecast)

epsilon=x0-forecast;        %计算残差
delta=abs(epsilon./x0);     %计算相对误差

%检验模型误差
Q=mean(delta)                       %相对误差Q检验法
C=std(epsilon,1)/std(x0,1)          %方差比C检验法，std-计算标准差
%小误差概率P检验法
S1=std(x0,1);
S1_new=S1*0.6745;
temp_P=find(abs(epsilon-mean(epsilon))<S1_new);
P=length(temp_P)/n


%绘制原始数据与灰色模型预测值得出数列差异折线图
plot(1:n,x,'ro','markersize',11);
hold on;
plot(1:n,forecast,'k-','linewidth',2.5);
grid on;
axis tight;
ylabel('人数');
legend('原始数列','模型数列');


