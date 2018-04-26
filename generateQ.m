e = [sym('e[1]') ; sym('e[2]') ; sym('e[3]') ; sym('e[4]')  ; sym('e[5]')  ; sym('e[6]') ; sym('e[7]') ; sym('e[8]') ];
for i = 1:8
   assumeAlso(e(i), 'real');
end
F = [sym('F[1]') ; sym('F[2]') ; sym('F[3]') ; sym('F[4]')  ; sym('F[5]')  ; sym('F[6]') ; sym('F[7]') ; sym('F[8]') ];
syms L real;
syms E A I;

syms xi;
S1 = 1 - 3*xi^2 + 2*xi^3;
S2 = L * (xi - 2*xi^2 + xi^3);
S3 = 3*xi^2 - 2*xi^3;
S4 = L * (-xi^2 + xi^3);

S = [S1*eye(2) S2*eye(2) S3*eye(2) S4*eye(2)];
Sx = diff(S/L, xi);
Sxx = diff(Sx/L, xi);

Sl = Sx'*Sx;
Kl = 1/2*E*A*L*(int(Sl*e*(e')*Sl, xi, 0,1)) - 0.5*E*A*L* int(Sl, xi, 0,1);
%Kl = E*A*L*int(Sl, xi, 0,1) * (sqrt((e(5)-e(1))^2 + (e(6)-e(2))^2 ) - L)/L;
Kt = E*I*L*int(Sxx'*Sxx, xi, 0, 1);


Q= (Kl+ Kt)*e;
Q_gradient = [];
for i = 1:8
    Q_gradient = [Q_gradient,diff(Q, e(i))];
end

%matlabFunction(solve(K*e == F, e),'file','e.m');
matlabFunction(Q,'file', 'Q.m');
matlabFunction(Q_gradient,'file', 'Q_gradient.m');
