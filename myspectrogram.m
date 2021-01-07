function s = myspectrogram(audiodata, win, overlap, nfft, fs)
% audiodata  语音数据
% win        帧长或者窗
% overlap    帧与帧之间的重叠
% nfft       DFT的点数
% fs         采样频率
%Short-Time Fourier Transform
%------------------dcj--Edit in 20200308-----------------------
dataL = length(audiodata(:));  % length of the signal
if(length(win)==1)
    winL = win;
else
    winL = length(win);
end
inc = winL - overlap;
fn = fix((dataL - overlap)/inc);


% form the stft matrix
rown = ceil((1+nfft)/2);            % calculate the total number of rows
coln = 1+fix((dataL-winL)/inc);        % calculate the total number of columns
stft = zeros(rown, coln);           % form the stft matrix

% initialize the indexes
indx = 0;
col = 1;

% perform STFT
while indx + winL <= dataL
    % windowing
    dframe = audiodata(indx+1:indx+winL).*win;
    
    % FFT
    X = fft(dframe, nfft);
    
    % update the stft matrix
    stft(:, col) = X(1:rown);
    
    % update the indexes
    indx = indx + inc;
    col = col + 1;
end
s =stft;

% calculate the time and frequency vectors
t = (winL/2:inc:winL/2+(coln-1)*inc)/fs;
f = (0:rown-1)*fs/nfft/1000;

%plot the spectrogram
%set(gcf,'Position',[20 100 600 500]);
%axes('Position',[0.1 0.1 0.85 0.5]);
% clims = [-140 -40];
imagesc(t,f,log(2*abs(stft/nfft))*10);%存在幅度修正
c = colorbar;
c.Label.String = 'power/frequency(dB/Hz)';
axis xy;
xlabel('Time/s');
ylabel('Frequency/KHz');
title('myspectrogram');
end


