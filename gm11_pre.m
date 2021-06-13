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
for j = 1:24
    for i = 1:31
       x0(i,1) =  data(j + (i-1)*24, 3);
       t(i, 1) = i;
    end
    
    x_pre = Model_AR(x0, 5);
    plot(t, x0, '*',t, x_pre, 'r--');
    xlabel('时间(天)');
    ylabel('客流量');
    subplot(4, 6, j)
end

