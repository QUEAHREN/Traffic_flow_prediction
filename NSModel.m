len_road = 200;         %��·����
P = 0.3;                %�����������
Vmax = 5;               %����ٶ�
T = 1000;               %��������
dens = 0.3;             %�ܶ�
N = len_road * dens;
RP = randperm(len_road); 
B = RP(1, 1:N);         %��ȡǰN��
CarX = sort(B);         %��ʼ״̬����������ֲ��ڵ�·��
CarV = randsrc(1, N, 1:Vmax);   %��������ٶ�
d = zeros(N);
t = 1;                          %��ʼʱ�䲽

plot(CarX, t, '.k', 'markersize', 1);
hold on;
for t = 2:1:T
	%���峵ͷ���
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
	%����
    for i = 1:1:N
        CarV(i) = min(CarV(i)+1,Vmax);
    end
    %����
    for i = 1:1:N
        CarV(i) = min(CarV(i),d(i));
    end
    %�������
    slow = rand(1,N);%��������� 0-1��1��N���о����������ʱ��
    for i =1:1:N
        if slow(i)<=P
            CarV(i)=max(CarV(i)-1,0);
        end
    end
	%λ�ø���
    for i=N:-1:1
        CarX(i)=CarX(i)+CarV(i);
        if CarX(i)>=len_road
        	CarX(i)=CarX(i)-len_road; 
        end 
    end 
    plot(CarX,t,'.k','markersize',1);
    hold on;
    
end

