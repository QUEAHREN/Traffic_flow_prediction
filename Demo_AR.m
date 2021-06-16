data = xlsread("Data.xlsx");

set(0,'defaultfigurecolor','w');
for j = 6:20
    for i = 1:31
       x0(i,1) =  data(j + (i-1)*24, 3);
       t(i, 1) = i;
    end
    while(1)
%         白噪声、平稳性检验
        h_adf = adftest(x0);
        h_kpss = kpsstest(x0);
        if h_adf == 1&&h_kpss == 0
            break;
        else
%             否则差分处理，继续检验
            x0 = diff(x0);
            print("1");
        end
    end
    for p = 1:10
        [A, sigma2, N] = Model_AR(x0, p);
        BIC(p) = log(sigma2) + ((p+1)*log(N))./N;
    end
    [minvalue,idx_min]=min(BIC);
  
    p = idx_min;
    [A, sigma2, N] = Model_AR(x0, p);
    x1 = x0(1:5,1);
    t = t(1:size(x0),1);
    for i = p+1:size(x0)
       x1(i,1) =  A'*x0(i-p:i-1,1);
    end
    
    subplot(5,3,j-5)
    plot(t, x0, '.b--', 'markersize', 10);
    hold on;
    plot(t, x1, '.r--', 'markersize', 10);
    legend("原始值","预测值");
    xlabel('时间(天)');
    ylabel('客流量');
    
end