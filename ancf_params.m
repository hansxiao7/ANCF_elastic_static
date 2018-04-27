function p = ancf_params()
%ANCF_PARAMS Problem specification, define the sections

L = 3.0;   % noodle length
ne = 5;    % number of beam elements
p.ne = ne;         % number of ANCF elements per noodle
for i = 1:p.ne
    p.x(i) = L/p.ne;   % noodle length
end


r = 0.02;  % noodle radius

p.n = 4*(p.ne+1);  % number of nodal coordinates
p.L = L / ne;      % length of one ANCF element
p.E = 2e7;         % elasticity modulus
p.A = pi * r^2;    % cross-section area
p.I = 0.25*pi*r^4; % second moment of area
p.rho = 7200;      % density

p.F = 3*p.E*p.I/L^2;

% specify constraints at the noodle ends
%the element in vector represent which dof is constrained, from 1 to 4
p.ml = [1,2,3,4]; %left end
p.mr = [];%right end
end