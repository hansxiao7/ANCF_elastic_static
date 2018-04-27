function [f, sin, cos] = dof_transform(e, x, L)

Sx = shape_fun(x, L, 1);
Sx = [Sx(1)*eye(2), Sx(2)*eye(2), Sx(3)*eye(2), Sx(4)*eye(2)];
rx = Sx * e;
f = sqrt(rx' * rx);
cos = rx(1)/f;
sin = rx(2)/f;

end
