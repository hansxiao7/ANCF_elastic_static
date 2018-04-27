function strain_x = axial_strain(e, x, L)
%return the axial strain at the position of x in the local coordinate
%system, 0 <= x <= L 
Sx = shape_fun(x, L, 1);
Sx = [Sx(1)*eye(2), Sx(2)*eye(2), Sx(3)*eye(2), Sx(4)*eye(2)];
strain_x = norm(Sx*e) - 1;
%strain_x = 1/2*(e'*(Sx')*Sx*e - 1);

end