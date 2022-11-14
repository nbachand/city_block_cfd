function [param, xyz] = readProbes(pxyz, pcd)

fid = fopen(pxyz,'r');
xyz_cell = textscan(fid, '%d %f  %f  %f', 'HeaderLines', 1);
xyz = cell2mat(xyz_cell(2:4));
fclose(fid);

fid = fopen(pcd, 'r');
param = cell2mat(textscan(fid, '%f %f %f %f', 'HeaderLines', 1));
fclose(fid);

%{
fh = fopen(pxyz,'r');
endian = 'l';
magic_number = fread(fh,1,'int64',endian); % magic number
if magic_number ~= 1235813 
    endian = 'b';
end
fread(fh,1,'int64',endian); % skip version
np = fread(fh,1,'int64',endian); % number of points
assert(2 == fread(fh,1,'int64',endian)); % 0:no data, 1:delta, 2:index
buf = fread(fh,3*np,'double',endian); % always double for consistency w/ other pbins
ind = fread(fh,np,'int64',endian); % global index (should equal ordering in ascii file)
fclose(fh);

xyz = zeros(np,3);
for i=1:np
    for j=1:3
        xyz(1+ind(i),j) = buf(3*(i-1)+j);
    end
end

fh = fopen(pcd,'r');
endian = 'l';
magic_number = fread(fh,1,'int64',endian); % magic number
if magic_number ~= 1235813 
    endian = 'b';
end
fread(fh,1,'int64',endian); % skip version
assert(np == fread(fh,1,'int64',endian)); % number of points
nv = fread(fh,1,'int64',endian); % number of variables
prec = fread(fh,1,'int64',endian); % 0 float/ 1 double

if (prec == 1)
    buf = fread(fh,nv*np,'double',endian); % note that each scalar gets a row
else
    buf = fread(fh,nv*np,'float',endian);
end

scd = zeros(nv,np);
for j = 1:nv
    for i = 1:np
        scd(j,1+ind(i)) = buf(i+(j-1)*np);
    end
end
fclose(fh);
%}