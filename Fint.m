function Qint = Fint(e, E, A, I, L)

[x5, w5] = gauss_points(5);

Qint = zeros(8,1);
Ql = zeros(8,1);
Qf = zeros(8,1);
for i = 1:5
    x = (x5(i)+1)*L/2;
    strain_x = axial_strain(e, x, L);
    phi = curvature(e, x, L);
%     M = E * I * phi;
%     N = strain_x * E * A;
%     [f, sin, cos] = dof_transform(e, x, L);
%     Sx = shape_fun(x, L, 1);
%     Sx = [Sx(1)*eye(2), Sx(2)*eye(2), Sx(3)*eye(2), Sx(4)*eye(2)];
%     S = shape_fun(x, L, 0);
%     S = [S(1)*eye(2), S(2)*eye(2), S(3)*eye(2), S(4)*eye(2)];
%     AA = [S; Sx];
%     F = [N * cos; N*sin; 0; M/(f*cos)];
%     Qint = Qint + w5(i)*AA'*F * L /2;

    Ql = Ql + w5(i)* E * A *  strain_x * L /2 * delta_strain_x(e, x, L);
    Qf = Qf + w5(i)* E * I * phi * L/2 * delta_curvature(e,x,L);
end

Qint = Ql + Qf;

end
    
