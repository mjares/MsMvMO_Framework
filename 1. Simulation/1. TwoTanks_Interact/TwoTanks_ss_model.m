function [ss_model, model_info] = TwoTanks_ss_model(model_params, operating_point)
%GET_STATE_SPACE_MODEL Summary of this function goes here
%   Detailed explanation goes here
    if nargin < 2
        operating_point.x = [0, 0];
        operating_point.u = [0, 0];
    end 
    %**************************************************************************
    % Model Parameters
    A1 =  model_params.A1; % cm^2
    A2 =  model_params.A2; % cm^2 
    g = model_params.g; % cm/s^2
    
    %**************************************************************************
    % Valve Constants
    kA = model_params.valve_const.Valve_A;
    kB = model_params.valve_const.Valve_B;
    
    k1 = model_params.valve_const.Valve_1;
    k2 = model_params.valve_const.Valve_2;
    k12 = model_params.valve_const.Valve_12;
    
    %**************************************************************************
    % Valves Aperture
    gamma1 = model_params.gamma.Valve_1;
    gamma2 = model_params.gamma.Valve_2;
    gamma12 = model_params.gamma.Valve_12;
    
    % Assuming Laminar Flow
    model_info.flow = "Laminar";
    A = [(-gamma1*k1*sqrt(2*g) - gamma12*k12)/A1, gamma12*k12/A1;...
         gamma12*k12/A2                         , (-gamma2*k2*sqrt(2*g) - gamma12*k12)/A2];
    B = [kA/A1, 0;
         0    , kB/A2];
    C = eye(2);
    D = 0;
    ss_model = ss(A, B, C, D);
end

