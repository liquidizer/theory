function bestM= bestManifesto(U,C,M0) 
    nq= size(M0,2);
    AM= allManifests(nq);
    R= zeros(size(AM,1),1);
    
    for s= 1:100
        M0= rand(size(M0))>0.5;
        for j= 1:size(AM,1)
            result= vote(U, C, [AM(j,:);M0]);
            R(j)= R(j)+result(1);
        end
    end
    bestI= find(R==max(R),1);
    bestM= AM(bestI, :);
end

function M=allManifests(n)
M= zeros(2^n-1, n);
for i= 1: size(M,1)
    for j=1:n
        M(i,j)= bitand(i, 2^(j-1))~=0;
    end
end
end