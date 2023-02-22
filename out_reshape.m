IP3 = (-10:30);
G_error = (0.8:0.01:1.2);

error_tmp = zeros(length(IP3),length(G_error));
ee = size(out);

Len_out  = length(out);
for idx = 1:Len_out
    ee(idx) = out(1,idx).error.signals.values;
end

error_tmp = reshape(ee,[], 41)';
% error_tmp = reshape(ee,[], 31);

for i=1:length(IP3)
    error_min(i) = min(error_tmp(:,i));
%     plot(error_tmp(i,:))
    hold on;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% For RX Input
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
error_min = error_min - 46; % @ RX Input: 32 dB Gain + 14 dB NF;

hold on;
plot(IP3,error_min, 'LineWidth', 2)
title('RX OIP3 vs. Error Power')
xlabel('RX OIP3 with 32 dB Gain (dBm)')
ylabel('Error Power @ RX Input (dBm)')

save('Rx_Power_Error_-44dBm_rev2.mat', "IP3", "error_min");