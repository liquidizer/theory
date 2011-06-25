function u= satisfaction(U, C, M)
    u= U*M' + diag(M*C*M')';
end