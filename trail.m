clc
clear
params = ancf_params();

F = zeros(params.n, 1);
F(params.n-2, 1) = -params.F;

[e, ~] = init_cond(params);


for j = 1:1000
    Qint = zeros(params.n, 1);
    QQ_gradient= zeros(params.n, params.n);

    for i = 1:params.ne
        L = params.x(i);
        istart = 4*i-3;
        iend = 4*i + 4;
        eele = e(istart:iend, 1);
        q = Q(params.A, params.E, params.I, L, eele);
        Qint(istart:iend, 1) = Qint(istart:iend,1) + q;
        QQ_gradient(istart:iend, istart:iend) = QQ_gradient(istart:iend, istart:iend) +  Q_gradient(params.A, params.E, params.I, L, eele);
    end

    Qint(1:4,1) = zeros(4,1);
%     
%     [U, S,V] = svd(QQ_gradient);
%     Sinv = zeros(8,8);
%     for k = 1:8
%         if abs(S(k, k)) > 10^-3
%             Sinv(k,k) = 1/S(k, k);
%         end
%     end
    K = QQ_gradient(5:params.n, 5:params.n);
    Kinv = inv(K);
    
    
    
    delta_e = Kinv*(F(5:params.n)-Qint(5:params.n));
    e = e + [zeros(4,1);delta_e];
end
    

