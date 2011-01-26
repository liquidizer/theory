function R= weights(method)
n= 1000;  % voters turn out
m= 20;    % candidates
R=[0 0 0];

% cycle over number of votes cast by the last voter
x= [1:m];
for nv=x

  % repeat simplation
  r=[];
  for s=1:5000
      
    % first n-1 voters vote randomly
    V= floor(3*rand(n-1,m))-1;
    V= V(sum(V,2)~=0,:);

    % determine vote vector for the last voter
    % The first half candidates are voted with +1
    % Then the second half is filled with -1, starting with the worst
    Vp= zeros(1,m);
    sp= ceil(m/2);
    if nv > sp
      Vp(1 : sp)= 1;
      Vp(end +sp-nv+1 : end)= -1;
    else
      Vp(1:nv)= 1;
    end

    % Cast vote for the last voter
    V= [V, Vp];

    % Normalize 
    if strcmp(method, 'approval')
      % Votes are in the range [-1:1]
    elseif strcmp(method, 'liquidizer')
      % normalize non zero voting vectors with 2-norm
      V= diag(sparse(1./sqrt(sum(V.^2,2)))) * V;
    elseif strcmp(method, 'cumulative')
      % normalization with 1-norm
      V= diag(sparse(1./(sum(abs(V),2)))) * V;
    else
      error('unknown method: %s', method);
    end

    % result of all votes
    r1= sum(V);
    r1= mean(find(r1==max(r1)));
    
    % result excluding the last vote
    r2= sum(V(1:end-1,:));
    r2= mean(find(r2==max(r2)));
    % store if prefered candidate was electe
    r= [r; r1<r2];
  end

  % store result and error for vote number
  e= std(r)/sqrt(s);
  R=[R; nv, mean(r), e];
end
end

