function p = ancf_params()
%ANCF_PARAMS Problem specification, define the sections

L =2;
p.ne = 1; % number of beam elements
for i = 1:p.ne
    p.x(i) = L/p.ne;   % noodle length
end

p.n = 4*(p.ne+1);  % number of nodal coordinates
p.A = 0.1* 0.1;    % cross-section area     
p.E = 2.07e11;
p.I = 0.1*0.1^3/12;

p.F = 3*p.E*p.I/ L^2;

% specify constraints at the noodle ends
%the element in vector represent which dof is constrained, from 1 to 4
p.ml = [1,2,3,4]; %left end
p.mr = [];%right end
end