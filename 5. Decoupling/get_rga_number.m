function rga_number = get_rga_number(base_filename, params)
% GET_RGA_NUMBER Calculates the rga number given a simulink system model.
%   The rga number is a metric of input-output decoupling in a system.
%   Parameters:
%   -----------
%       base_filename : (string vector) first section of the name of the 
%                       simulink file with the system model.
%       params : (struct) Parameter structure with model parameters.
%   Return:
%   -------
%       rga_number : (double) rga number for the linearized system model.

    % Linearize Model of the system
    simulink_filename = base_filename + "_noControl";
    if params.ss_model == "linmod"
        [Alin,Blin,Clin,Dlin] = linmod(simulink_filename);
        sys_ss = ss(Alin,Blin,Clin,Dlin);
    elseif params.ss_model == "laminar"
        sys_ss = TwoTanks_ss_model(params.model);
    end
    
    Gtf = tf(sys_ss);
    G = dcgain(Gtf);
    
    % RGA
    RGA = rga(G);
    rga_number = sum(sum(abs(RGA - eye(size(RGA, 1)))));
end

