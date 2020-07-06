clc
clear all
close all
Fs = 1000; %Sampling frequency
fc = 100; %Carrier Frequency
fm = 10;  %Message Frequency
dt = 1/Fs;   %Sample period
t = 0:dt:1-dt;      %Time interval
m = sin(2*pi*fm*t); %message signal
subplot (3,1,1);
plot (t,m);
xlabel ('Time(s)');
ylabel ('Amplitude');
title ('Message Signal');
grid on
mh = imag(hilbert(m));
subplot (3,1,2);
plot (t,mh);
xlabel ('Time(s)');
ylabel ('Amplitude');
title ('Hilber Transform of Message Signal');
grid on
s = m.*cos(2*pi*fc*t) + mh.*sin(2*pi*fc*t);
subplot (3,1,3);
plot (t,s);
xlabel ('Time(s)');
ylabel ('Amplitude');
title ('Modulated Signal');
grid on
M = fftshift(fft(m));
MH = fftshift(fft(mh));
S = fftshift(fft(s));
f = -Fs/2:1:Fs/2-1;
figure
subplot(3,1,1)
plot(f,abs(M)/Fs);
title('Freq. Spectrum of Message Signal')
xlabel('Frequency (Hz)')
ylabel('Magnitude')
grid on
subplot(3,1,2)
plot(f,abs(S)/Fs);
title('Freq. Spectrum of Modulated Signal')
xlabel('Frequency (Hz)')
ylabel('Magnitude')
grid on
r_lo = s.*sin(2*pi*fc*t);
[b,a] = butter(10,2*fc/Fs);
r_flt = filter(b,a,r_lo);
R_flt = fftshift(fft(r_flt));
subplot(3,1,3)
plot(f,abs(R_flt)/Fs);
title('Freq. Spectrum of Demodulated Signal')
xlabel('Frequency (Hz)')
ylabel('Magnitude')
grid on
figure
plot(t,r_flt)
xlabel('Time(s)')
ylabel('Amplitude')
title('Demodulated Signal')
grid on