%clear all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Signal Load
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Tx_signal = 'Tx_Signals_LRR_MRR_SRR.mat';
% load(Tx_signal);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Signal matrix serization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Lin_Tx_LRR = Tx_Sig_LRR(:);
% Lin_Tx_MRR = Tx_Sig_MRR(:);
% Lin_Tx_SRR = Tx_Sig_SRR(:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Baseband Writer for Simulink
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fname = 'Tx_LRR_5dB_PAPR.bb';
fs = 460e6; % 115MHz x 4
fc = 0; % Baseband signal

bbw = comm.BasebandFileWriter(fname, fs, fc);
Lin_LRR = Tx_Sig_LRR(:,1200:1455);
Lin_LRR = Lin_LRR(:);
bbw(Lin_LRR);
release(bbw)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   CCDF
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pm_LRR = powermeter(ComputeCCDF=true);
% pm_LRR(Lin_Tx_LRR);
% pm_MRR = powermeter(ComputeCCDF=true);
% pm_MRR(Lin_Tx_MRR);
% pm_SRR = powermeter(ComputeCCDF=true);
% pm_SRR(Lin_Tx_SRR);

% hold on;
% plotCCDF(pm_LRR, GaussianReference=true)
% plotCCDF(pm_MRR, GaussianReference=true)
% plotCCDF(pm_SRR, GaussianReference=true)

% plotCCDF(pm_LRR);
% hold on;
% plotCCDF(pm_MRR);
% hold on;
% plotCCDF(pm_SRR);
% plotCCDF(pm_SRR, GaussianReference=true);
% legend('LRR', 'MRR', 'SRR')
