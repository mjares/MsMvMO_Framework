% A Parameters struct must be loaded into the workspace before running this
% initialization script.
%**************************************************************************
% Simulation Parameters
simulation_stop_time = Parameters.sim_maxtime;
% Initial Conditions/Operating Point
x0 = Parameters.model.state_0; % cm ??
u0 =  Parameters.model.control_0;

%**************************************************************************
% Model Parameters
plant_tf = Parameters.model.tf;

% Decoupling
if isfield(Parameters, "decoupling")
    decoupling_switch = Parameters.decoupling.activate_decoupling;
    KF1 = Parameters.decoupling.KF1;
    KF2 = Parameters.decoupling.KF2;
else
    decoupling_switch = 0;
    KF1 = 0;
    KF2 = 0;
end
