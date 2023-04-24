function sim = computeQty(u,v,w,p,t0,tf,dt,save_interval,coords,calcStats)

% Reorder Y in coords:
[coords, I] = sortrows(coords, 2);

sim.u = u(I,:);
sim.v = v(I,:);
sim.w = w(I,:);
sim.p = p(I,:);

if calcStats
    
    sim.meanU = mean(sim.u,2);
    sim.meanV = mean(sim.v,2);
    sim.meanW = mean(sim.w,2);
    sim.meanP = mean(sim.p,2);
    
    sim.uPrime = sim.u - sim.meanU;
    sim.vPrime = sim.v - sim.meanV;
    sim.wPrime = sim.w - sim.meanW;
    sim.pPrime = sim.p - sim.meanP;
    
    sim.uu = sim.uPrime .* sim.uPrime;
    sim.vv = sim.vPrime .* sim.vPrime;
    sim.ww = sim.wPrime .* sim.wPrime;
    
    sim.uv = sim.uPrime .* sim.vPrime;
    sim.vw = sim.vPrime .* sim.wPrime;
    sim.uw = sim.uPrime .* sim.wPrime;
    
    sim.Iu = sqrt(sim.uPrime .* sim.uPrime) ./ sim.meanU;
    sim.Iv = sqrt(sim.uPrime .* sim.uPrime) ./ sim.meanU;
    sim.Iw = sqrt(sim.uPrime .* sim.uPrime) ./ sim.meanU;
    
    sim.uu_avg = mean(sim.uPrime.*sim.uPrime,2);
    sim.vv_avg = mean(sim.vPrime.*sim.vPrime,2);
    sim.ww_avg = mean(sim.wPrime.*sim.wPrime,2);
    sim.pp_avg = mean(sim.pPrime.*sim.pPrime,2);
    
    sim.uv_avg = mean(sim.uPrime.*sim.vPrime,2);
    sim.vw_avg = mean(sim.vPrime.*sim.wPrime,2);
    sim.uw_avg = mean(sim.uPrime.*sim.wPrime,2);
    
    sim.Iu_avg = sim.uu_avg.^0.5./sim.meanU;
    sim.Iv_avg = sim.vv_avg.^0.5./sim.meanU;
    sim.Iw_avg = sim.ww_avg.^0.5./sim.meanU;
    
    % sim.k = 0.5*(sim.uu+sim.vv+sim.ww);
    [idx, ~] = size(sim.p);
    
    parfor i = 1:idx
        
        time = [0:dt:(tf-t0)*dt/save_interval];
        tsclFit = fittype('exp(-x/a)', 'dependent',{'y'}, 'independent',{'x'}, 'coefficients',{'a'});
        
        R_u = xcov(sim.uPrime(i,:),'unbiased')./sim.uu_avg(i,:);
        R_uFit = fit(time', R_u(((tf-t0)/save_interval+1):end)', tsclFit, 'StartPoint', 1, 'Lower', 0);
        t_scale = R_uFit.a;
        Lx(i) = t_scale*sim.meanU(i)
        
        R_v = xcov(sim.vPrime(i,:),'unbiased')./sim.vv_avg(i,:);
        R_vFit = fit(time', R_v(((tf-t0)/save_interval+1):end)', tsclFit, 'StartPoint', 1, 'Lower', 0);
        t_scale = R_vFit.a;
        Ly(i) = t_scale*sim.meanU(i)
        
        R_w = xcov(sim.wPrime(i,:),'unbiased')./sim.ww_avg(i,:);
        R_wFit = fit(time', R_w(((tf-t0)/save_interval+1):end)', tsclFit, 'StartPoint', 1, 'Lower', 0);
        t_scale = R_wFit.a;
        Lz(i) = t_scale*sim.meanU(i)
        
    end
    sim.Lx = Lx';
    sim.Ly = Ly';
    sim.Lz = Lz';
    
    [sim.Euu, sim.freq] = pwelch(sim.uPrime', [], [], [], 1/dt);
    
    [sim.Epp, sim.freq] = pwelch(sim.pPrime', [], [], [], 1/dt);
    
end

sim.coords = coords;