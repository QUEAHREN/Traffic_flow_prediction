data = xlsread("Data.xlsx");

times = 0;  %记录差分次数
h = 7;
for j = h:h+1
    for i = 1:31
       x0(i,1) =  data(j + (i-1)*24, 3);
       t(i, 1) = i;
    end
    while(1)
        %白噪声、平稳性检验
        h_adf = adftest(x0);
        h_kpss = kpsstest(x0);
        %若检验通过
        if h_adf == 1&&h_kpss == 0
            break;
        %否则差分处理，继续检验
        else         
            x0 = diff(x0);
            times = times + 1;
        end
    end
    
    %贝叶斯信息准则给模型定阶
    for p = 1:10
        [A, sigma2, N] = Model_AR(x0, p);
        BIC(p) = log(sigma2) + ((p+1)*log(N))./N;
    end
    [minvalue,idx_min] = min(BIC);
    p = idx_min;
    
    %进行预测，p阶AR，估计参数
    [A, sigma2, N] = Model_AR(x0, p);
    x1 = x0(1:p,1);
    t = t(1:size(x0),1);
    
    %计算预测值
    for i = p+1:size(x0)
       x1(i,1) =  A'*x0(i-p:i-1,1);
    end
    
    %图像绘制
    title(num2str(j-2) + ":00 "+num2str(p) + "阶AR 平稳性处理进行了" + num2str(times) + "阶差分");
    subplot(2,1,j-h+1);
    
    plot(t, x0, '.b--', 'markersize', 10);
    hold on;
    plot(t, x1, '.r--', 'markersize', 10);
    legend("原始值","预测值");
    xlabel('时间(天)');
    ylabel('客流量');
    
end
title( "7:00 "+num2str(p) + "阶AR 平稳性处理进行了" + num2str(times) + "阶差分");