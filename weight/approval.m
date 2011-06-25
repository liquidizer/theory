methods= {'approval', 'liquidizer', 'cumulative'};

R=[];
E=[];
X=[];
for i= 1 : length(methods)
  W= weights(methods{i});
  X=[X, W(:,1)];
  R=[R, W(:,2)];
  E=[E, W(:,3)];
end

%errorbar(X,R,E)
plot(X,R)
legend(methods)
