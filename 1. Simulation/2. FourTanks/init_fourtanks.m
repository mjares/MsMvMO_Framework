% By: Francisco J. Triveno Vargas
% Based in:
% "Distributed multiparametric model predictive control design
% for a quadruple tank process"
% V. Kirubakaran, T.K. Radhakrishnan, N. Sivakumaran


%**************************************************************************
% Initial Conditions/Operating Point
h(1) = 12.26; % cm ??
h(2) = 12.78; % cm ??
h(3) =  1.63; % cm ??
h(4) =  1.41; % cm ??

u0(1) =  2.9403;
u0(2) =  2.9732;

%**************************************************************************
% Model Parameters
A1 =  28; % cm^2 ??
A2 =  32; % cm^2 ??
A3 =  28; % cm^2 ??
A4 =  32; % cm^2 ??
g = 981; % cm/s^2

%**************************************************************************
% Valve Constants
kA=3.33; % 
kB=3.35;

k1=.071;
k2=.057;
k3=.071;
k4=.057;

%**************************************************************************
% Valves Aperture
gammaA = 0.6; %0.7;
gammaB = 0.6; %0.6;
gamma1 = 0.7;
gamma2 = 0.7;
gamma3 = 1.0;
gamma4 = 1.0;
%**************************************************************************