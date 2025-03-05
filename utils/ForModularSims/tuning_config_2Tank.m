function [Config] = tuning_config_2Tank(stages, params)
%TUNING_CONFIG_2TANK Summary of this function goes here
        Config.simulation.method = params.simulation_method;
        Config.files.model_fname_base = "TwoTanks_Interact";
        Config.files.model_fname_ctrl = "TwoTanks_Interact_PID";
        Config.files.parameter_fname = 'ParametersTemplate_2Tank_Laminar.mat';
        Config.files.save_fname_base = "Tuning_BO_2Tank_";
        if params.simulation_method == "Laminar_NoSimulink"
            Config.files.save_fname_base = Config.files.save_fname_base + "LamNoSimu";
            Config.simulation.req_simulink = false;
        else
            Config.files.save_fname_base = Config.files.save_fname_base + "Laminar";
            Config.simulation.req_simulink = true;
        end
        Config.files.save_fname_base = Config.files.save_fname_base + "_Kp500i100d200";
        save_fname_params = get_save_fname_params(model_name, ...
            params.valve_aperture);
        % Decoupling
        if params.decoupling.activate_decoupling == 1
            Config.files.save_fname_base = Config.files.save_fname_base + ...
            "_Dec" + extractBefore(params.decoupling.decoupling_type, 5) + ...
            save_fname_params;
        end
        % Stages
        if stages == "full"
            Config.msframework.no_stages = 1;
            Config.msframework.target_params = true(1, 6);
            Config.msframework.ref_type = "path";
            Config.msframework.ref_mask = [1; 1];
            Config.sim_maxtime = 1600;
            Config.files.save_fname_base = Config.files.save_fname_base + "_Path";
        elseif stages == "individual"
            Config.msframework.no_stages = 2;
            Config.sim_maxtime = 400;
            Config.msframework.target_params = logical([1, 1, 1, 0, 0, 0;
                                               0, 0, 0, 1, 1, 1]);
            Config.msframework.ref_type = "step";
            Config.msframework.ref_mask = [1, 0; 0, 1];
            Config.files.save_fname_base = Config.files.save_fname_base + "_Step";
        end
        % Filename
        Config.files.save_fname_base = Config.files.save_fname_base + ...
                                      "_" + save_fname_params + "_IAE_I";
        % Cost Function
        
        if params.simulation_method == "Laminar_NoSimulink"
            Config.cost_function = @cost_2tank_iae_nosimu;
        else
            Config.cost_function = @cost_2tank_iae;
        end
        % System State Space Model
        % Model.ss_model_function = @TwoTanks_ss_model;
        %% RGA Number & Decoupling
        Config.get_rga_number = @get_rga_number;
        Config.get_decoupling_matrix = @get_decoupling_matrix;
end

