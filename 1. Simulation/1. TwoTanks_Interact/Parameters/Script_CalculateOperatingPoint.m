load ParametersTemplate_2Tank_Laminar.mat

ss_sys = TwoTanks_ss_model(Parameters.model);
findop(ss_sys, "x", [12.75; 12.8])