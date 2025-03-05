clc
clear
sim_filename = "Hylte_PI";
save_results = 1;
simulation_stop_time = 100;
plotting = [1 1 0];
sys_ss = Hylte_tf_model();
decoupling_switch = 1;
% findop(ss(sys_ss), "y", [40; 60])
%% Hylte
% PID_params = [0.185, 0.185/1.087, 0, 0.278, 0.278/4.333, 0];
% x0 = [30; 50];
% u0 = [0;0];
% KF1 = 1.05;
% KF2 = -0.294;
% simulation_stop_time = 150;
%% QuadTank
% PID_params = [0.385, 0.385/62, 0, 0.357, 0.357/90, 0]; % QuadTank
% x0 = [0; 0];
% u0 = [0; 0];
% KF1 = -0.577;
% KF2 = -0.5;
% simulation_stop_time = 2000;
%% Polymerization Reactor
PID_params = [0.0419, 0.0419/4.572, 0, 0.1411, 0.1411/1.801, 0];
x0 = [0; 0];
u0 = [0;0];
KF1 = 0.5085; % Used this
KF2 = -0.8084; % Used this
% KF1 = 0.6437;
% KF2 = -5.9293;
% simulation_stop_time = 100;
if decoupling_switch == 1
    PID_params = PID_params*(1 - KF1*KF2);
end
simln = Simulink.SimulationInput(sim_filename);
mdlWks = get_param(sim_filename, 'ModelWorkspace');
assignin(mdlWks, 'PID_params', PID_params)
out = sim(simln);
 
if plotting(1) == 1
        plot_hylte(out, [0, 100], [-0.2, 1.2]);
end
% Plotting control variables
if plotting(2) == 1
    plot_2tank_u(out)
end
if plotting(3) == 1
    plot_2tank_u(out, "Decoupling")
end
if save_results
    save("Polym_Decoup", "out")
end