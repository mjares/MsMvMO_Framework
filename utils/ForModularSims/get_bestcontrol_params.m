function [best_control] = get_bestcontrol_params(ResultsList, Model)
%GET_BESTCONTROL_PARAMS Summary of this function goes here
%   Detailed explanation goes here
    if Model.model_name == "Two_Tanks"
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
    if Model.model_name == "Simu2Vita_ROV"
        if Model.msframework.ref_type == "step" % if tuned independently
            best_control = [table2array(ResultsList{4}.best_params), ... % roll controller
                            table2array(ResultsList{5}.best_params), ... % pitch controller
                            table2array(ResultsList{6}.best_params), ... % yaw controller
                            table2array(ResultsList{1}.best_params), ... % x controller
                            table2array(ResultsList{2}.best_params), ... % y controller
                            table2array(ResultsList{3}.best_params), ... % z controller
                            ];  
        elseif Model.msframework.ref_type == "path"  % if tuned simultaneously
            best_control = table2array(ResultsList{1}.best_params);
        end
        
    end
end

