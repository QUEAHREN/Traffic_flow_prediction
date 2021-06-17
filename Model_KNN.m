function [] = Model_KNN(data, t)

    [r, ~] = size(data);
    ovec = zeros(r,3);
    vec = zeros(r,3);
    pvec = zeros(24,3);
    for i = 1:r
        y(i) = i;
        if i == 1
            ovec(i,1) = data(i, 3);
            ovec(i,2) = data(i+1, 3);
            ovec(i,3) = data(i, 2);
            continue;
        end
        if i == r
            ovec(i,1) = data(i-1, 3);
            ovec(i,2) = data(i, 3);
            ovec(i,3) = data(i, 2);
            break;
        end
        ovec(i,1) = data(i-1, 3);
        ovec(i,2) = data(i+1, 3);
        ovec(i,3) = data(i, 2);

    end
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

        Mdl = fitcknn(vec,y,'NumNeighbors',2);  
        Class = predict(Mdl,pvec(i,:));
        newdata(i) = data(Class, 3); 

    end

    t0 = 0:1:23;
    plot(t0, data((1+(t-1) *24):t*24,3),'.b--', 'markersize', 10);
    hold on;
    plot(t0, newdata(1:24),'.r--', 'markersize', 10);
    hold on;

end

