clear
clc

parameter_filename = "ParametersTemplate_Hylte_Kp1i1d1";
% System Model
Parameters.model.name = "Hylte_Paper_Mill";
Parameters.model.filename = "Hylte_TFModel";
Parameters.model.state_0 = [30; 50];
Parameters.model.control_0 = [0; 0];
% Simulation
Parameters.sim_maxtime = 150;
% Reference
Parameters.reference.reference_type = "step";
Parameters.reference.path.reference_mask = zeros(2, 1);
% Controllers
Parameters.controller = [0 0 0 ... % y1
                         0 0 0 ... % y2
                        ];
% Optimization
Parameters.tuning.parameter_names = [   "kp_y1"    "ki_y1"    "kd_y1" ... 
                                        "kp_y2"    "ki_y2"    "kd_y2" ...
                                      ];
Parameters.tuning.target_parameter = logical(...
                                     [0    0    0 ...
                                      0    0    0 ...
                                      ]);
Parameters.tuning.parameter_ranges = [[0, 1]; [0, 1]; [0, 1]; ...
                                      [0, 1]; [0, 1]; [0, 1]; ...
                                     ];
Parameters.cost_threshold_list_ind = [0, 0];
Parameters.cost_threshold_list_path = 0;
Parameters.cost_threshold = 0;

% % Decoupling
% Parameters.decoupling.activate_decoupling = 0;

save("1. Simulation/4. Hagglund/Parameters/" + parameter_filename + ".mat", "Parameters");
