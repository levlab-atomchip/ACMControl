N = 8.1e7; %atom number
Bset = -1.8; %Vset
E_0 = 0;
T = 69e-6; %K
% T = linspace(30e-6, 100e-6,1000);
m_f = 2;
g_f = 1/2;
P = 10;
w = 65e-6;

mu_b = 9.274009e-24; %J/T
k = 1.3806504e-23; %J/K
m = 1.443160e-25; %kg
g = 9.8; %m/s
hbar = 1.054571e-34; %J*s

E_0 = 1.53e-35 * P/(w*2);
temp_depth = E_0/k;
Bgrad = -1*Bset*119.2/100; %T/m
mu = m_f*g_f*mu_b;

% V = (32*pi*exp(-E_0/(k*T)))/(1-(m*g/(mu*Bgrad))^2)*(k*T/(mu*Bgrad))^3;

V = 32*pi*(k*T/(mu*Bgrad)).^3;
n = N ./ V;
lambda = sqrt((2*pi*hbar^2./(m*k*T)));
PSD =  n .*lambda.^3

%semilogy(T,PSD)