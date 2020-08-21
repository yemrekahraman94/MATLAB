clear all
close all
Fs = 1000; %sampling frequency
dt = 1/Fs;
t = 0:dt:1-dt;
a = 2; %amplitude of carrier
fm = 10; %freq. of message signal
fc = 100; %freq. of carrier signal
delta_f = 100;
kf = delta_f/fm; %frequency sensitivity of the modulator / modulation index
m = cos(2*pi*fm*t);
m_b = tril(ones(length(m)));
m_c = m.*m_b;
sum_m = sum(m_c,2);
s = a*cos(2*pi*fc*t+(kf*2*pi*sum_m').*dt);
plot(t,s);
grid on
hold on
plot(t,m)
ylim([-5 5])
xlabel ('Time(s)');
ylabel ('Amplitude');
title('Message and Modulated Signal')
f = -Fs/2:1:Fs/2-1;
M = fftshift(fft(m));
S = fftshift(fft(s));
figure
plot(f,abs(M)/Fs);
title('Frequency Domain Representation of the Signals')
grid on
hold on
plot(f,abs(S)/Fs);
xlabel('Frequency (Hz)')
ylabel('Magnitude')
dem = diff(s);                 
dem = [0,dem];
r_lo = dem.*(cos(2*pi*fc*t));
[b,a] = butter(10,2*fc/Fs);
r_flt = filter(b,a,r_lo);
R_flt = fftshift(fft(r_flt));
figure()
plot(f,abs(R_flt)/Fs);
title('Frequency Representation of the Demodulated Signal')
xlabel('Frequency (Hz)')
ylabel('Magnitude')
grid on
figure()
plot(t,r_flt)
xlabel ('Time(s)');
ylabel ('Amplitude');
grid on
title('Demodulated Signal')