clear

% Options ----------------------------------------------------------------
casePath = '/scratch/users/nbachand/Cascade/city_block_cfd/CHARLES/single_family/R9';
probePath = '/probes/probesOut';
savePath = '../CHARLES/single_family/R9/plots/';
probeNames = {'col_3-2', 'col_3-6', 'col_9-2', 'col_9-6'};%, "col_3-6", "col_9-2", "col_9-6"};
probeNamesPlots = {'col 3-2', 'col 3-6', 'col 9-2', 'col 9-6'};
t0 = 21300-10000; % first step
tf = 21300; % last step
dt = 0.75; % save dt, not simulation dt
save_interval = 1; % interval at which probes were written
calc_stats = true;

loadData = false; % set to true to load .mat files, avoids slow import every time

hPlot = 1; % height at which to plot certain statistics (e.g. spectra)
%-------------------------------------------------------------------------

%% Load all
if loadData
    load([casePath '/probes_roof.mat']);
else
    for i=1:length(probeNames)
        probes{i} = readCase(probeNames{i}, [casePath, probePath], t0, tf, dt, save_interval, calc_stats);
    end
end

for i=1:length(probes)
    y{i} = probes{i}.coords(:,2);
end

% % Load prescribed turbulence quantities at inflow:
% inflow = readInflowProfile([casePath, '/inflowProfile.dat']);


%% Plot ABL

% Fit polynomial to find z0:
kappa = 0.41;
for i=1:length(probeNames)
    coeff = polyfit(probes{i}.meanU, log(y{i}), 1);
    ustar_fit(i) = kappa/coeff(1);
    z0_fit(i) = exp(coeff(2));
end

figure(1); clf; hold on
for i=1:length(probes)
    plot(probes{i}.meanU, y{i}, '-', 'linewidth', 1, 'displayname', probeNamesPlots{i})
end
if i>1
    legend
end
xlabel('<U> [m/s]')
ylabel('y [m]')
set(gca, 'fontsize', 14)

savefig([savePath, 'ABL_plot']);


%% Plot length scales
[~, idx] = min(abs(probes{1,1}.coords(:,2) - hPlot));
Lx_set = 0.083 * 15;
Ly_set = 0.0167 * 15;
Lz_set = 0.025 * 15;

figure(2); clf
subplot(1,3,1); hold on
for i=1:length(probes)
    plot(probes{i}.Lx, y{i}, '-', 'linewidth', 1, 'displayname', probeNamesPlots{i})
end
% plot(Lx_set*ones(size(y{1})), y{1}, 'k--', 'linewidth', 1, 'displayname', 'Prescribed')
legend
xlabel('L_x [m]')
ylabel('y [m]')
set(gca, 'fontsize', 14)

subplot(1,3,2); hold on
for i=1:length(probes)
    plot(probes{i}.Ly, y{i}, '-', 'linewidth', 1, 'displayname', probeNamesPlots{i})
end
% plot(Ly_set*ones(size(y{1})), y{1}, 'k--', 'linewidth', 1, 'displayname', 'Prescribed')
legend
xlabel('L_y [m]')
ylabel('y [m]')
set(gca, 'fontsize', 14)

subplot(1,3,3); hold on
for i=1:length(probes)
    plot(probes{i}.Lz, y{i}, '-', 'linewidth', 1, 'displayname', probeNamesPlots{i})
end
% plot(Lz_set*ones(size(y{1})), y{1}, 'k--', 'linewidth', 1, 'displayname', 'Prescribed')
legend
xlabel('L_z [m]')
ylabel('y [m]')
set(gca, 'fontsize', 14)

savefig([savePath, 'LS_plot']);

%% Plot Reynolds stresses
for i=1:length(probeNames)
    Re_stresses{i} = {probes{i}.uu_avg, probes{i}.vv_avg, probes{i}.ww_avg, probes{i}.uv_avg, probes{i}.vw_avg, probes{i}.uw_avg};
end

lineSpec = {'-', '--', ':', '-.'};
plotNames = {'uu', 'vv', 'ww', 'uv', 'vw', 'uw'};

figure(3); clf
for j=1:6
    subplot(2,3,j); hold on
    for i=1:length(probeNames)
        plot(Re_stresses{i}{j}, y{i}, lineSpec{i}, 'linewidth', 1, 'displayname', plotNames{i})
    end
%     plot(inflow.(plotNames{j}), inflow.y, 'k-.', 'linewidth', 1, 'displayname', 'Prescribed')
    
    if j==1||j==4
        ylabel('y [m]')
    end
    
    if j==6
        legend
    end
    
    title(probeNamesPlots{j});
    set(gca, 'fontsize', 14)
end

savefig([savePath, 'RS_plot']);

%% Plot spectra

figure(4); clf; hold on
for i=1:length(probeNames)
    plot(probes{i}.freq, probes{i}.Euu(:,idx), 'linewidth', 0.8, 'displayname', probeNamesPlots{i})
    
    set(gca, 'XScale', 'log')
    set(gca, 'YScale', 'log')
    
    legend
    
    xlabel('f [Hz]')
    ylabel('E_u [m^3/s^2]')
    set(gca, 'fontsize', 14)
end
axis tight

savefig([savePath, 'Spec_plot']);
%% Plot turb intensities
figure(5); clf
for i=1:length(probeNames)
    subplot(1,3,1); hold on
    plot(probes{i}.Iu_avg, y{i}, 'linewidth', 1, 'displayname', probeNamesPlots{i})
    xlabel('I_u')
    ylabel('y [m]')
    set(gca, 'fontsize', 14)
    
    subplot(1,3,2); hold on
    plot(probes{i}.Iv_avg, y{i}, 'linewidth', 1, 'displayname', probeNamesPlots{i})
    xlabel('I_v')
    set(gca, 'fontsize', 14)
    
    subplot(1,3,3); hold on
    plot(probes{i}.Iw_avg, y{i}, 'linewidth', 1, 'displayname', probeNamesPlots{i})
    xlabel('I_w')
    legend
    set(gca, 'fontsize', 14)
end

savefig([savePath, 'Int_plot']);
%% Plot prms
for i=1:length(probes)
    prms{i} = sqrt(mean(probes{i}.pPrime.*probes{i}.pPrime,2));
end

figure(6); clf; hold on
for i=1:length(probes)
    plot(prms{i}, y{i}, '-', 'linewidth', 1, 'displayname', probeNamesPlots{i})
end
if i>1
    legend
end
xlabel('p_{rms} [Pa]')
ylabel('y [m]')
set(gca, 'fontsize', 14)

savefig([savePath, 'prms_plot']);
