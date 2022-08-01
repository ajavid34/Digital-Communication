clc
clear all
%% Section 1: Raised-Cosine Pulse Generation

B = 0; 
T = 1;
Fs = 10;
Ts = 1;
L = T*Fs;
[~, RC] = RC_pulse(T, Fs, B, 0, -6, 6);

%% Section 2: Creating Modulated Symbols

N = 1e6;

bits = rand(1,N);
SNR_dB = 0:10;

SNR = zeros(1,length(SNR_dB)) ;

modulated_symbols = modulate(bits);

%% Section 3: Transmission and Reception

upsampled_symbols = upsample(modulated_symbols,L);
upsampled_symbols = upsampled_symbols(1:end-(L-1));
transmitted_signal = conv(upsampled_symbols,RC);
noise = randn(1,length(transmitted_signal));

SNR_dB = 0:10;
snr = 10.^(SNR_dB./10);
eta = var(transmitted_signal)./snr;
noise = diag(sqrt(eta./2))*repmat(noise,11,1);
received_signal = repmat(transmitted_signal,11,1)+ noise;
%% Section 4: ML detection:
T_sampling = 6*L+1 : L : (N+6-1)*L+1;
samples = received_signal(:,T_sampling);
delta_ml = [-2*ones(1,length(SNR_dB));zeros(1,length(SNR_dB));
    2*ones(1,length(SNR_dB))];
detected_symbols_ML = detect(samples,length(SNR_dB),delta_ml);
error_ML = error_detect(length(SNR_dB), length(detected_symbols_ML) ...
    ,detected_symbols_ML,modulated_symbols);

Pe_ML = reshape(error_ML, [1 11])/N;
%% Section 5: MAP detection:

delta_MAP = [-0.5*eta/2*log2(4)-2;
    zeros(1,length(SNR_dB));
    0.5*eta/2*log2(4)+2];
detected_symbols_MAP = detect(samples,length(SNR_dB),delta_MAP);
error_MAP = error_detect(length(SNR_dB), length(detected_symbols_MAP) ...
    ,detected_symbols_MAP,modulated_symbols);
Pe_PAM = reshape(error_MAP, [1 11])/N;
%% Section 6: Plotting Results:

figure
semilogy(SNR_dB,Pe_PAM,SNR_dB,Pe_ML)
grid on
title('Probability error of 4-PAM ' )
xlabel('$\frac{E_{s}}{\eta}$ in dB', 'interpreter', 'Latex');
ylabel('Symbol Error Rate')
legend('P_{e}(MAP)',' P_{e}(ML)')
