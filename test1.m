% matlab 读取tdms 画图
clear;clc
data=convertTDMS(0,'12-24/2.tdms');
data1=data.Data.MeasuredData(4).Data;% 声音通道
% data2=data.Data.MeasuredData(5).Data;% 电流通道
% data3=data.Data.MeasuredData(6).Data;% 电压通道
L=length(data1);
Fs=16000;             % 采样率
T=1/Fs;               % 采样周期
t=(0:L-1)*T;          % 时间相量
y=fft(data1);

figure(1);
P2=abs(y/L);            % 每个量除以数列长度 L
P1 = P2(1:L/2+1);       % 取交流部分
P1(2:end-1) = 2*P1(2:end-1); % 交流部分模值乘以2
f = Fs*(0:(L/2))/L;
plot(f,P1)
title('fft')
xlabel('f(Hz)')
ylabel('|P1(f)|')
ylim([0,0.3]); 

figure(2);
N=2^nextpow2(L);
Y=fft(data1,N);         %fft变换
Y=abs(Y)./N;            %实际幅值变换
f=(0:N-1)*Fs./N;        %实际频率变换
plot(f(1:N/2),2*Y(1:N./2));
title("DFT变换幅频响应单边")
xlabel("f/Hz")
ylim([0,0.3]); 


% 画图
figure(3);
plot(t,data1);
xlabel('t');ylabel('声音');

% ****************************巴特沃斯带通滤波********************************
figure(4); 
% 带通
wp_d=200;%通带下限截止频率
wp_s=300;%通带上限截止频率
ws_d=100;%阻带下限截止频率
ws_s=400;%阻带上限截止频率
wp=[wp_d wp_s]*2/Fs; ws=[ws_d ws_s]*2/Fs;%计算通带截止频率wp，阻带频率ws
Ap=3;As=18;%设置通带允许最大衰减设置为3dB，阻带应达到的最小衰减为18dB
Nn=256;%取样点数
[N,wn]=buttord(wp,ws,Ap,As);%计算巴特沃斯滤波器阶次和截止频率
%N为滤波器阶数 wn为滤波器截止频率 数字滤波器
[b,a]=butter(N,wn,'bandpass');%频率变换法设计巴特沃斯带通滤波器
[db,mag,pha,grd,w]=freqz_m(b,a); %求出巴特沃斯带通滤波器幅频、幅度、相位等
subplot(4,1,1)
plot(w*Fs/(2*pi),mag);
xlabel('f/Hz');%频率（HZ）
ylabel('幅度/dB');
axis([0,1000,0,1.5]);%设置标尺范围
title('数字带通巴特沃斯滤波器')
grid on;
subplot(4,1,2);
plot(w*Fs/(2*pi),180/pi*unwrap(pha));
xlabel('f/Hz');
ylabel('相位/角度');
grid on;
% 
% 高通
% Ap=2;As=15;%设置通带允许最大衰减设置为2dB，阻带应达到的最小衰减为15dB
% Nn=1000;%抽样次数
% F=1500;%当前频率
% F_sh=100;%阻带上限截止频率
% %MATLAB工具函数常采用标准化频率，wp和ws的取值范围为0～1
% wp=F*2/Fs; ws=F_sh*2/Fs;%所以通带截止频率为wp/pi ，阻带截止频率为ws/pi 
% [N,wn]=buttord(wp,ws,Ap,As);%计算巴特沃斯滤波器阶次和截止频率
% [b,a]=butter(N,wn,'high');%频率变换法设计巴特沃斯高通滤波器
% [db,mag,pha,grd,w]=freqz_m(b,a); 
% subplot(2,1,1)
% plot(w*Fs/(2*pi),mag);
% xlabel('f/Hz');%频率（HZ）
% ylabel('幅度/dB');
% title('高通巴特沃斯滤波器')
% grid on;
% subplot(2,1,2);
% plot(w*Fs/(2*pi),180/pi*unwrap(pha));
% xlabel('f/Hz');
% ylabel('相位/角度');
% grid on;

