function [Model] = TwoTanks_Interact_Model(ctrl_gains, params)
%UNTITLED Summary of this function goes here
    %**************************************************************************
    model_params = params.model;
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
    % Plant Model
    Model.Process.StateEq=@(t,x,u)...
        [(-gamma1*k1*sqrt(2*g) - gamma12*k12)/A1*x(1) + gamma12*k12/A1*x(2) + kA/A1*u(1);
         gamma12*k12/A2*x(1) + (-gamma2*k2*sqrt(2*g) - gamma12*k12)/A2*x(2) + kB/A2*u(2)];
    Model.Process.OutputEq=@(t,x) [x(1); x(2)]; % fully measured plant
    Model.Process.Order = 2;

    % Control Model
    s=tf('s');
    % Controller 1
    Kp_1=ctrl_gains(1);
    Kd_1=ctrl_gains(3);
    filterbandwith=100;
    KLaplace_1 = Kp_1 + Kd_1*s/(s/filterbandwith+1); % Control tf
    U1 = ss(KLaplace_1);
    ControllerOrder = size(U1.A, 1);
    Model.Controller.StateEq=@(t,x,y) K.A*x+K.B*(-(y-pt_oper_y))
end

