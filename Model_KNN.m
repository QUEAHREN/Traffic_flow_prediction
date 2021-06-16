data = xlsread("Data.xlsx");

set(0,'defaultfigurecolor','w');
for i = 1:720
    y(i) = i;
    if i == 1
        ovec(i,1) = data(i, 3);
        ovec(i,2) = data(i+1, 3);
        ovec(i,3) = data(i, 2);
        continue;
    end
    if i == 720
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

for i = 721:743
%     if i == 744
%         pvec(i-720, 1) = pvec(i-1, 3);
%         pvec(i-720, 2) = pvec(i-1, 3);
%         pvec(i-720, 3) = pvec(i, 2);
%         continue;
%     end
    pvec(i-720,1) = data(i-1, 3);
    pvec(i-720,2) = data(i+1, 3);
    pvec(i-720,3) = data(i, 2);
    
end

for i = 1:3
    pvec(:,i) = (pvec(:,i) - min(ovec(:,i)))/(max(ovec(:,i)) - min(ovec(:,i)));
end
for i = 1:23
    
    Mdl = fitcknn(vec,y,'NumNeighbors',2);  
    Class = predict(Mdl,pvec(i,:));
    newdata(i) = data(Class, 3); 

end
t = 0:1:22;
plot(t, data(721:743,3),'.b--', 'markersize', 10);
hold on;
plot(t, newdata(1:23),'.r--', 'markersize', 10);
hold on;
