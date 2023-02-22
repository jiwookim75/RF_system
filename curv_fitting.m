clear;
t=0:0.01:2;
f=1;
y=sin(2*pi*f*t) + sin(4*pi*f*t);
phi=[ones(1,length(t)); y];
distortion = 1/10;
gain=4;
yd=tanh(y*distortion)/distortion * gain;
plot(yd)
%c=((phi*phi')^(-1))*(phi*yd')
error = (yd-c'*phi);
error=error*error'
gain=c(2)
dc_bias=c(1)