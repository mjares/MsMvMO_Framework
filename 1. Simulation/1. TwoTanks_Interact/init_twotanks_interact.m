% A Parameters struct must be loaded into the workspace before running this
% initialization script.
%**************************************************************************
% Simulation Parameters
simulation_stop_time = Parameters.sim_maxtime;
% Initial Conditions/Operating Point
h = Parameters.model.state_0; % cm ??
u0 =  Parameters.model.control_0;

%**************************************************************************
% Model Parameters
A1 =  Parameters.model.A1; % cm^2
A2 =  Parameters.model.A2; % cm^2 
g = Parameters.model.g; % cm/s^2

%**************************************************************************
% Valve Constants
kA = Parameters.model.valve_const.Valve_A;
kB = Parameters.model.valve_const.Valve_B;

k1 = Parameters.model.valve_const.Valve_1;
k2 = Parameters.model.valve_const.Valve_2;
k12 = Parameters.model.valve_const.Valve_12;

%**************************************************************************
% Valves Aperture
gamma1 = Parameters.model.gamma.Valve_1;
gamma2 = Parameters.model.gamma.Valve_2;
gamma12 = Parameters.model.gamma.Valve_12;

% Decoupling
if isfield(Parameters, "decoupling")
    decoupling_switch = Parameters.decoupling.activate_decoupling;
    decoupling_tf = Parameters.decoupling.decoupling_tf;
else
    decoupling_switch = 0;
    decoupling_tf = tf(eye(2));
end
