function R= weights(method)
n= 1000;  % voters turn out
m= 10;    % candidates
R=[0 0 0];

% cycle over vote numbers
x= [1:m];
for nv=x

  % repeat simplation
  r=[];
  for s=1:10000
      
    % first n-1 voters vote randomly
    V= floor(2*rand(n-1,m));
    V= V(sum(V,2)~=0,:);

    % Compute voting weight of last voter
    if strcmp(method, 'approval')
      % one vote for each of best nv candidates
      Vp= zeros(1, m);
      Vp(x<=nv & (x<=m/2))=1;
      Vp(x>nv & (x>m/2))=-1;
      V= [V; Vp];
    elseif strcmp(method, 'liquidizer')
      % first nv candidates with decreasing preference
      Vp= max(0, (nv+1)-[1:m]);
      V= [V; Vp-mean(Vp)];
      % normalize non zero voting vectors with 2-norm
      V= diag(sparse(1./sqrt(sum(V.^2,2)))) * V;
    elseif strcmp(method, 'cumulative')
      % first nv candidates with decreasing preference
      V= [V; max(0, (nv+1)-[1:m])];
      % normalization with 1-norm
      V= diag(sparse(1./(sum(V,2)))) * V;
    else
      error('unknown method: %s', method);
    end

    % result of all votes
    r1= sum(V);
    r1= mean(find(r1==max(r1)));
    
    % result excluding the last vote
    r2= sum(V(1:end-1,:));
    r2= mean(find(r2==max(r2)));
    
    % store if prefered candidate was elected
    r= [r; r1<r2];
  end

  % store result and error for vote number
  e= std(r)/sqrt(s);
  R=[R; nv, mean(r), e];
end
end

