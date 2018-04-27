function data = central_diff(delta_t, tend, params)


nout = floor(tend/delta_t) + 1;
data.t = zeros(1, nout);
data.e = zeros(params.n, nout);
data.ed = zeros(params.n, nout);

% Initial conditions (t=0)
[e, ed] = init_cond(params);

% Store data at t0
data.t(1) = 0;
data.e(:,1) = e;
data.ed(:,1) = ed;

% Mass matrix (constant)
M = mass_matrix(params);
Minv = M^(-1);

% external force
Qe = zeros(params.n, 1);
Qe(params.n-2,1) = -params.F;

old_e = e;

% Loop over all output times.
hw = waitbar(0,'Initializing waitbar...');


for i = 1:nout-1
    Qs = zeros(params.n, 1);
    for j = 1:params.ne
        L = params.L;
%         L = params.x(j);
        istart = 4*j-3;
        iend = 4*j + 4;
        eele = e(istart:iend, 1);
        %q = Q(params.A, params.E, params.I, L, eele);
        q = Fint(eele, params.E, params.A, params.I, L);
        Qs(istart:iend, 1) = Qs(istart:iend,1) + q;
    end
    Qs(1:4, 1) = 0;
    temp = e;
    e = delta_t^2 * Minv * (Qe - Qs) +2*e - old_e;
    e(1:4,1) = zeros(4,1);
    e(3,1) = 1;
    old_e = temp;
    data.e(:,i+1) = e;
    data.t(i+1) = data.t(i) + delta_t;
    t_str = sprintf('t = %.4f', i*delta_t);
    waitbar(i/(nout-1),hw,t_str);
end
close(hw);
end
