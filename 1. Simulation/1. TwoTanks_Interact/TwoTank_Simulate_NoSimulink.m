function [sim_out] = TwoTank_Simulate_NoSimulink(ctrl_gains, params)
%TWOTANK_SIMULATE_NOSIMULINK Summary of this function goes here

% We reserve 'p' as the variable describing the full 'state' variables for
% the odefun definition comprising states from the plant and the controller

%% Defining Odefun
% Building System Model (Plant + Control)

iXstates = 1:ProcessOrder; % index of plant state variables in the odefun states
iUstates = ProcessOrder + (1:ControllerOrder); % index of controler states in the odefun states
% Odefun definition
odefun= @(t, p) generic_odefun(t, p(iXstates), p(iUstates), Model);
%% Numerical Simulation
% Initial Conditions
x0 = [pi/30;0]; 
u0 = 0;
p0 = [x0; u0];
t_final = 6;
[T,P] = ode45(odefun, [0 t_final], p0, odeset('RelTol', 1e-6));

%% Output Formatting (For compatibility)
sim_out.y.Time = T;
sim_out.y.Data = P(iXstates, :); % Assuming fully measured states
% path_time = sim_out.ref_path.Time;
% path_data = sim_out.ref_path.Data;
end

