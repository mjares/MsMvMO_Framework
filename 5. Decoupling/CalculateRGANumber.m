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

% RGA
RGA = rga(G)
RGA_number = sum(sum(abs(RGA - eye(size(RGA, 1)))))

