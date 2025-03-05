% This script tunes a controller (or set of controllers) using Matlab's
% bayesopt() method, given a cost function tune_objective().

%% Memory and System Preliminaries
clear
clc
clear('tempdir') % To avoid C drive temp file overflow.
newTempDir = 'D:\Temp';
setenv('tmp', newTempDir);
Simulink.sdi.setAutoArchiveMode(true) % To reduce temp file generation.
Simulink.sdi.setArchiveRunLimit(0)
%% General Simulation Parameters
verbose = 1; % Print updates on the simulation process
save_results = 1; % Save optimization results
calculate_rga_number = 1;
cost_threshold = 0;
iterations = 1000;
no_runs = [1 5];
%% System Model
model_name = "Hagglund_Hylte";
stages = "individual";  % "full" or "individual"
activate_decoupling = 0;
coupling_param = 1.0;
% model_params
model_params.simulation_method = "Laminar_NoSimulink123";
model_params.decoupling.activate_decoupling = activate_decoupling;
model_params.decoupling.decoupling_type = "Hagglund"; % Ignored if activate_dec = 0
model_params.coupling_param = coupling_param;  % coupling valve aperture \in [0, 1]
model_params.decoupling.decoupling_valve_aperture = coupling_param;
% model_params.decoupling.decoupling_tf = tf(eye(2));  % placeholder
% Get model struct
Config = set_up_tuning_config(model_name, stages, model_params);
if Config.simulation.req_simulink == true
    open_system(Config.files.model_fname_ctrl)
end

for rr = no_runs(1):no_runs(2)
    save_results_filename = Config.files.save_fname_base + string(iterations) +"_" + string(rr);
    %% Simulation Preliminaries
    load(Config.files.parameter_fname)
    % Reference
    Parameters.reference.reference_type = Config.msframework.ref_type;
    Parameters.cost_threshold = cost_threshold;
    Parameters.reference.path.reference_mask = Config.msframework.ref_mask;
    Parameters.model.coupling_param = coupling_param;
    % Parameters.sim_maxtime = Config.sim_maxtime;
    FullResultsBO.ResultsBO = cell(1, Config.msframework.no_stages);
    %% System Model
    if Config.files.model_fname_base == "Hagglund"
        Parameters.model.tf = get_tf_model(Parameters);
    end

    %% Calculate RGA number
    if calculate_rga_number == 1 
        FullResultsBO.rga_number = Config.get_rga_number( ...
                Config.files.model_fname_base, Parameters);
    end
    %% Get Decoupling Matrix
    if activate_decoupling == 1 & model_name ~= "ROV"
        model_params.decoupling.decoupling_tf = ...
        Config.get_decoupling_matrix(Config.files.model_fname_base, ...
        model_params.decoupling.decoupling_type, Parameters);
        Parameters.decoupling = model_params.decoupling;
    end
    for ss = 1:Config.msframework.no_stages
        target_parameters = Config.msframework.target_params(ss, :);
        ref_mask = Config.msframework.ref_mask(:, ss);
        % Parameters.autotuning_settings = Sttng;
        set_up_simulink_run(Config, ss);
        %% Bayesopt prelims
        acquisition_function = 'expected-improvement-plus';
        % Control parameter vector
        cparams_names = Parameters.tuning.parameter_names(target_parameters);
        cparams_ranges = Parameters.tuning.parameter_ranges(target_parameters, :);
        Parameters.tuning.target_parameter = target_parameters;
        no_params = length(cparams_names);
        ctrl_params = [];  % How to preallocate optimizableVariables?
        for ii = 1:no_params
            ctrl_params_ii = optimizableVariable(cparams_names(ii), ...
                cparams_ranges(ii, :), 'Type', 'real');
            ctrl_params = [ctrl_params ctrl_params_ii]; %#ok<*AGROW>
        end
        % Objective function
        tune_objective = @(x)Config.cost_function(Config.files.model_fname_ctrl, x, ...
                                          Parameters.controller, ...
                                          target_parameters, ...
                                          Parameters, ref_mask); 
                                          
                                          
        % Stop Criteria
        stop_function = @(x, y)stop_threshold(x, y, Parameters.cost_threshold);
        %% Bayesian Optimization Search
        bo_results = bayesopt(tune_objective, ctrl_params, ...
            'MaxObjectiveEvaluations', iterations, ...
            'AcquisitionFunctionName', acquisition_function, ...
            'PlotFcn', [], 'OutputFcn', stop_function);
        %% Log Results
        ResultsBO.target_params = target_parameters;
        ResultsBO.ref_mask = ref_mask;
        ResultsBO.acquisition_function = acquisition_function;
        ResultsBO.best_control_config = Parameters.controller;
        ResultsBO.bo_results = bo_results;
        ResultsBO.best_params = bo_results.XAtMinObjective;
        ResultsBO.best_cost = bo_results.MinObjective;
        ResultsBO.cost_evolution = bo_results.ObjectiveMinimumTrace;
        ResultsBO.best_control_config(target_parameters) =... 
                                            table2array(ResultsBO.best_params); 
        ResultsBO.times.time_list = bo_results.ObjectiveEvaluationTimeTrace;
        ResultsBO.times.total_time = sum( ...
            ResultsBO.bo_results.ObjectiveEvaluationTimeTrace);
        ResultsBO.no_iterations = bo_results.NumObjectiveEvaluations;
        ResultsBO.iteration_at_best = find(ResultsBO.bo_results.ObjectiveTrace ... 
                                            == ResultsBO.bo_results.MinObjective, ...
                                            1, 'first');
        FullResultsBO.ResultsBO{ss} = ResultsBO;
    end
    FullResultsBO.params = Parameters;
    FullResultsBO.config = Config;
    FullResultsBO.best_control_config = get_bestcontrol_params( ...
                                        FullResultsBO.ResultsBO, Config);
    if save_results == 1
        save("3. Results/2. Tuning/" + save_results_filename, "FullResultsBO")
    end
end