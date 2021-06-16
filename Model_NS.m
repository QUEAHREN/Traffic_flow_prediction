function [] = Model_NS(P, len_road, T, Vmax)
                        %P为慢化概率
    if nargin < 2   
        len_road = 200; %道路长度
    end     
    if nargin < 3  
        T = 1000;       %迭代步数
    end     
    if nargin < 4   
        Vmax = 5;       %最大速度   
    end    
    
    dens = 0.3;         %密度
    N = len_road * dens;
    RP = randperm(len_road);                %生成行向量，为1-len_road之间的整数随机置换         
    Car_Position = sort(RP(1, 1:N));        %截取前N个
    Car_Speed = randsrc(1, N, 1:Vmax);      %生成随机速度
    d = zeros(N);                           %初始化车头间距

    %初始状态
    t = 1; 
    plot(t, Car_Position, '.k', 'markersize', 1);
    hold on;

    for t = 2:1:T

        %定义车头间距
        %车流首与尾的车头间距
        if Car_Position(N) > Car_Position(1)
            d(N) = len_road - Car_Position(N) + Car_Position(1)-1;
        else 
            d(N) = Car_Position(1) - Car_Position(N) - 1;
        end
        %车流中相邻车辆的车头间距
        for i = N-1:-1:1
            if Car_Position(i+1) > Car_Position(i)
                d(i) = Car_Position(i+1) - Car_Position(i) - 1;
            else   
                d(i) = len_road - Car_Position(i) + Car_Position(i+1) - 1;
            end
        end

        %加速
        for i = 1:1:N
            Car_Speed(i) = min(Car_Speed(i) + 1, Vmax);
        end

        %减速
        for i = 1:1:N
            Car_Speed(i) = min(Car_Speed(i), d(i));
        end

        %随机慢化
        slow = rand(1, N);      %长为N的行向量，随机0-1之间，即每辆车随机概率慢化
        for i =1:1:N
            if slow(i) <= P     %若小于P则慢化，从而实现以概率P对交通流随机慢化
                Car_Speed(i) = max(Car_Speed(i) - 1, 0);
            end
        end

        %更新位置
        for i=N:-1:1
            Car_Position(i) = Car_Position(i) + Car_Speed(i);
            %注意位置超出道路长度的情况
            if Car_Position(i) >= len_road
                Car_Position(i) = Car_Position(i) - len_road; 
            end 
        end 
        plot(t, Car_Position, '.k', 'markersize', 1);
        hold on;

    end


end

