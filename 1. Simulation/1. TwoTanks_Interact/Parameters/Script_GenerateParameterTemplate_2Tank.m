clear
clc

parameter_filename = "ParametersTemplate_2Tank_Laminar";
% System Model
Parameters.model.name = "Two_Tanks";
Parameters.model.gamma = table;
Parameters.model.gamma.Valve_12 = 0.0;  % Tank 1-2 interaction valve
Parameters.model.gamma.Valve_1 = 0.8;  % Tank 1 drain valvle
Parameters.model.gamma.Valve_2 = 0.8;  % Tank 2 drain valvle
Parameters.model.valve_const = table;
Parameters.model.valve_const.Valve_A = 3.33; % Input Valve A (Tank 1)
Parameters.model.valve_const.Valve_B = 3.35; % Input Valve B (Tank 2)
Parameters.model.valve_const.Valve_12 = 2.0; % Interaction Valve
Parameters.model.valve_const.Valve_1 = 0.071/4; % Drain valve tank 1
Parameters.model.valve_const.Valve_2 = 0.057/4; % Drain valve tank 2
Parameters.model.state_0 = [12.75, 12.8]; 
Parameters.model.control_0 = [2.408; 1.929];
Parameters.model.A1 = 28; % cm^2
Parameters.model.A2 = 32; % cm^2
Parameters.model.g = 981; % cm/s^2;

% Simulation
Parameters.sim_maxtime = 1600;
% Reference
Parameters.reference.reference_type = "step";
Parameters.reference.step_signal = zeros(6, 1);
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
Parameters.tuning.parameter_ranges = [[0, 500]; [0, 100]; [0, 200]; ...
                                      [0, 500]; [0, 100]; [0, 200]; ...
                                     ];
Parameters.cost_threshold_list_ind = [0, 0];
Parameters.cost_threshold_list_path = 0;
Parameters.cost_threshold = 0;

% % Decoupling
% Parameters.decoupling.activate_decoupling = 0;

save("1. Simulation/1. TwoTanks_Interact/Parameters/" + parameter_filename + ".mat", "Parameters");
