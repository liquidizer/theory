function result= vote(U, C, M)
    nop= size(M,1);
    np= size(U,1);
    result=zeros(1,nop);
    for i=1:np
        u1= satisfaction(U(i,:),C(:,:,i),M);
        j= find(u1==max(u1));
        result(j)= result(j)+1;
    end
end
