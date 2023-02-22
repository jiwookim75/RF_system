clear all
model = 'C:\Users\Jiwoo Kim (C)\Documents\workaround\RF System Design\simulink\RF_system\Rx_System';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Simulink Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
OS = 4  % Oversampling factor
sample_time=1/(115e6 * OS);
carriers.LO = 22.57e9;
carriers.LOL = carriers.LO/2;
carriers.LOH = carriers.LO*3;
carriers.OUT = carriers.LO*3.5;

%Put all carriers in one vector for convenience
car_env = unique(structfun(@deal,carriers));


% Lower limit of frequency (governed by impulse duration):
Duration = sample_time*128;
LLFreq = 1/Duration;


%Upper limit of frequency (governed by sample time):
ULFreq = 1/(2*sample_time);


% Generate 1/f phase noise with -60dBc/Hz level @ 1KHz:
%PhNoOffsets = [LLFreq 1e3 ULFreq];
%PhNoLevels = -40-10*log10(PhNoOffsets/1e3);

% PN characteristics from LMX2595 20 GHz PN
%PhNoOffsets = [100 1e3 10e3 100e3 1e6 10e6 40e6 95e6 100e6];
%PhNoLevels = [-82.8 -92.2 -100.9 -104.1 -116.5 -140.5 -147.2 -147.7 -147.7];

% PN for 22 GHz
PhNoOffsets_LOL = [100 1e3 10e3 100e3 1e6 10e6 40e6];
PhNoLevels_LOL = [-80.8938  -90.2938  -98.9938 -102.1938 -114.5938 -138.5938 -145.2938];

% PN for 66 GHz
PhNoOffsets_LOH = [100 1e3 10e3 100e3 1e6 10e6 40e6];
PhNoLevels_LOH = [-72.4297  -81.8297  -90.5297  -93.7297 -106.1297 -130.1297 -136.8297];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


load_system(model);

IP3 = (40:-5:0);
Gain = (1.5: -0.01: 0.5);
Error = zeros(length(IP3), length(Gain))
min_err = zeros(length(IP3), 1)

for n = 1:length(IP3)
    MyIP3 = IP3(n)
    %MyIP3 = 20
    for j = 1:length(Gain)
        G_error = Gain(j);
        out = sim(model);
        Error(n, j) = out.error.signals.values
    end
    min_err(n) = min(Error(n, :))
end

IP3 = flip(IP3);
min_err = flip(min_err);

save('Rx_Power_Error_15dBm.mat', 'Error', 'min_err');

plot(IP3, min_err, '-o', LineWidth=2)
grid on;

title('RX OIP3 vs. Error Power')
xlabel('OIP3 (dBm)');
ylabel('Error Power (dBm)');
