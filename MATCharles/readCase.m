function sim = readCase(code, dir, t0, tf, dt, save_interval, calcStats)

pxyz = [dir,'/',code,'.pxyz'];
pcd  = [dir,'/',code,'.',num2str(t0,'%08d'),'.pcd'];
[~, coords] = readProbes(pxyz, pcd);
[len, ~] = size(coords);

u = zeros(len,(tf-t0)/save_interval+1);
v = u;
w = u;
p = u;
quants = [u, v, w, p];
idx = 1;
for i = 1:save_interval:(tf-t0+1) % was parfor
    pxyz = [dir,'/',code,'.pxyz'];
    pcd  = [dir,'/',code,'.',num2str(i-1+t0,'%08d'),'.pcd'];
    [data, ~] = readProbes(pxyz, pcd);
    for j = 1:4
       quants(j,:,idx) = data(:,j)
    end
%     u(:,idx) = data(:,1);
%     v(:,idx) = data(:,2);
%     w(:,idx) = data(:,3);
%     p(:,idx) = data(:,4);
    idx = idx+1;
    
    if mod(idx, 100)==0
        fprintf('Reading %s\n', pcd);
    end
end

u = quants(1,:,:); v = quants(2,:,:); w = quants(3,:,:); p = quants(4,:,:);


fprintf('Calculating stats...\n');
sim = computeQty(u,v,w,p,t0,tf,dt,save_interval,coords, calcStats);
sim.name = code;

