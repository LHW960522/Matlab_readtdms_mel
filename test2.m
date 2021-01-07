data=convertTDMS(0,'12-24/2.tdms');
data1=data.Data.MeasuredData(4).Data;% 声音通道
fs=16000;

% S = melSpectrogram(data1,fs); % 以采样率fs返回音频输入的mel频谱图。 该函数将输入的列视为单独的通道。
% % 打印滤光片组中的带通滤光片的数量和梅尔光谱图中的帧数。
% [numBands,numFrames] = size(S);
% fprintf("滤波器组中的带通滤波器的数量：%d\n",numBands)
% fprintf("频谱图中的帧数：%d\n",numFrames)
% 
% % 绘制梅尔频谱图。
% figure(1);
% melSpectrogram(data1,fs)

% 计算梅尔倒谱系数

WL=512;    % 分帧长度
OL=128;    % 帧之间重叠长度
FFTL=1024;  % 短时傅里叶长度
NB=32;      % 梅尔倒谱系数滤波器个数

S = melSpectrogram(data1,fs, ...
                   'WindowLength',WL,...
                   'OverlapLength',OL, ...
                   'FFTLength',FFTL, ...
                   'NumBands',NB, ...
                   'FrequencyRange',[62.5,8e3]);

% 再次调用melSpectrogram，这一次不使用任何输出参数，可视化mel频谱图。输入音频是多声道信号。如果使用多通道输入且没有输出参数调用melSpectrogram，则仅绘制第一个通道
figure(1);
melSpectrogram(data1,fs, ...
               'WindowLength',WL,...
               'OverlapLength',OL, ...
               'FFTLength',FFTL, ...
               'NumBands',NB, ...
               'FrequencyRange',[62.5,8e3])

% 声谱图
% y=resample(data1,8000,Fs);
% y=data1;
% soundsc(y,fs);

figure(2);
subplot(211)
spectrogram(data1,WL,OL,FFTL,fs,'yaxis');

% spectrogram(audiodata, win, overlap, nfft, fs)
% audiodata  语音数据
% win        帧长或者窗
% overlap    帧与帧之间的重叠
% nfft       DFT的点数
% fs         采样频率

title('spectrogram function of matlab');

subplot(212)
myspectrogram(data1,WL,OL,FFTL,fs);
title('Myspectrogram');

