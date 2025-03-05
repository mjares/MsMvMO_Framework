% Modelo lineal
simulink_filename = 'TwoTanks_Interact_noControl';
parameter_filename = 'ParametersTemplate_2Tank';
% [Alin,Blin,Clin,Dlin] = linmod('newFourTanks_a');

% Parameters
load(parameter_filename)
Parameters.model.gamma.Valve_12 = 0.750;  % Tank 1-2 interaction valve
% Model
[Alin,Blin,Clin,Dlin] = linmod(simulink_filename);
sys_ss = ss(Alin,Blin,Clin,Dlin);
Gtf = tf(sys_ss);
G = dcgain(Gtf);

% Static Decoupling
D_static = inv(G);

%% Dynamic decoupling
G11 = Gtf(1,1);
G12 = Gtf(1,2);
G21 = Gtf(2,1);
G22 = Gtf(2,2);
% Simplified Decoupling
D11 = tf(1);
D12 = -G12/G11;
D21 = -G21*G22;
D22 = tf(1);
D_simp = [D11, D12; D21, D22]
