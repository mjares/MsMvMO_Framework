function [Config] = tuning_config_simu2vita(stages, params)
%TUNING_CONFIG_2TANK Summary of this function goes here
        Config.files.model_fname_base = "ROV";
        Config.files.model_fname_ctrl = "ROV_Simulator";
        Config.files.parameter_fname = 'ParametersTemplate_ROV.mat';
        Config.files.save_fname_base = "Tuning_BO_ROV";
        Config.simulation.req_simulink = true;
        Config.files.save_fname_base = Config.files.save_fname_base;
        % Stages
        if stages == "full"
            Config.msframework.no_stages = 1;
            Config.msframework.target_params = true(1, 18);
            Config.msframework.fixed_params = false(1, 18);
            Config.msframework.ref_type = "path";
            Config.msframework.ref_mask = [1; 1; 1; 1; 1; 1];
            Config.sim_maxtime = 100;
            Config.files.save_fname_base = Config.files.save_fname_base + "_Path_etxIAE";
        elseif stages == "individual"
            Config.msframework.no_stages = 6;
            Config.sim_maxtime = 20;
            Config.msframework.target_params = logical([zeros(1, 9), 1, 1, 1, zeros(1, 6);
                                                        zeros(1, 12), 1, 1, 1, zeros(1, 12);
                                                        zeros(1, 15), 1, 1, 1; ...
                                                        1, 1, 1, zeros(1, 15);
                                                        zeros(1, 3), 1, 1, 1, zeros(1, 12);
                                                        zeros(1, 6), 1, 1, 1, zeros(1, 9)]);
            Config.msframework.fixed_params = logical([zeros(1, 18);
                                                       zeros(1, 18);
                                                       zeros(1, 18);
                                                       zeros(1, 9), ones(1, 9);
                                                       zeros(1, 9), ones(1, 9);
                                                       zeros(1, 9), ones(1, 9)]);
            Config.msframework.ref_type = "step";
            Config.msframework.ref_mask = eye(6); %% Fix this
            Config.files.save_fname_base = Config.files.save_fname_base + "_Step_IAE";
        end
        % Filename
        Config.files.save_fname_base = Config.files.save_fname_base + "_I";
        % Cost Function
        Config.cost_function = @cost_rov_path_etxiae;

end

