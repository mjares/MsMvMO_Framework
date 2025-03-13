function cost = cost_rov_path_etxiae(sim_filename, ctrl_params, parameter_vector, ...
                             target_params, ~, ref_mask)
% COST_ROV_PATH_IAE Evaluates the performance of a set of control 
% parameters for the ROV under a path following task.
%   Details
    
    % Preliminaries
    parameter_vector(target_params) = table2array(ctrl_params);
    
    % Run Simulation
    simln = Simulink.SimulationInput(sim_filename);
    mdlWks = get_param(sim_filename,'ModelWorkspace');
    assignin(mdlWks,'PID_params', parameter_vector)
    out = sim(simln);

    % Calculate Performance
    cost = etxabs_error_path(out, ref_mask);

end

