clear
clc
gamma12 = 0.75;  % Tank 1-2 interaction valve
gamma1 = 0.8;  % Tank 1 drain valvle
gamma2 = 0.8;  % Tank 2 drain valvle
kA = 3.33; % Input Valve A (Tank 1)
kB = 3.35; % Input Valve B (Tank 2)
k12 = 2.0; % Interaction Valve
k1 = 0.071; % Drain valve tank 1
k2 = 0.057; % Drain valve tank 2
g = 981;
Q1max = 10.4895;
Q2max = 10.5525;
syms h1 h2;
% qout1 = gamma1*k1*sqrt(2*g*h1) + gamma12*k12*(h1-h2) - Q1max
% sol = solve(qout1, h2)
% double(sol)
% double(subs(qout1, h1, double(sol)))

% fplot(qout1, [0, 15])

% syms h1 h2;
% qout2 = gamma2*k2*sqrt(2*g*11.5) + gamma12*k12*(11.5-h1) - Q2max
% sol = solve(qout2, h1)
% double(sol)
% double(subs(qout2, h1, double(sol)))
% 
% fplot(qout2, [0, 15])

%%
h1diffmax = (Q1max - gamma1*k1*sqrt(2*g*h1))/(gamma12*k12);
h1 = 13;
double(subs(h1diffmax))

% h2diffmax = (Q2max - gamma2*k2*sqrt(2*g*h2))/(gamma12*k12);
% h2 = 11;
% double(subs(h2diffmax))