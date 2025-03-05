function cost = cost_4tank_path_iae(ctrl_params, parameter_vector, ...
                             target_params, path_info)
% COST_ROV Evaluates the performance of a set of control parameters for the
% ROV
%   Details
    
    % Preliminaries
    parameter_vector(target_params) = table2array(ctrl_params);
    
    % Run Simulation
    sim_filename = "FourTanks_PID";
    simln = Simulink.SimulationInput(sim_filename);
    mdlWks = get_param(sim_filename,'ModelWorkspace');
    assignin(mdlWks,'PID_params', parameter_vector)
    out = sim(simln);

    % Calculate Performance
    cost = abs_error_path_4tank(out, path_info);

end