% 带阻
% wp_d=400;%阻带下限截止频率
% wp_s=700;%阻带上限截止频率
% ws_d=300;%通带下限截止频率
% ws_s=800;%通带上限截止频率
% wp=[wp_d wp_s]*2/Fs; ws=[ws_d ws_s]*2/Fs;%计算阻带截止频率wp，通带频率ws
% Ap=3;As=18;%设置通带允许最大衰减设置为3dB，阻带应达到的最小衰减为18dB
% [N,wn]=buttord(wp,ws,Ap,As);%计算巴特沃斯滤波器阶次和截止频率
% %N为滤波器阶数 wn为滤波器截止频率 数字滤波器
% [b,a]=butter(N,wn,'stop');%频率变换法设计巴特沃斯带阻滤波器
% [db,mag,pha,grd,w]=freqz_m(b,a); %求出巴特沃斯带阻滤波器幅频、幅度、相位等
% subplot(2,1,1)
% plot(w*Fs/(2*pi),mag);%db为分贝，mag为增益
% xlabel('f/Hz');%频率（HZ）
% ylabel('幅度');
% % axis([0,1000,0,1.5]);%设置标尺范围
% title('数字带通巴特沃斯滤波器')
% grid on;
% subplot(2,1,2);
% plot(w*Fs/(2*pi),180/pi*unwrap(pha));
% xlabel('f/Hz');
% ylabel('相位/角度');
% grid on;

Signal_Filter=filter(b,a,data1); 
subplot(4,1,3);                                        %Mix_Signal_1 原始信号                  
plot(t,data1); 
title('原始信号 '); 

subplot(4,1,4);                                        %Mix_Signal_1 低通滤波滤波后信号   
plot(t,Signal_Filter); 
title('巴特沃斯滤波后信号'); 

figure(5);
N=length(Signal_Filter);
Y=fft(Signal_Filter,N);         %fft变换
Y=abs(Y)./N;                    %实际幅值变换
f=(0:N-1)*Fs./N;                %实际频率变换
plot(f(1:N/2),Y(1:N./2));
title("巴特沃斯带通滤波后傅里叶变换")
xlabel("f/Hz")
ylim([0,0.4]); 
%*******************************巴特沃斯带通滤波 *****************************

%****************************数字带通切比雪夫I型滤波器**************************
figure(6);
% Fs=2000;%给定抽样频率
wp_d=200;%通带下限截止频率
wp_s=300;%通带上限截止频率
ws_d=100;%阻带下限截止频率
ws_s=400;%阻带上限截止频率
wp=[wp_d wp_s]*2/Fs; ws=[ws_d ws_s]*2/Fs;%计算通带截止频率wp，阻带频率ws
Ap=3;As=18;%设置通带允许最大衰减设置为3dB，阻带应达到的最小衰减为18dB
Nn=256;%取样点数
[N,Wn]=cheb1ord(wp,ws,Ap,As);%计算切比雪夫滤波器阶次和截止频率
%N为滤波器阶数 wn为滤波器截止频率 数字滤波器
[b,a]=cheby1(N,Ap,Wn);%频率变换法设计切比雪夫高通滤波器
[db,mag,pha,grd,w]=freqz_m(b,a); %求出切比雪夫带通滤波器幅频、幅度、相位等
subplot(4,1,1)
plot(w*Fs/(2*pi),mag);
xlabel('f/Hz');%频率（HZ）
ylabel('幅度/dB');
axis([0,1000,0,1.5]);%设置标尺范围
title('数字带通切比雪夫I型滤波器')
grid on;
subplot(4,1,2);
plot(w*Fs/(2*pi),180/pi*unwrap(pha));
xlabel('f/Hz');
ylabel('相位/角度');
grid on;

Signal_Filter=filter(b,a,data1); 
subplot(4,1,3);                                        %Mix_Signal_1 原始信号                  
plot(t,data1); 
title('原始信号'); 

subplot(4,1,4);                                        %Mix_Signal_1 低通滤波滤波后信号   
plot(t,Signal_Filter); 
title('数字带通切比雪夫I型滤波后信号'); 

figure(7);
N=length(Signal_Filter);
Y=fft(Signal_Filter,N);         %fft变换
Y=abs(Y)./N;            %实际幅值变换
f=(0:N-1)*Fs./N;        %实际频率变换
plot(f(1:N/2),Y(1:N./2));
title("数字带通切比雪夫I型滤波后傅里叶变换")
xlabel("f/Hz")
ylim([0,0.4]); 

%****************************数字带通切比雪夫I型滤波器**************************

% 
% figure(2);
% plot(t,data2);
% xlabel('t');ylabel('A');
% 
% figure(3);
% plot(t,data3);
% xlabel('t');ylabel('V');
% 
% 
% figure(4);
% plot(t,y);