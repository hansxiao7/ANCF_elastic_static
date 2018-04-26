function [e0, ed0] = init_cond(params)
%INIT_COND Specify initial conditions for the beam nodal coordinates

% we always initialize the beam horizontal with its left end at the origin
% and at rest

e0 = zeros(params.n, 1);
ed0 = zeros(params.n, 1);

e0(1) = 0;
e0(3) = 1;
for ie = 2:params.ne+1
   e0(4*ie-3) = sum(params.x(1:(ie-1)));
   e0(4*ie-1) = 1;
end