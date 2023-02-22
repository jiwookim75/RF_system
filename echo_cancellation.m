% clear all;
% load("Tx_Signals_LRR_MRR_SRR.mat"); % Fs = 4 x 115 MHz
% Lin_Tx_Sig = Tx_Sig_LRR(:)';
clf;
Ntx = 8;
Nrx = 8;
rng(1000);

Len_Tx_Sig = length(Lin_Tx_Sig);

echo = zeros(Ntx, Len_Tx_Sig);

delay = [1 2 3 4 5 6 7 8]; % could be non-integer
%atten_profile = [];  % complex
amp_db = [-40 -50 -60 -70 -80 -90 -100 -110];   % Tx-to-Rx Antenna leakage in power (dB)
amp = 10.^(amp_db/20);
atten_phase = pi*(rand(1, Ntx) - 0.5);  % uniform distribution over [-pi/2 pi/2]
% atten_phase = zeros(1, Ntx);  % zero phases for debugging purpose

atten_profile = amp.*exp(j*atten_phase);

%echo(1,:) = Lin_Tx_Sig;
for i=1:Ntx
    echo(i,:) = atten_profile(i).*[zeros(1,delay(i)) Lin_Tx_Sig(1:(Len_Tx_Sig-delay(i)))];
end

echo_tmp = echo;    % For Option 1
echo_tmp = echo + Lin_Tx_Sig;   % For Optino 2
echo_total = sum(echo_tmp);  % sum of echos from multipath 



% filt = dsp.FIRFilter;
% filt.Numerator = fircband(12,[0 0.4 0.5 1],[1 1 0 0],[1 0.2],... 
% {'w' 'c'});

mu = .8;  % Step size
Ntap = 8; % Num of taps of the adaptive filter
%m = 5;      % Decimation factor for analysis and simulation
lms = dsp.LMSFilter('Length', Ntap,...
    'StepSize',mu,...
    'Method', 'Normalized LMS');
    %'WeightsOutput','All');
[y,e,w] = lms((echo_total'), (Lin_Tx_Sig'));   %echo_total is echo and echo is
%[mumax, mumaxmse] = maxstep(dsp.LMSFilter, real(echo_total'))

% [mmse, emse, meanW, mse, traceK] = msepred(lms, real(echo_total), real(Lin_Tx_Sig), m);
% [simmse, meanWsim, Wsim, traceKsim] = msesim(lms, real(echo_total), real(Lin_Tx_Sig), m);


figure(1);
    plot([real(e) imag(e)], 'LineWidth', 1); grid on;
    legend('Real', 'Imag');
    title('Adaptation Error');
    xlabel('Time Index (Sample)');
    ylabel('Error Amplitude');
figure(2); 
    stem([real(w) imag(w)], 'LineWidth', 1); grid on;
    legend('Real', 'Imag')
    title('Filter Coefficient(s)')
    xlabel('Tap(s)');
    ylabel('Filter Coefficient')
figure(3)
    subplot(2,1,1)
    stem(delay, amp_db, 'LineWidth', 1, 'BaseValue', -110); grid on;
    title('Self-Interference Power Profile');
    xlabel('Time Index (Sample)');
    ylabel('Relative Power (dB)');
    subplot(2,1,2)
    stem(delay, atten_phase, 'LineWidth', 1); grid on;
    title('Self-Interference Phase Profile');
    xlabel('Time Index (Sample)');
    ylabel('Phase');