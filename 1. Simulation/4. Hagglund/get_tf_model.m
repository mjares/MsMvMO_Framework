function [tf_model] = get_tf_model(params)
    %GET_TF_MODEL Summary of this function goes here
    %   Detailed explanation goes here
    load(params.model.filename);
    coupling_param = params.model.coupling_param;
    sys_tf(1,2) = sys_tf(1,2)*coupling_param;
    sys_tf(2,1) = sys_tf(2,1)*coupling_param;
    tf_model = sys_tf;
end

