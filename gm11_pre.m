data = xlsread("Data.xlsx");

set(0,'defaultfigurecolor','w');
% for j = 1:24
%     for i = 1:31
%        x0(i,1) =  data(j + (i-1)*24, 3);
%        t(i, 1) = i;
%     end
%                                                                                                                                                                                           
%     x_pre = GM11(x0);
%     plot(t, x0, '*',t, x_pre, 'r--');
%     xlabel('时间(天)');
%     ylabel('客流量');
%     subplot(4, 6, j)
% end
x1 = zeros(31,1);
for j = 5:6
    for i = 1:31
       x0(i,1) =  data(j + (i-1)*24, 3);
       t(i, 1) = i;
    end
    
    x_pre(j, :) = Model_AR(x0, 5);
    X0 = x0(1:5, 1);
    x1(1:5, 1) = x0(1:5, 1);
    x1(6:31,1) =  x_pre(6:31, :) * X0;
    plot(t, x0, '*',t, x1, 'r--');
    subplot(4, 6, j)
end

