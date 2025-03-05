function [best_control] = get_bestcontrol_params(ResultsList, Model)
%GET_BESTCONTROL_PARAMS Summary of this function goes here
%   Detailed explanation goes here
    if Model.model_name == "Two_Tanks" || ...
       Model.files.model_fname_base == "Hagglund"
        if Model.msframework.ref_type == "step" % if tuned independently
            best_control = [table2array(ResultsList{1}.best_params), ... % y1 controller
                            table2array(ResultsList{2}.best_params)];    % y2 controller
        elseif Model.msframework.ref_type == "path"  % if tuned simultaneously
            best_control = table2array(ResultsList{1}.best_params);
        end
        
    end
    if Model.files.model_fname_base == "Hagglund"
        if Model.msframework.ref_type == "step" % if tuned independently
            best_control = ResultsList{1}.best_control_config + ... % y1 controller
                           ResultsList{2}.best_control_config;    % y2 controller
        elseif Model.msframework.ref_type == "path"  % if tuned simultaneously
            best_control = ResultsList{1}.best_control_config;
        end
        
    end
end

