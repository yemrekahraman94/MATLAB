clear all
close all
Fs = 100000;          %sampling frequency. not to be confused with "sampling" in DSP.
dt = 1/Fs;          %sample period. 
t = 0:dt:1-dt;      %time interval
fm = 100;            %message frequency in Hz
fc = 10000;           %carrier frequency in Hz
a = 2;              %Amplitude of carrier
mod_index = 0.9;    %modulation index
m = sin(2*pi*fm*t); %message signal
s = a*(1 + (mod_index.*m)).*cos(2*pi*fc*t); %modulated signal
%let's see our message and modulated signal
subplot(2,1,1)
plot(t,m);
xlabel('Time(s)')
ylabel('Amplitude(v)')
title('Message Signal')
grid on
subplot(2,1,2)
plot(t,s);
xlabel('Time(s)')
ylabel('Amplitude(v)')
title('Modulated Signal')
grid on
M = fftshift(fft(m));
S = fftshift(fft(s));
f = -Fs/2:1:Fs/2-1;
figure
subplot(3,1,1)
plot(f,abs(M)/Fs);
title('Freq. Spectrum of Message')
xlabel('Frequency (Hz)')
ylabel('Magnitude')
grid on
subplot(3,1,2)
plot(f,abs(S)/Fs);
title('Freq. Spectrum of Modulated Signal')
xlabel('Frequency (Hz)')
ylabel('Magnitude')
grid on
r_env = abs(s);
[b,a] = butter(5,2*fc/Fs);
r_flt = filter(b,a,r_env);
R_flt = fftshift(fft(r_flt));
subplot(3,1,3)
plot(f,abs(R_flt)/Fs);
title('Freq. Spectrum of Demodulated Signal')
xlabel('Frequency (Hz)')
ylabel('Magnitude')
grid on
figure
subplot(2,1,1)
plot(t,r_env);
xlabel('Time(s)')
ylabel('Amplitude(v)')
title('Envelope of Modulated Signal')
grid on
subplot(2,1,2)
plot(t,r_flt)
xlabel('Time(s)')
ylabel('Amplitude(v)')
title('Demodulated Signal')
grid on