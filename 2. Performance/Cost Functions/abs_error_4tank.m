function error = abs_error_4tank(sim_out, reference_mask, verbose)
% ABS_ERROR_PATH Calculates absolute error for a path following task.
%
%   Parameters:
%   -----------
%   sim_out  : (struct) of simulations outputs.
%   path_info : (struct) Information about the reference path.
%   verbose  : (boolean) 1 if the performance results are printed, 0
%              otherwise.
    
    % Default parameters
    if nargin < 3
        verbose = 0;
    end

    % Init
    y_time = sim_out.y.Time;
    y_data = sim_out.y.Data;
    path_time = sim_out.ref_path.Time;
    path_data = sim_out.ref_path.Data;
    ref_mask = logical(reference_mask);
    
    traj_data = y_data;

    abs_pervar_error = abs(path_data - traj_data);
    error_pretotal = sum(abs_pervar_error(:, ref_mask), 2); % L1 norm
    error = integral_trapezoidal(error_pretotal, path_time); 

    if verbose == 1
        fprintf('IAE: %0.2f.\n', error)
    end
end



