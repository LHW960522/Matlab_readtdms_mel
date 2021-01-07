% matlab ��ȡtdms ��ͼ
clear;clc
data=convertTDMS(0,'12-24/2.tdms');
data1=data.Data.MeasuredData(4).Data;% ����ͨ��
% data2=data.Data.MeasuredData(5).Data;% ����ͨ��
% data3=data.Data.MeasuredData(6).Data;% ��ѹͨ��
L=length(data1);
Fs=16000;             % ������
T=1/Fs;               % ��������
t=(0:L-1)*T;          % ʱ������
y=fft(data1);

figure(1);
P2=abs(y/L);            % ÿ�����������г��� L
P1 = P2(1:L/2+1);       % ȡ��������
P1(2:end-1) = 2*P1(2:end-1); % ��������ģֵ����2
f = Fs*(0:(L/2))/L;
plot(f,P1)
title('fft')
xlabel('f(Hz)')
ylabel('|P1(f)|')
ylim([0,0.3]); 

figure(2);
N=2^nextpow2(L);
Y=fft(data1,N);         %fft�任
Y=abs(Y)./N;            %ʵ�ʷ�ֵ�任
f=(0:N-1)*Fs./N;        %ʵ��Ƶ�ʱ任
plot(f(1:N/2),2*Y(1:N./2));
title("DFT�任��Ƶ��Ӧ����")
xlabel("f/Hz")
ylim([0,0.3]); 


% ��ͼ
figure(3);
plot(t,data1);
xlabel('t');ylabel('����');

% ****************************������˹��ͨ�˲�********************************
figure(4); 
% ��ͨ
wp_d=200;%ͨ�����޽�ֹƵ��
wp_s=300;%ͨ�����޽�ֹƵ��
ws_d=100;%������޽�ֹƵ��
ws_s=400;%������޽�ֹƵ��
wp=[wp_d wp_s]*2/Fs; ws=[ws_d ws_s]*2/Fs;%����ͨ����ֹƵ��wp�����Ƶ��ws
Ap=3;As=18;%����ͨ���������˥������Ϊ3dB�����Ӧ�ﵽ����С˥��Ϊ18dB
Nn=256;%ȡ������
[N,wn]=buttord(wp,ws,Ap,As);%���������˹�˲����״κͽ�ֹƵ��
%NΪ�˲������� wnΪ�˲�����ֹƵ�� �����˲���
[b,a]=butter(N,wn,'bandpass');%Ƶ�ʱ任����ư�����˹��ͨ�˲���
[db,mag,pha,grd,w]=freqz_m(b,a); %���������˹��ͨ�˲�����Ƶ�����ȡ���λ��
subplot(4,1,1)
plot(w*Fs/(2*pi),mag);
xlabel('f/Hz');%Ƶ�ʣ�HZ��
ylabel('����/dB');
axis([0,1000,0,1.5]);%���ñ�߷�Χ
title('���ִ�ͨ������˹�˲���')
grid on;
subplot(4,1,2);
plot(w*Fs/(2*pi),180/pi*unwrap(pha));
xlabel('f/Hz');
ylabel('��λ/�Ƕ�');
grid on;
% 
% ��ͨ
% Ap=2;As=15;%����ͨ���������˥������Ϊ2dB�����Ӧ�ﵽ����С˥��Ϊ15dB
% Nn=1000;%��������
% F=1500;%��ǰƵ��
% F_sh=100;%������޽�ֹƵ��
% %MATLAB���ߺ��������ñ�׼��Ƶ�ʣ�wp��ws��ȡֵ��ΧΪ0��1
% wp=F*2/Fs; ws=F_sh*2/Fs;%����ͨ����ֹƵ��Ϊwp/pi �������ֹƵ��Ϊws/pi 
% [N,wn]=buttord(wp,ws,Ap,As);%���������˹�˲����״κͽ�ֹƵ��
% [b,a]=butter(N,wn,'high');%Ƶ�ʱ任����ư�����˹��ͨ�˲���
% [db,mag,pha,grd,w]=freqz_m(b,a); 
% subplot(2,1,1)
% plot(w*Fs/(2*pi),mag);
% xlabel('f/Hz');%Ƶ�ʣ�HZ��
% ylabel('����/dB');
% title('��ͨ������˹�˲���')
% grid on;
% subplot(2,1,2);
% plot(w*Fs/(2*pi),180/pi*unwrap(pha));
% xlabel('f/Hz');
% ylabel('��λ/�Ƕ�');
% grid on;

