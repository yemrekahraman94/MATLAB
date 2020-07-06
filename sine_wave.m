clear all
close all
Fs = 1000; %sampling frequency
t = 0:1/Fs:1-1/Fs;
fm = 10; % Hz
s = sin(2*pi*fm*t);
plot(t,s);
title('Signal on Time Domain')
xlabel('Time (s)')
ylabel('Volts')
grid on
S = fftshift(fft(s));
%f = 0:1/Fs:1-1/Fs;
f = -Fs/2:1:Fs/2-1;
figure
plot(f,abs(S)/Fs);
title('Frequency Spectrum of Signal')
xlabel('Frequency (Hz)')
ylabel('Magnitude')
grid on