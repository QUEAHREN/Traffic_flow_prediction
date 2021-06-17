
data = xlsread("Data.xlsx");
t = 31;
    [r, ~] = size(data);
    ovec = zeros(r,3);
    vec = zeros(r,3);
    pvec = zeros(24,3);
    y = zeros(r, 1);
    
    %读取除第t天外的历史数据交通环境构成数据库
    j = 1;
    for i = 1:r
        if i >= 1+(t-1)*24&&i<=t*24
            continue;
        end
        y(j) = i;
        if i == 1
            ovec(j,1) = data(i, 3);
            ovec(j,2) = data(i+1, 3);
            ovec(j,3) = data(i, 2);
            j = j + 1;
            continue;
        end
        if i == r
            ovec(j,1) = data(i-1, 3);
            ovec(j,2) = data(i, 3);
            ovec(j,3) = data(i, 2);
            break;
        end
        ovec(j,1) = data(i-1, 3);
        ovec(j,2) = data(i+1, 3);
        ovec(j,3) = data(i, 2);
        j = j + 1;
    end
    
    %归一化处理
    for i = 1:3
        vec(:,i) = (ovec(:,i) - min(ovec(:,i)))/(max(ovec(:,i)) - min(ovec(:,i)));
    end

    for i = 1+(t-1)*24:t*24
        if i == t*24
            pvec(i-(t-1)*24, 1) = data(i-1, 3);
            pvec(i-(t-1)*24, 2) = data(i-1, 3);
            pvec(i-(t-1)*24, 3) = data(i, 2);
            continue;
        end
        pvec(i-(t-1)*24,1) = data(i-1, 3);
        pvec(i-(t-1)*24,2) = data(i+1, 3);
        pvec(i-(t-1)*24,3) = data(i, 2);
    end

    for i = 1:3
        pvec(:,i) = (pvec(:,i) - min(ovec(:,i)))/(max(ovec(:,i)) - min(ovec(:,i)));
    end
    
    for i = 1:24

        Mdl = fitcknn(vec,y,'NumNeighbors',1);  
        Class = predict(Mdl,pvec(i,:));
        newdata(i) = data(Class, 3); 

    end

    t0 = 0:1:23;
    plot(t0, data((1+(t-1) *24):t*24,3),'.b--', 'markersize', 10);
    hold on;
    plot(t0, newdata(1:24),'.r--', 'markersize', 10);
    hold on;