% ����
% wp_d=400;%������޽�ֹƵ��
% wp_s=700;%������޽�ֹƵ��
% ws_d=300;%ͨ�����޽�ֹƵ��
% ws_s=800;%ͨ�����޽�ֹƵ��
% wp=[wp_d wp_s]*2/Fs; ws=[ws_d ws_s]*2/Fs;%���������ֹƵ��wp��ͨ��Ƶ��ws
% Ap=3;As=18;%����ͨ���������˥������Ϊ3dB�����Ӧ�ﵽ����С˥��Ϊ18dB
% [N,wn]=buttord(wp,ws,Ap,As);%���������˹�˲����״κͽ�ֹƵ��
% %NΪ�˲������� wnΪ�˲�����ֹƵ�� �����˲���
% [b,a]=butter(N,wn,'stop');%Ƶ�ʱ任����ư�����˹�����˲���
% [db,mag,pha,grd,w]=freqz_m(b,a); %���������˹�����˲�����Ƶ�����ȡ���λ��
% subplot(2,1,1)
% plot(w*Fs/(2*pi),mag);%dbΪ�ֱ���magΪ����
% xlabel('f/Hz');%Ƶ�ʣ�HZ��
% ylabel('����');
% % axis([0,1000,0,1.5]);%���ñ�߷�Χ
% title('���ִ�ͨ������˹�˲���')
% grid on;
% subplot(2,1,2);
% plot(w*Fs/(2*pi),180/pi*unwrap(pha));
% xlabel('f/Hz');
% ylabel('��λ/�Ƕ�');
% grid on;

Signal_Filter=filter(b,a,data1); 
subplot(4,1,3);                                        %Mix_Signal_1 ԭʼ�ź�                  
plot(t,data1); 
title('ԭʼ�ź� '); 

subplot(4,1,4);                                        %Mix_Signal_1 ��ͨ�˲��˲����ź�   
plot(t,Signal_Filter); 
title('������˹�˲����ź�'); 

figure(5);
N=length(Signal_Filter);
Y=fft(Signal_Filter,N);         %fft�任
Y=abs(Y)./N;                    %ʵ�ʷ�ֵ�任
f=(0:N-1)*Fs./N;                %ʵ��Ƶ�ʱ任
plot(f(1:N/2),Y(1:N./2));
title("������˹��ͨ�˲�����Ҷ�任")
xlabel("f/Hz")
ylim([0,0.4]); 
%*******************************������˹��ͨ�˲� *****************************

%****************************���ִ�ͨ�б�ѩ��I���˲���**************************
figure(6);
% Fs=2000;%��������Ƶ��
wp_d=200;%ͨ�����޽�ֹƵ��
wp_s=300;%ͨ�����޽�ֹƵ��
ws_d=100;%������޽�ֹƵ��
ws_s=400;%������޽�ֹƵ��
wp=[wp_d wp_s]*2/Fs; ws=[ws_d ws_s]*2/Fs;%����ͨ����ֹƵ��wp�����Ƶ��ws
Ap=3;As=18;%����ͨ���������˥������Ϊ3dB�����Ӧ�ﵽ����С˥��Ϊ18dB
Nn=256;%ȡ������
[N,Wn]=cheb1ord(wp,ws,Ap,As);%�����б�ѩ���˲����״κͽ�ֹƵ��
%NΪ�˲������� wnΪ�˲�����ֹƵ�� �����˲���
[b,a]=cheby1(N,Ap,Wn);%Ƶ�ʱ任������б�ѩ���ͨ�˲���
[db,mag,pha,grd,w]=freqz_m(b,a); %����б�ѩ���ͨ�˲�����Ƶ�����ȡ���λ��
subplot(4,1,1)
plot(w*Fs/(2*pi),mag);
xlabel('f/Hz');%Ƶ�ʣ�HZ��
ylabel('����/dB');
axis([0,1000,0,1.5]);%���ñ�߷�Χ
title('���ִ�ͨ�б�ѩ��I���˲���')
grid on;
subplot(4,1,2);
plot(w*Fs/(2*pi),180/pi*unwrap(pha));
xlabel('f/Hz');
ylabel('��λ/�Ƕ�');
grid on;

Signal_Filter=filter(b,a,data1); 
subplot(4,1,3);                                        %Mix_Signal_1 ԭʼ�ź�                  
plot(t,data1); 
title('ԭʼ�ź�'); 

subplot(4,1,4);                                        %Mix_Signal_1 ��ͨ�˲��˲����ź�   
plot(t,Signal_Filter); 
title('���ִ�ͨ�б�ѩ��I���˲����ź�'); 

figure(7);
N=length(Signal_Filter);
Y=fft(Signal_Filter,N);         %fft�任
Y=abs(Y)./N;            %ʵ�ʷ�ֵ�任
f=(0:N-1)*Fs./N;        %ʵ��Ƶ�ʱ任
plot(f(1:N/2),Y(1:N./2));
title("���ִ�ͨ�б�ѩ��I���˲�����Ҷ�任")
xlabel("f/Hz")
ylim([0,0.4]); 

%****************************���ִ�ͨ�б�ѩ��I���˲���**************************

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