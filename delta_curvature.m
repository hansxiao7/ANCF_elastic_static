function delta_phi = delta_curvature(e, x, L)

Sx = shape_fun(x, L, 1);
Sx = [Sx(1)*eye(2), Sx(2)*eye(2), Sx(3)*eye(2), Sx(4)*eye(2)];
Sxx = shape_fun(x, L, 2);
Sxx = [Sxx(1)*eye(2), Sxx(2)*eye(2), Sxx(3)*eye(2), Sxx(4)*eye(2)];

rx = Sx * e;
rxx = Sxx * e;

for i = 1:8
    delta_phi(i,1) =  1/norm(rx)^4 *(norm(rx)^2 *(cross([Sx(:,i);0], [rxx;0]) + cross([rx;0], [Sxx(:,i);0]))...
        - 2 * cross([rx;0], [rxx;0])*(rx' * Sx(:,i)))' * [0;0;1];
end

end
