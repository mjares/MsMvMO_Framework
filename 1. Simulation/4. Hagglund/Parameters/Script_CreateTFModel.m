clear
clc

% model_filename = "Hylte_TFModel.mat";
% model_filename = "Polym_TFModel.mat";
model_filename = "QuadTank_TFModel.mat";

% Transfer Function Model
s = tf('s');
if model_filename == "Hylte_TFModel.mat"
    G11 = 1.8/(1 + 0.42*s)*exp(-2*s);
    G12 = -2.0/(1 + 0.90*s)*exp(-1.4*s);
    G21 = 0.41/(1 + 3*s)*exp(-2.64*s);
    G22 = 1.2/(1 + 3*s)*exp(-4*s);
elseif model_filename == "QuadTank_TFModel.mat"
    G11 = 2.6/(1 + 62*s);
    G12 = 1.5/((1 + 23*s)*(1 + 62*s));
    G21 = 1.4/((1 + 30*s)*(1 + 90*s));
    G22 = 2.8/(1 + 90*s);
elseif model_filename == "Polym_TFModel.mat"
    G11 = 22.89/(1 + 4.572*s)*exp(-0.2*s);
    G12 = -11.64/(1 + 1.807*s)*exp(-0.4*s);
    G21 = 4.689/(1 + 2.174*s)*exp(-0.2*s);
    G22 = 5.8/(1 + 1.801*s)*exp(-0.4*s);
end

sys_tf = [G11, G12; G21 G22];

save("1. Simulation/4. Hagglund/" + model_filename, "sys_tf")