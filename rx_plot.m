outm35 = load('Rx_Power_Error_-35dBm_rev2.mat');
outm38 = load('Rx_Power_Error_-38dBm_rev2.mat');
outm41 = load('Rx_Power_Error_-41dBm_rev2.mat');
outm44 = load('Rx_Power_Error_-44dBm_rev2.mat');

plot(outm35.IP3, outm35.error_min,...
    outm38.IP3, outm38.error_min,...
    outm41.IP3, outm41.error_min,...
    outm44.IP3, outm44.error_min,...
    'LineWidth', 2);

yline(-84, '-c', {'Effective Noise Floor'}, 'LineWidth', 2)

title('RX OIP3 vs. Error Power')
xlabel('RX OIP3 with 32 dB Gain (dBm)')
ylabel('Error Power @ RX Input (dBm)')
legend('RX Input Power = -35 dBm', ...
    'RX Input Power = -38 dBm', ...
    'RX Input Power = -41 dBm', ...
    'RX Input Power = -44 dBm')
grid on;


