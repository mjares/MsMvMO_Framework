function plot_hylte(sim_out, x_limits, y_limits)
%PLOT_HYLTE Summary of this function goes here
%   Detailed explanation goes here
    % Style Prelims
    xlabel_fontsize = 18;
    ylabel_fontsize = 18;
    legend_fontsize = 15;
    ax_fontsize = 25;
    title_fontsize = 20;
    meas_linewidth = 9;
    ref_linewidth = 7;
    % y_limits = [-0.5, 1.5];
    
    % ==================== Plot ======================
    y_time = sim_out.y.Time;
    y_data = sim_out.y.Data;
    state_time = sim_out.states.Time;
    state_data = sim_out.states.Data;
    path_time = sim_out.ref_path.Time;
    path_data = sim_out.ref_path.Data;
    % waypoint_changes = get_waypoint_changes(sim_out);

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
    ylim(y_limits)
    xlim(x_limits);
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
    ylim(y_limits)
    xlim(x_limits);
    % if save_folder ~= " "
    %     if ~exist(save_folder, 'dir')
    %         mkdir(save_folder)
    %     end
    %     saveas(gca, save_folder + "Position3x1.png");
    % end
    % sgtitle('World Frame Position Tracking')
end

