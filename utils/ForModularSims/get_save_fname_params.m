function save_fname_params = get_save_fname_params(model_name,params)
%GET_SAVE_FNAME_PARAMS Summary of this function goes here
%   Detailed explanation goes here
    if model_name == "Two_Tanks" || model_name == "Hagglund"
        if params < 1
            save_fname_params = "G0" + string(100*params);
        else
            save_fname_params = "G" + string(100*params);
        end
    end
end

