function D = get_decoupling_matrix(base_filename, decoupling, params)
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
    
    % Static Decoupling
    if decoupling == "Static"
        G = dcgain(Gtf);
        D = tf(inv(G));
    end
    
    %% Dynamic decoupling
    if decoupling == "Simplified"
        G11 = Gtf(1,1);
        G12 = Gtf(1,2);
        G21 = Gtf(2,1);
        G22 = Gtf(2,2);
        % Simplified Decoupling
        D11 = tf(1);
        D12 = -G12/G11;
        D21 = -G21/G22;
        D22 = tf(1);
        D = [D11, D12; D21, D22];
    end
end

