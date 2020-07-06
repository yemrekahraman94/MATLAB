clc
clear all
close all
Fs = 1000; %Sampling frequency
fc = 100; %Carrier Frequency
fm = 10;  %Message Frequency
dt = 1/Fs;   %Sample period
t = 0:dt:1-dt;      %Time interval
a = 2;              %Amplitude of carrier
m = sin(2*pi*fm*t);
subplot (3,1,1);
plot (t,m);
xlabel ('Time(s)');
ylabel ('Amplitude');
title ('Message Signal');
grid on
c = a.*sin (2*pi*fc*t);
subplot (3,1,2);
plot (t,c);
xlabel ('Time(s)');
ylabel ('Amplitude');
title ('Carrier Signal');
grid on
s = a.*sin (2*pi*fm*t).*sin (2*pi*fc*t);
subplot (3,1,3);
plot (t,s);
xlabel ('Time(s)');
ylabel ('Amplitude');
title ('Modulated Signal');
grid on
M = fftshift(fft(m));
C = fftshift(fft(c));
S = fftshift(fft(s));
f = -Fs/2:1:Fs/2-1;
figure
subplot(4,1,1)
plot(f,abs(M)/Fs);
title('Freq. Spectrum of Message Signal')
xlabel('Frequency (Hz)')
ylabel('Magnitude')
grid on
subplot(4,1,2)
plot(f,abs(C)/Fs);
title('Freq. Spectrum of Carrier Signal')
xlabel('Frequency (Hz)')
ylabel('Magnitude')
grid on
subplot(4,1,3)
plot(f,abs(S)/Fs);
title('Freq. Spectrum of Modulated Signal')
xlabel('Frequency (Hz)')
ylabel('Magnitude')
grid on
r_lo = s.*c;
[b,a] = butter(5,2*fc/Fs);
r_flt = filter(b,a,r_lo);
R_flt = fftshift(fft(r_flt));
subplot(4,1,4)
plot(f,abs(R_flt)/Fs);
title('Freq. Spectrum of Demodulated Signal')
xlabel('Frequency (Hz)')
ylabel('Magnitude')
grid on
figure
plot(t,r_flt)
xlabel('Time(s)')
ylabel('Amplitude(v)')
title('Demodulated Signal')
grid on