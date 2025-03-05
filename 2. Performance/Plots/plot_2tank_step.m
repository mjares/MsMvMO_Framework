function plot_2tank_step(sim_out, var_plot, plot_group, save_fig, save_folder)
% PLOT_STEP Plots individual variable responses for the ROV.
%           E.g.: plot_step(out, [1 0 0 0 0 1]) plots the 'x' and 'yaw'
%           responses.
%
%   Parameters:
%   -----------
%   sim_out  : (struct) of simulations outputs.
%   var_plot : (6 x 1 boolean vector) with 1 if the variables must be 
%              plotted and 0 otherwise. In order, the variables are: 
%              [x, y, z, roll, pitch, yaw].
%              If plot_group == "3&3" var_plot is interpreted as a 2 x 1
%              vector with [position, attitude] variable plots.
%   plot_group : (string) {"individual", "3&3"} defines whether the plots
%                will be presented in individual figures or grouped into 2 
%                figures of three plots separating position variables from 
%                attitude variables.
%   save_folder : (string) Path to the folder where figures will be saved.
%                 save_folder = " " if figure won't be saved.
    
    % Default parameters
    if nargin < 3
        plot_group = "individual";
    end
    if nargin < 4
        save_fig = 0;
        save_folder = " ";
    end

    % Style Prelims
    xlabel_fontsize = 18;
    ylabel_fontsize = 18;
    legend_fontsize = 15;
    ax_fontsize = 25;
    title_fontsize = 20;
    meas_linewidth = 9;
    ref_linewidth = 7;
    vline_linewidth = 3;

    % ==================== Plot ======================
    y_time = sim_out.y.Time;
    y_data = sim_out.y.Data;
    state_time = sim_out.states.Time;
    state_data = sim_out.states.Data;
    path_time = sim_out.ref_path.Time;
    path_data = sim_out.ref_path.Data;
    % waypoint_changes = get_waypoint_changes(sim_out);
    
    if plot_group == "individual"
        no_plots = sum(var_plot);
        plot_cell = {};
        % ========================  World Frame Position (XYZ)  ===========
        if var_plot(1) == 1  % y1
            plot_cell_ii.xaxis_data = y_time;
            plot_cell_ii.yaxis_data = y_data(:, 1);
            plot_cell_ii.yaxis_ref = path_data(:, 1);
            plot_cell_ii.legend = ["Y1", "Y1_{ref}"];
            plot_cell_ii.title = 'Tank 1';
            plot_cell_ii.ylabel = 'Level [cm]';
            plot_cell_ii.savefig_name = "Response_Y1";
            plot_cell = [plot_cell; plot_cell_ii];
        end
        if var_plot(2) == 1  % y2
            plot_cell_ii.xaxis_data = y_time;
            plot_cell_ii.yaxis_data = y_data(:, 2);
            plot_cell_ii.yaxis_ref = path_data(:, 2);
            plot_cell_ii.legend = ["Y2", "Y2_{ref}"];
            plot_cell_ii.title = 'Tank 2';
            plot_cell_ii.ylabel = 'Level [cm]';
            plot_cell_ii.savefig_name = "Response_Y2";
            plot_cell = [plot_cell; plot_cell_ii];
        end
        % Plotting
        for ii = 1:no_plots
            figure('Position', [0, 0, 1024, 768])
            pltii = plot_cell{ii};
            plot(pltii.xaxis_data, pltii.yaxis_data, "LineWidth", 8)
            hold on
            plot(path_time, pltii.yaxis_ref, '--', "LineWidth", 7)
            title(pltii.title)
            legend(pltii.legend)
            xlabel('Time [s]')
            ylabel(pltii.ylabel)
            set(gca, 'FontSize', 30, 'LabelFontSizeMultiplier', 1.3, ...
                'FontName', 'Times New Roman');
            % Save figure to folder
            if save_fig == 1
                saveas(gca, save_folder + pltii.savefig_name + ".png");
            end
        end
    end
    
    % ======================== Grouped Plots ==============================
    if plot_group == "group"
        if var_plot(1) == 1
            % ========================  World Frame Position (XYZ)  =======
            figure('Position', [0, 0, 1024, 768])
            % X1
            subplot(1,2,1)
            plot(state_time, state_data(:, 1), "LineWidth", meas_linewidth)
            hold on
            plot(path_time, path_data(:, 1), '--', "LineWidth", ref_linewidth)
            hold on
            % xline(waypoint_changes, "LineWidth", vline_linewidth)
            set(gca, "Fontsize", ax_fontsize)
            title('Tank 1', FontSize=title_fontsize)
            legend('X1', 'X1_{ref}', "Fontsize", legend_fontsize)
            xlabel('Time[s]', FontSize=xlabel_fontsize)
            ylabel('Level [cm]', FontSize=ylabel_fontsize)
            % X2
            subplot(1,2,2)
            plot(state_time, state_data(:, 2), "LineWidth", meas_linewidth)
            hold on
            plot(path_time, path_data(:, 2), '--', "LineWidth", ref_linewidth)
            hold on
            % xline(waypoint_changes, "LineWidth", vline_linewidth)
            set(gca, "Fontsize", ax_fontsize)
            title('Tank 2', FontSize=title_fontsize)
            legend('X2', 'X2_{ref}', "Fontsize", legend_fontsize)
            xlabel('Time[s]', FontSize=xlabel_fontsize)
            ylabel('Level [cm]', FontSize=ylabel_fontsize)
           
            if save_folder ~= " "
                if ~exist(save_folder, 'dir')
                    mkdir(save_folder)
                end
                saveas(gca, save_folder + "Position3x1.png");
            end
            % sgtitle('World Frame Position Tracking')
        end
    end
    if plot_group == "group_cross"
        if var_plot(1) == 1
            % ========================  World Frame Position (XYZ)  =======
            figure('Position', [0, 0, 1024, 768])
            % X1
            subplot(1,2,1)
            plot(state_time, state_data(:, 1), "LineWidth", meas_linewidth)
            hold on
            plot(path_time, path_data(:, 1), '--', "LineWidth", ref_linewidth)
            hold on
            plot(path_time, path_data(:, 2), '--', "LineWidth", ...
                ref_linewidth/2, "Color", [0, 1, 0, 0.4])
            % xline(waypoint_changes, "LineWidth", vline_linewidth)
            set(gca, "Fontsize", ax_fontsize)
            title('Tank 1', FontSize=title_fontsize)
            legend('X1', 'X1_{ref}', "Fontsize", legend_fontsize)
            xlabel('Time[s]', FontSize=xlabel_fontsize)
            ylabel('Level [cm]', FontSize=ylabel_fontsize)
            % X2
            subplot(1,2,2)
            plot(state_time, state_data(:, 2), "LineWidth", meas_linewidth)
            hold on
            plot(path_time, path_data(:, 2), '--', "LineWidth", ref_linewidth)
            hold on
            plot(path_time, path_data(:, 1), '--', "LineWidth", ...
                ref_linewidth/2, "Color", [0, 1, 0, 0.4])
            % xline(waypoint_changes, "LineWidth", vline_linewidth)
            set(gca, "Fontsize", ax_fontsize)
            title('Tank 2', FontSize=title_fontsize)
            legend('X2', 'X2_{ref}', "Fontsize", legend_fontsize)
            xlabel('Time[s]', FontSize=xlabel_fontsize)
            ylabel('Level [cm]', FontSize=ylabel_fontsize)
           
            if save_folder ~= " "
                if ~exist(save_folder, 'dir')
                    mkdir(save_folder)
                end
                saveas(gca, save_folder + "Position3x1.png");
            end
            % sgtitle('World Frame Position Tracking')
        end
    end
end

