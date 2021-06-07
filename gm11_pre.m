data = xlsread("Data.xlsx");

set(0,'defaultfigurecolor','w');
for i = 1:31
   x0(i,1) =  data(20 + (i-1)*24, 3);
   t(i, 1) = i;
end
x_pre = GM11(x0);
plot(t, x0, '*',t, x_pre, 'r--');
xlabel('时间(年)');
ylabel('幅度');
title('GM11预测模型');
legend('原始数据','预测数据');