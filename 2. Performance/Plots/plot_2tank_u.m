function plot_2tank_u(sim_out, plot_instructions)
%PLOT_4TANK_U Summary of this function goes here
%   Detailed explanation goes here
    
    if nargin < 2
        plot_instructions = "Regular";
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
    ref_transparency = 0.4;
    y_limits = [-50, 50];

    if plot_instructions == "Regular"
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
    elseif plot_instructions == "Decoupling"
        % ==================== Plot ======================
        u_time = sim_out.u.Time;
        u_post_pid_data = sim_out.u_post_pid.Data;
        u_post_dec_data = sim_out.u_post_dec.Data;
        path_data = sim_out.ref_path.Data;
    
        % ========================  World Frame Position (XYZ)  =======
        figure('Position', [0, 0, 1024, 768])
        % X3
        subplot(2,2,1)
        plot(u_time, u_post_pid_data(:, 1), "LineWidth", meas_linewidth)
        hold on 
        yyaxis right
        plot(u_time, path_data(:, 1), "LineWidth", meas_linewidth/2, ...
            "Color", [1, 0, 0, ref_transparency]);
        hold on
        plot(u_time, path_data(:, 2), "LineWidth", meas_linewidth/2, ...
            "Color", [0, 1, 0, ref_transparency]);
        % xline(waypoint_changes, "LineWidth", vline_linewidth)
        yyaxis left
        set(gca, "Fontsize", ax_fontsize)
        title('Pump A Pre-Decoupling', FontSize=title_fontsize)
        xlabel('Time[s]', FontSize=xlabel_fontsize)
        ylabel('Flow [?]', FontSize=ylabel_fontsize)
        ylim(y_limits)
        % Y
        subplot(2,2,2)
        plot(u_time, u_post_pid_data(:, 2), "LineWidth", meas_linewidth)
        hold on 
        yyaxis right
        plot(u_time, path_data(:, 1), "LineWidth", meas_linewidth/2, ...
            "Color", [1, 0, 0, ref_transparency]);
        hold on
        plot(u_time, path_data(:, 2), "LineWidth", meas_linewidth/2, ...
            "Color", [0, 1, 0, ref_transparency]);
        yyaxis left
        % xline(waypoint_changes, "LineWidth", vline_linewidth)
        set(gca, "Fontsize", ax_fontsize)
        title('Pump B Pre-Decoupling', FontSize=title_fontsize)
        xlabel('Time[s]', FontSize=xlabel_fontsize)
        ylabel('Flow [?]', FontSize=ylabel_fontsize)
        ylim(y_limits)
        % X3
        subplot(2,2,3)
        plot(u_time, u_post_dec_data(:, 1), "LineWidth", meas_linewidth)
        hold on 
        yyaxis right
        plot(u_time, path_data(:, 1), "LineWidth", meas_linewidth/2, ...
            "Color", [1, 0, 0, ref_transparency]);
        hold on
        plot(u_time, path_data(:, 2), "LineWidth", meas_linewidth/2, ...
            "Color", [0, 1, 0, ref_transparency]);
        % xline(waypoint_changes, "LineWidth", vline_linewidth)
        yyaxis left
        set(gca, "Fontsize", ax_fontsize)
        title('Pump A Post-Decoupling', FontSize=title_fontsize)
        xlabel('Time[s]', FontSize=xlabel_fontsize)
        ylabel('Flow [?]', FontSize=ylabel_fontsize)
        ylim(y_limits)
        % Y
        subplot(2,2,4)
        plot(u_time, u_post_dec_data(:, 2), "LineWidth", meas_linewidth)
        hold on 
        yyaxis right
        plot(u_time, path_data(:, 1), "LineWidth", meas_linewidth/2, ...
            "Color", [1, 0, 0, ref_transparency]);
        hold on
        plot(u_time, path_data(:, 2), "LineWidth", meas_linewidth/2, ...
            "Color", [0, 1, 0, ref_transparency]);
        yyaxis left
        % xline(waypoint_changes, "LineWidth", vline_linewidth)
        set(gca, "Fontsize", ax_fontsize)
        title('Pump B Post-Decoupling', FontSize=title_fontsize)
        xlabel('Time[s]', FontSize=xlabel_fontsize)
        ylabel('Flow [?]', FontSize=ylabel_fontsize)
        ylim(y_limits)
    end


