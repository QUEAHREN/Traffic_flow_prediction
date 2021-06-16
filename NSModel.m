len_road = 200;         %道路长度
P = 0.3;                %随机慢化概率
Vmax = 5;               %最大速度
T = 1000;               %迭代步数
dens = 0.3;             %密度
N = len_road * dens;
RP = randperm(len_road); 
B = RP(1, 1:N);         %截取前N个
CarX = sort(B);         %初始状态，车辆随机分布在道路上
CarV = randsrc(1, N, 1:Vmax);   %生成随机速度
d = zeros(N);
t = 1;                          %初始时间步

plot(CarX, t, '.k', 'markersize', 1);
hold on;
for t = 2:1:T
	%定义车头间距
	if CarX(N)>CarX(1)
        d(N)=len_road-CarX(N)+CarX(1)-1;
    else 
        d(N)=CarX(1)-CarX(N)-1;
	end
	for i=N-1:-1:1
        if CarX(i+1)>CarX(i)
            d(i)=CarX(i+1)-CarX(i)-1;
        else   
            d(i)=len_road-CarX(i)+CarX(i+1)-1;
        end
	end
	%加速
    for i = 1:1:N
        CarV(i) = min(CarV(i)+1,Vmax);
    end
    %减速
    for i = 1:1:N
        CarV(i) = min(CarV(i),d(i));
    end
    %随机慢化
    slow = rand(1,N);%产生随机数 0-1，1×N的行矩阵，随机慢化时用
    for i =1:1:N
        if slow(i)<=P
            CarV(i)=max(CarV(i)-1,0);
        end
    end
	%位置更新
    for i=N:-1:1
        CarX(i)=CarX(i)+CarV(i);
        if CarX(i)>=len_road
        	CarX(i)=CarX(i)-len_road; 
        end 
    end 
    plot(CarX,t,'.k','markersize',1);
    hold on;
    
end

