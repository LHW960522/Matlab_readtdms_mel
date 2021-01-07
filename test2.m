data=convertTDMS(0,'12-24/2.tdms');
data1=data.Data.MeasuredData(4).Data;% ����ͨ��
fs=16000;

% S = melSpectrogram(data1,fs); % �Բ�����fs������Ƶ�����melƵ��ͼ�� �ú��������������Ϊ������ͨ����
% % ��ӡ�˹�Ƭ���еĴ�ͨ�˹�Ƭ��������÷������ͼ�е�֡����
% [numBands,numFrames] = size(S);
% fprintf("�˲������еĴ�ͨ�˲�����������%d\n",numBands)
% fprintf("Ƶ��ͼ�е�֡����%d\n",numFrames)
% 
% % ����÷��Ƶ��ͼ��
% figure(1);
% melSpectrogram(data1,fs)

% ����÷������ϵ��

WL=512;    % ��֡����
OL=128;    % ֮֡���ص�����
FFTL=1024;  % ��ʱ����Ҷ����
NB=32;      % ÷������ϵ���˲�������

S = melSpectrogram(data1,fs, ...
                   'WindowLength',WL,...
                   'OverlapLength',OL, ...
                   'FFTLength',FFTL, ...
                   'NumBands',NB, ...
                   'FrequencyRange',[62.5,8e3]);

% �ٴε���melSpectrogram����һ�β�ʹ���κ�������������ӻ�melƵ��ͼ��������Ƶ�Ƕ������źš����ʹ�ö�ͨ��������û�������������melSpectrogram��������Ƶ�һ��ͨ��
figure(1);
melSpectrogram(data1,fs, ...
               'WindowLength',WL,...
               'OverlapLength',OL, ...
               'FFTLength',FFTL, ...
               'NumBands',NB, ...
               'FrequencyRange',[62.5,8e3])

% ����ͼ
% y=resample(data1,8000,Fs);
% y=data1;
% soundsc(y,fs);

figure(2);
subplot(211)
spectrogram(data1,WL,OL,FFTL,fs,'yaxis');

% spectrogram(audiodata, win, overlap, nfft, fs)
% audiodata  ��������
% win        ֡�����ߴ�
% overlap    ֡��֮֡����ص�
% nfft       DFT�ĵ���
% fs         ����Ƶ��

title('spectrogram function of matlab');

subplot(212)
myspectrogram(data1,WL,OL,FFTL,fs);
title('Myspectrogram');

