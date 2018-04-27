function phi = curvature(e, x, L)
%return the curvature at the position of x in the local coordinate
%system, 0 <= x <= L 
Sxx = shape_fun(x, L, 2);
Sxx = [Sxx(1)*eye(2), Sxx(2)*eye(2), Sxx(3)*eye(2), Sxx(4)*eye(2)];
Sx = shape_fun(x, L, 1);
Sx = [Sx(1)*eye(2), Sx(2)*eye(2), Sx(3)*eye(2), Sx(4)*eye(2)];
rx = Sx * e;
rxx = Sxx * e;
I_bar = [0 -1; 1 0];

%phi = rxx' * I_bar * rx / (sqrt(rx' * rx)^2);
phi = cross([rx',0], [rxx',0])/(rx' * rx) * [0, 0, 1]';
end