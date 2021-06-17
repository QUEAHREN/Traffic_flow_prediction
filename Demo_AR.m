data = xlsread("Data.xlsx");

times = 0;  %��¼��ִ���
h = 7;
for j = h:h+1
    for i = 1:31
       x0(i,1) =  data(j + (i-1)*24, 3);
       t(i, 1) = i;
    end
    while(1)
        %��������ƽ���Լ���
        h_adf = adftest(x0);
        h_kpss = kpsstest(x0);
        %������ͨ��
        if h_adf == 1&&h_kpss == 0
            break;
        %�����ִ�����������
        else         
            x0 = diff(x0);
            times = times + 1;
        end
    end
    
    %��Ҷ˹��Ϣ׼���ģ�Ͷ���
    for p = 1:10
        [A, sigma2, N] = Model_AR(x0, p);
        BIC(p) = log(sigma2) + ((p+1)*log(N))./N;
    end
    [minvalue,idx_min] = min(BIC);
    p = idx_min;
    
    %����Ԥ�⣬p��AR�����Ʋ���
    [A, sigma2, N] = Model_AR(x0, p);
    x1 = x0(1:p,1);
    t = t(1:size(x0),1);
    
    %����Ԥ��ֵ
    for i = p+1:size(x0)
       x1(i,1) =  A'*x0(i-p:i-1,1);
    end
    
    %ͼ�����
    title(num2str(j-2) + ":00 "+num2str(p) + "��AR ƽ���Դ��������" + num2str(times) + "�ײ��");
    subplot(2,1,j-h+1);
    
    plot(t, x0, '.b--', 'markersize', 10);
    hold on;
    plot(t, x1, '.r--', 'markersize', 10);
    legend("ԭʼֵ","Ԥ��ֵ");
    xlabel('ʱ��(��)');
    ylabel('������');
    
end
title( "7:00 "+num2str(p) + "��AR ƽ���Դ��������" + num2str(times) + "�ײ��");