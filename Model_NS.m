function [] = Model_NS(P, len_road, T, Vmax)
                        %PΪ��������
    if nargin < 2   
        len_road = 200; %��·����
    end     
    if nargin < 3  
        T = 1000;       %��������
    end     
    if nargin < 4   
        Vmax = 5;       %����ٶ�   
    end    
    
    dens = 0.3;         %�ܶ�
    N = len_road * dens;
    RP = randperm(len_road);                %������������Ϊ1-len_road֮�����������û�         
    Car_Position = sort(RP(1, 1:N));        %��ȡǰN��
    Car_Speed = randsrc(1, N, 1:Vmax);      %��������ٶ�
    d = zeros(N);                           %��ʼ����ͷ���

    %��ʼ״̬
    t = 1; 
    plot(t, Car_Position, '.k', 'markersize', 1);
    hold on;

    for t = 2:1:T

        %���峵ͷ���
        %��������β�ĳ�ͷ���
        if Car_Position(N) > Car_Position(1)
            d(N) = len_road - Car_Position(N) + Car_Position(1)-1;
        else 
            d(N) = Car_Position(1) - Car_Position(N) - 1;
        end
        %���������ڳ����ĳ�ͷ���
        for i = N-1:-1:1
            if Car_Position(i+1) > Car_Position(i)
                d(i) = Car_Position(i+1) - Car_Position(i) - 1;
            else   
                d(i) = len_road - Car_Position(i) + Car_Position(i+1) - 1;
            end
        end

        %����
        for i = 1:1:N
            Car_Speed(i) = min(Car_Speed(i) + 1, Vmax);
        end

        %����
        for i = 1:1:N
            Car_Speed(i) = min(Car_Speed(i), d(i));
        end

        %�������
        slow = rand(1, N);      %��ΪN�������������0-1֮�䣬��ÿ���������������
        for i =1:1:N
            if slow(i) <= P     %��С��P���������Ӷ�ʵ���Ը���P�Խ�ͨ���������
                Car_Speed(i) = max(Car_Speed(i) - 1, 0);
            end
        end

        %����λ��
        for i=N:-1:1
            Car_Position(i) = Car_Position(i) + Car_Speed(i);
            %ע��λ�ó�����·���ȵ����
            if Car_Position(i) >= len_road
                Car_Position(i) = Car_Position(i) - len_road; 
            end 
        end 
        plot(t, Car_Position, '.k', 'markersize', 1);
        hold on;

    end


end

