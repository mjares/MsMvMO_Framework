function plot_2tank_flow(sim_out, plot_instructions)
%PLOT_4TANK_U Summary of this function goes here
%   Detailed explanation goes here
    
    if nargin < 2
        plot_instructions = "Regular";
    end

    % Style Prelims
    xlabel_fontsize = 13;
    ylabel_fontsize = 13;
    legend_fontsize = 10;
    ax_fontsize = 15;
    title_fontsize = 15;
    meas_linewidth = 9;
    ref_linewidth = 7;
    vline_linewidth = 3;
    ref_transparency = 0.4;
    % y_limits = [-50, 50];

    if plot_instructions == "Regular"
        % ==================== Plot ======================
        q_time = sim_out.q_pump.Time;
        q_pump_data = sim_out.q_pump.Data;
        q_drain_data = sim_out.q_drain.Data;
        q_12_data = sim_out.q_12.Data;
    
    
        % ========================  World Frame Position (XYZ)  =======
        figure('Position', [0, 0, 1024, 768])
        % X3
        subplot(3,2,1)
        plot(q_time, q_pump_data(:, 1), "LineWidth", meas_linewidth)
        % xline(waypoint_changes, "LineWidth", vline_linewidth)
        set(gca, "Fontsize", ax_fontsize)
        title('Pump A', FontSize=title_fontsize)
        xlabel('Time[s]', FontSize=xlabel_fontsize)
        ylabel('Flow [?]', FontSize=ylabel_fontsize)
        % Y
        subplot(3,2,2)
        plot(q_time, q_pump_data(:, 2), "LineWidth", meas_linewidth)
        % xline(waypoint_changes, "LineWidth", vline_linewidth)
        set(gca, "Fontsize", ax_fontsize)
        title('Pump B', FontSize=title_fontsize)
        xlabel('Time[s]', FontSize=xlabel_fontsize)
        ylabel('Flow [?]', FontSize=ylabel_fontsize)
        % Y
        subplot(3,2,3)
        plot(q_time, q_drain_data(:, 1), "LineWidth", meas_linewidth)
        % xline(waypoint_changes, "LineWidth", vline_linewidth)
        set(gca, "Fontsize", ax_fontsize)
        title('Drain 1', FontSize=title_fontsize)
        xlabel('Time[s]', FontSize=xlabel_fontsize)
        ylabel('Flow [?]', FontSize=ylabel_fontsize)
        % Q2
        subplot(3,2,4)
        plot(q_time, q_drain_data(:, 2), "LineWidth", meas_linewidth)
        % xline(waypoint_changes, "LineWidth", vline_linewidth)
        set(gca, "Fontsize", ax_fontsize)
        title('Drain 2', FontSize=title_fontsize)
        xlabel('Time[s]', FontSize=xlabel_fontsize)
        ylabel('Flow [?]', FontSize=ylabel_fontsize)
        % Q2
        subplot(3,2,5)
        plot(q_time, q_12_data, "LineWidth", meas_linewidth)
        % xline(waypoint_changes, "LineWidth", vline_linewidth)
        set(gca, "Fontsize", ax_fontsize)
        title('Q12', FontSize=title_fontsize)
        xlabel('Time[s]', FontSize=xlabel_fontsize)
        ylabel('Flow [?]', FontSize=ylabel_fontsize)
    elseif plot_instructions == "Cross"
        % ==================== Plot ======================
        q_time = sim_out.q_pump.Time;
        q_pump_data = sim_out.q_pump.Data;
        q_drain_data = sim_out.q_drain.Data;
        q_12_data = sim_out.q_12.Data;
        path_data = sim_out.ref_path.Data;
    
        % ========================  World Frame Position (XYZ)  =======
              figure('Position', [0, 0, 1024, 768])
        % X3
        subplot(3,2,1)
        plot(q_time, q_pump_data(:, 1), "LineWidth", meas_linewidth)
        hold on 
        yyaxis right
        plot(q_time, path_data(:, 1), "LineWidth", meas_linewidth/2, ...
            "Color", [1, 0, 0, ref_transparency]);
        hold on
        plot(q_time, path_data(:, 2), "LineWidth", meas_linewidth/2, ...
            "Color", [0, 1, 0, ref_transparency]);
        yyaxis left
        set(gca, "Fontsize", ax_fontsize)
        title('Pump A', FontSize=title_fontsize)
        xlabel('Time[s]', FontSize=xlabel_fontsize)
        ylabel('Flow [?]', FontSize=ylabel_fontsize)
        % Y
        subplot(3,2,2)
        plot(q_time, q_pump_data(:, 2), "LineWidth", meas_linewidth)
       hold on 
        yyaxis right
        plot(q_time, path_data(:, 1), "LineWidth", meas_linewidth/2, ...
            "Color", [1, 0, 0, ref_transparency]);
        hold on
        plot(q_time, path_data(:, 2), "LineWidth", meas_linewidth/2, ...
            "Color", [0, 1, 0, ref_transparency]);
        yyaxis left
        set(gca, "Fontsize", ax_fontsize)
        title('Pump B', FontSize=title_fontsize)
        xlabel('Time[s]', FontSize=xlabel_fontsize)
        ylabel('Flow [?]', FontSize=ylabel_fontsize)
        % Y
        subplot(3,2,3)
        plot(q_time, q_drain_data(:, 1), "LineWidth", meas_linewidth)
        hold on 
        yyaxis right
        plot(q_time, path_data(:, 1), "LineWidth", meas_linewidth/2, ...
            "Color", [1, 0, 0, ref_transparency]);
        hold on
        plot(q_time, path_data(:, 2), "LineWidth", meas_linewidth/2, ...
            "Color", [0, 1, 0, ref_transparency]);
        yyaxis left
        set(gca, "Fontsize", ax_fontsize)
        title('Drain 1', FontSize=title_fontsize)
        xlabel('Time[s]', FontSize=xlabel_fontsize)
        ylabel('Flow [?]', FontSize=ylabel_fontsize)
        % Q2
        subplot(3,2,4)
        plot(q_time, q_drain_data(:, 2), "LineWidth", meas_linewidth)
        hold on  
        yyaxis right
        plot(q_time, path_data(:, 1), "LineWidth", meas_linewidth/2, ...
            "Color", [1, 0, 0, ref_transparency]);
        hold on
        plot(q_time, path_data(:, 2), "LineWidth", meas_linewidth/2, ...
            "Color", [0, 1, 0, ref_transparency]);
        yyaxis left
        set(gca, "Fontsize", ax_fontsize)
        title('Drain 2', FontSize=title_fontsize)
        xlabel('Time[s]', FontSize=xlabel_fontsize)
        ylabel('Flow [?]', FontSize=ylabel_fontsize)
        % Q2
        subplot(3,2,5)
        plot(q_time, q_12_data, "LineWidth", meas_linewidth)
        hold on 
        yyaxis right
        plot(q_time, path_data(:, 1), "LineWidth", meas_linewidth/2, ...
            "Color", [1, 0, 0, ref_transparency]);
        hold on
        plot(q_time, path_data(:, 2), "LineWidth", meas_linewidth/2, ...
            "Color", [0, 1, 0, ref_transparency]);
        yyaxis left
        set(gca, "Fontsize", ax_fontsize)
        title('Q12', FontSize=title_fontsize)
        xlabel('Time[s]', FontSize=xlabel_fontsize)
        ylabel('Flow [?]', FontSize=ylabel_fontsize)
    end


