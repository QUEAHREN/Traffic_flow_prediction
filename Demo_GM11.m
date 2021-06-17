data = xlsread("Data.xlsx");

for j = 8:12
    for i = 1:31
       x0(i,1) =  data(j + (i-1)*24, 3);
       t(i, 1) = i;
    end
    title(num2str(j-2) + ":00");
    subplot(5, 1, j-7)
  
    x_pre = Model_GM11(x0);
    plot(t, x0, '.b--', 'markersize', 10);
    hold on;
    plot(t, x_pre, '.r--', 'markersize', 10);
    legend("原始值","预测值");
    xlabel('时间(天)');
    ylabel('客流量');
    
end
title(num2str(11) + ":00");


