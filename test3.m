%using myspectrogram to present Spectrogram 
clear;clc
data=convertTDMS(0,'12-24/4.tdms');
data1=data.Data.MeasuredData(4).Data;% 声音通道
Fs=16000;
% y=resample(data1,8000,Fs);
y=data1;
% soundsc(y,Fs);

subplot(211)
spectrogram(y,2048,1024,4096,Fs,'yaxis');

% spectrogram(audiodata, win, overlap, nfft, fs)
% audiodata  语音数据
% win        帧长或者窗
% overlap    帧与帧之间的重叠
% nfft       DFT的点数
% fs         采样频率

title('spectrogram function of matlab');
subplot(212)
myspectrogram(y,2048,1024,4096,Fs);
title('Myspectrogram');

