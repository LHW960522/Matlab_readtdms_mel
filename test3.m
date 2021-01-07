%using myspectrogram to present Spectrogram 
clear;clc
data=convertTDMS(0,'12-24/4.tdms');
data1=data.Data.MeasuredData(4).Data;% ����ͨ��
Fs=16000;
% y=resample(data1,8000,Fs);
y=data1;
% soundsc(y,Fs);

subplot(211)
spectrogram(y,2048,1024,4096,Fs,'yaxis');

% spectrogram(audiodata, win, overlap, nfft, fs)
% audiodata  ��������
% win        ֡�����ߴ�
% overlap    ֡��֮֡����ص�
% nfft       DFT�ĵ���
% fs         ����Ƶ��

title('spectrogram function of matlab');
subplot(212)
myspectrogram(y,2048,1024,4096,Fs);
title('Myspectrogram');

