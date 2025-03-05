function [Config] = set_up_tuning_config(model_name, stages, params)
%SET_UP_SYSTEM_MODEL Summary of this function goes here
%   Detailed explanation goes here  
    if model_name == "Two_Tanks"
        Config = tuning_config_2Tank(stages, params);
        Config.model_name = model_name; 
    elseif extractBefore(model_name, 9) == "Hagglund"
        Config = tuning_config_hagglund(model_name, stages, params);
    end
end

