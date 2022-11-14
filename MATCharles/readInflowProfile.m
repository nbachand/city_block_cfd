function inflow = readInflowProfile(filename)

fid = fopen(filename);
data = textscan(fid, '%q', 'whitespace', '\t');
fclose(fid);
data = data{1};

inflow.x = str2double(data(3:102));
inflow.y = str2double(data(105:204));
inflow.z = str2double(data(207:306));
inflow.U = str2double(data(309:408));
inflow.V = str2double(data(411:510));
inflow.W = str2double(data(513:612));
inflow.uu = str2double(data(615:714));
inflow.vv = str2double(data(717:816));
inflow.ww = str2double(data(819:918));
inflow.vw = str2double(data(921:1020));
inflow.uw = str2double(data(1023:1122));
inflow.uv = str2double(data(1125:1224));