function cost = cost_2tank_iae(sim_filename, ctrl_params, parameter_vector, ...
                             target_params, ~, ref_mask)
% COST_ROV Evaluates the performance of a set of control parameters for the
% ROV
%   Details
    
    % Preliminaries
    parameter_vector(target_params) = table2array(ctrl_params);
    
    % Run Simulation
    simln = Simulink.SimulationInput(sim_filename);
    mdlWks = get_param(sim_filename,'ModelWorkspace');
    assignin(mdlWks,'PID_params', parameter_vector)
    out = sim(simln);

    % Calculate Performance
    cost = abs_error_4tank(out, ref_mask); % Can reuse 4tank error

end

