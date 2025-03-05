function cost = cost_2tank_iae_nosimu(~, ctrl_params, parameter_vector, ...
                             target_params, all_params, ref_mask)
% COST_ROV Evaluates the performance of a set of control parameters for the
% ROV
%   Details
    
    % Preliminaries
    parameter_vector(target_params) = table2array(ctrl_params);
    
    % Run Simulation
    out = TwoTank_Simulate_NoSimulink(parameter_vector, all_params);

    % Calculate Performance
    cost = abs_error_4tank(out, ref_mask); % Can reuse 4tank error

end

