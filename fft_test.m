Fs=512;%采样频率
Ts=1/Fs;%采样周期
N=1024;%N?DFT
L=128;%原信号序列长度
t=(0:L-1).*Ts;%时域自变量
x=cos(10*2*pi*t);%原信号
subplot(311);
plot(t,x);
title("原信号")
xlabel("t/s")
grid on
Y=fft(x,N);%fft变换
Y=abs(Y)./N;%实际幅值变换
f=(0:N-1)*Fs./N;%实际频率变换
subplot(312);
plot(f(1:N/2),Y(1:N./2));
title("N-DFT变换幅频响应单边")
xlabel("f/Hz")
grid on
f=f-Fs./2;%移位
subplot(313);
plot(f,fftshift(Y));%移位
title("N-DFT变换幅频响应双边")
xlabel("f/Hz")
grid on