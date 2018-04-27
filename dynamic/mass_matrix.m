function M = mass_matrix(params)
%MASS_MATRIX Calculate the generalized mass matrix for a beam.
%ml and mr are the constraints at beam end dof, for example, ml = [1,2,3,4]
%means a fixed end
% Evaluate the elemental mass matrix.
M = zeros(params.n);
ml = params.ml;
mr = params.mr;

for i = 1:params.ne
    L = params.x(i);
    Me = params.rho * params.A * L *mass(L);
    
    % Assemble mass matrix for a noodle with 'ne' elements.
    M00 = Me(1:4,1:4);
    M01 = Me(1:4,5:8);
    M10 = Me(5:8,1:4);
    M11 = Me(5:8,5:8);
    
    ii = (i-1)*4 + 1;
    M(ii:ii+3, ii:ii+3) = M(ii:ii+3, ii:ii+3) + M00;
    M(ii:ii+3, ii+4:ii+7) = M01;
    M(ii+4:ii+7, ii:ii+3) = M10;
    M(ii+4:ii+7, ii+4:ii+7) = M(ii+4:ii+7, ii+4:ii+7) + M11;     
end
% If some nodal coordinates are to be fixed, modify the mass matrix
% (zero out rows and columns, then set diagonal block(s) to identity)


if max(size(ml)) ~=0 
    for j = 1: max(size(ml))
        M(ml(j), :) = zeros(1, params.n);
        M(:, ml(j)) = zeros(params.n ,1);
        M(ml(j), ml(j)) =1;
    end
end

if max(size(mr)) ~=0
    ir = params.n - 4;
    for k = 1:max(size(mr))
        M(mr(k)+ir, :) = zeros(1, params.n);
        M(:, mr(k)+ir) = zeros(params.n ,1);
        M(mr(k)+ir, mr(k)+ir) = 1;
    end
end 


end