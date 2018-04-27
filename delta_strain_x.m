function delta_strain_0 = delta_strain_x(e, x, L)

Sx = shape_fun(x, L, 1);
Sx = [Sx(1)*eye(2), Sx(2)*eye(2), Sx(3)*eye(2), Sx(4)*eye(2)];

rx = Sx * e;

delta_strain_0 = 1 / norm(rx) * Sx' * rx;

end