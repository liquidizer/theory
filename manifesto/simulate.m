function simulate
randn('state',0)
rand('state',0)

N= 1000;
np= 10;
nq= 10;
cov= 1;    % covariance in preferences
nop= 10; % total number of parties
R= [];

for scenario = 1:N

    % choose choose random preferences for voters
    U= randn(np,nq);
    C= cov*randn(nq,nq,np);
    %C= cov*repmat(randn(nq,nq),[1,1,np]);

    % Liquid System
    %M= lqfb(U,C);
    %M= liquidizer(U,C);
    %M= rand(1,nq)> 0.5;

    % choose a random program for remaining parties
    M0= rand(nop-1,nq)> 0.5;

    M= bestManifesto(U,C,M0);
    
    % election
    result= vote(U, C, [M;M0]);
    R=vertcat(R,result/np);
    
    Rf= mean(R,1)*100;
    ci= 2*std(R,true,1)*100/sqrt(size(R,1));
    fprintf('%2.1f (%1.0f)%%\n', Rf(1), ci(1));
end
end

