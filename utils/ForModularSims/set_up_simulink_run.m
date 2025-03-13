function set_up_simulink_run(Model, stage)
%SET_UP_SIMULINK_RUN Summary of this function goes here
%   Detailed explanation goes here
    if nargin < 2
        stage = 0;
    end

    if Model.model_name == "Two_Tanks"
        block_path = Model.files.model_fname_ctrl + "/Reference Signal Builder";
        if Model.msframework.ref_type == "step" && stage == 1
            active_scenario = "Step1";
        elseif Model.msframework.ref_type == "step" && stage == 2
            active_scenario = "Step2";
        elseif Model.msframework.ref_type == "path"
            active_scenario = "Path";
        end
        set_param(block_path, 'ActiveScenario', active_scenario);
        if Model.ss_model == "linmod"
            set_param(Model.files.model_fname_ctrl + "/TwoTanks", ...
                'ReferencedSubsystem', "TwoTanks_Sub")
        elseif Model.ss_model == "laminar"
            set_param(Model.files.model_fname_ctrl + "/TwoTanks", ...
                'ReferencedSubsystem', "TwoTanks_Sub_Laminar")
        end
    elseif Model.files.model_fname_base == "Hagglund"
        block_path = Model.files.model_fname_ctrl + "/Reference Signal Builder";
        if Model.msframework.ref_type == "step" && stage == 1
            active_scenario = "Step1";
        elseif Model.msframework.ref_type == "step" && stage == 2
            active_scenario = "Step2";
        elseif Model.msframework.ref_type == "path"
            active_scenario = "Path";
        end
        set_param(block_path, 'ActiveScenario', active_scenario);
    elseif Model.model_name == "Simu2Vita_ROV"
        % block_path = Model.files.model_fname_ctrl + "/Reference Signal Builder";
        % if Model.msframework.ref_type == "step" && stage == 1
        %     active_scenario = "Step1";
        % elseif Model.msframework.ref_type == "step" && stage == 2
        %     active_scenario = "Step2";
        % elseif Model.msframework.ref_type == "path"
        %     active_scenario = "Path";
        % end
        % set_param(block_path, 'ActiveScenario', active_scenario);
    end
end

