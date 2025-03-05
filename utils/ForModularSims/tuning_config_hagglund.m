function [Config] = tuning_config_hagglund(model_name, stages, params)
%TUNING_CONFIG_2TANK Summary of this function goes here
        Config.model_name = model_name;
        Config.files.model_fname_base = extractBefore(model_name, 9);
        Config.files.model_fname_ctrl = "Hagglund_PI";
        Config.simulation.req_simulink = true;
        submodel = extractAfter(model_name, "_");
        Config.files.parameter_fname = "ParametersTemplate_" + submodel + "_Kp1i1d1";
        Config.files.save_fname_base = "TuningBO_" + submodel;       
        Config.files.save_fname_base = Config.files.save_fname_base + "_Kp1i1d1";
        save_fname_params = get_save_fname_params(Config.files.model_fname_base, ...
            params.coupling_param);
        % Decoupling
        if params.decoupling.activate_decoupling == 1
            Config.files.save_fname_base = Config.files.save_fname_base + ...
            "_Dec" + extractBefore(params.decoupling.decoupling_type, 5) + ...
            save_fname_params;
        end
        % Stages
        if stages == "full"
            Config.msframework.no_stages = 1;
            Config.msframework.target_params = logical([1, 1, 0, 1, 1, 0]);
            Config.msframework.ref_type = "path";
            Config.msframework.ref_mask = [1; 1];
            Config.files.save_fname_base = Config.files.save_fname_base + "_Path";
        elseif stages == "individual"
            Config.msframework.no_stages = 2;
            Config.msframework.target_params = logical([1, 1, 0, 0, 0, 0;
                                               0, 0, 0, 1, 1, 0]);
            Config.msframework.ref_type = "step";
            Config.msframework.ref_mask = [1, 0; 0, 1];
            Config.files.save_fname_base = Config.files.save_fname_base + "_Step";
        end
        % Filename
        Config.files.save_fname_base = Config.files.save_fname_base + ...
                                      "_" + save_fname_params + "_IAE_I";
        % Cost Function
        Config.cost_function = @cost_2tank_iae; % Can reuse 2tank_iae cost

        %% RGA Number and Decoupling
        Config.get_rga_number = @(x, y) 0;
end

