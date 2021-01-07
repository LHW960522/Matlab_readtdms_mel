Fs=512;%����Ƶ��
Ts=1/Fs;%��������
N=1024;%N?DFT
L=128;%ԭ�ź����г���
t=(0:L-1).*Ts;%ʱ���Ա���
x=cos(10*2*pi*t);%ԭ�ź�
subplot(311);
plot(t,x);
title("ԭ�ź�")
xlabel("t/s")
grid on
Y=fft(x,N);%fft�任
Y=abs(Y)./N;%ʵ�ʷ�ֵ�任
f=(0:N-1)*Fs./N;%ʵ��Ƶ�ʱ任
subplot(312);
plot(f(1:N/2),Y(1:N./2));
title("N-DFT�任��Ƶ��Ӧ����")
xlabel("f/Hz")
grid on
f=f-Fs./2;%��λ
subplot(313);
plot(f,fftshift(Y));%��λ
title("N-DFT�任��Ƶ��Ӧ˫��")
xlabel("f/Hz")
grid on