function plot_4tank_u(sim_out)
%PLOT_4TANK_U Summary of this function goes here
%   Detailed explanation goes here
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
    u_time = sim_out.u.Time;
    u_data = sim_out.u.Data;

    % ========================  World Frame Position (XYZ)  =======
    figure('Position', [0, 0, 1024, 768])
    % X3
    subplot(1,2,1)
    plot(u_time, u_data(:, 1), "LineWidth", meas_linewidth)
    % xline(waypoint_changes, "LineWidth", vline_linewidth)
    set(gca, "Fontsize", ax_fontsize)
    title('Pump A', FontSize=title_fontsize)
    xlabel('Time[s]', FontSize=xlabel_fontsize)
    ylabel('Flow [?]', FontSize=ylabel_fontsize)
    % Y
    subplot(1,2,2)
    plot(u_time, u_data(:, 2), "LineWidth", meas_linewidth)
    % xline(waypoint_changes, "LineWidth", vline_linewidth)
    set(gca, "Fontsize", ax_fontsize)
    title('Pump B', FontSize=title_fontsize)
    xlabel('Time[s]', FontSize=xlabel_fontsize)
    ylabel('Flow [?]', FontSize=ylabel_fontsize)
end

