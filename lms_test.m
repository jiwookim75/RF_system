rng(1000);
N = 16;     % Sample per cycle
K = 250;   % Time span
k = (1:K)';  % Time index
r = (rand(K,1) - 0.5)/2.886;  % Random signal
s = sin(2*pi*k/N);
x = s + r;
d = 2*cos(2*pi*k/N);

Ntap = 2;
mu = 0.1;
lms = dsp.LMSFilter('Length', Ntap,...
    'StepSize',mu,...
    'Method','LMS');
[y,e,w] = lms(x,d);

plot(e)
w