np= 10;    % number of voters
nq= 11;    % number of initiatives
cov1= 0.3; % individual covariance in preferences
cov2= 0;   % systematic covariance in preferences

% choose choose random preferences for voters
U= randn(np,nq);
C= cov1*randn(nq,nq,np);
C= C+ cov2*repmat(randn(nq,nq),[1,1,np]);

V1= 1e-8*ones(size(U)); % initial voting weights
V2= 1e-8*ones(size(U)); % initial voting weights
V3= 1e-8*ones(size(U)); % initial voting weights

for frame= 1:500
    [X1,Y1,V1]= utility('approval', U, C, V1);
    [X2,Y2,V2]= utility('cumulative', U, C, V2);
    [X3,Y3,V3]= utility('liquidizer', U, C, V3);

    subplot(3,1,1)
    plot(X1,Y1,'.-')
    %axis([-3 3 -1 1])
    axis([0.5 11.5 -1 1])
    ylabel('Independent')
    %text(-2.8,0.7,formatResult(V1))
    text(0.7,0.7,formatResult(V1))

    subplot(3,1,2)
    plot(X2,Y2,'.-')
    %axis([-3 3 -1 1])
    axis([0.5 11.5 -1 1])
    ylabel('Cumulative')
    %text(-2.8,0.7,formatResult(V2))
    text(0.7,0.7,formatResult(V2))

    subplot(3,1,3)
    plot(X3,Y3,'.-')
    %axis([-3 3 -1 1])
    axis([0.5 11.5 -1 1])
    ylabel('Euklidean')
    %xlabel('Marginal utility')
    xlabel('Proposal')
    %text(-2.8,0.7,formatResult(V3))
    text(0.7,0.7,formatResult(V3))

    filename= sprintf('img/frame%04d.png',frame);
    print('-r80', '-dpng', filename);
end
