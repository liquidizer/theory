function M= lqfb(U,C)
    np= size(U,1);
    nq= size(U,2);
    M= zeros(1, nq);
    for i= 1:nq
        M2= M;
        M2(i)= true;
        M(i)= false;
        v= false(1,np);
        for j=1:np
            u1= satisfaction(U(j,:),C(:,:,j),M);
            u2= satisfaction(U(j,:),C(:,:,j),M2);
            v(j)= u2>u1;
        end
        M(i) = sum(v)>sum(~v);
    end
end
