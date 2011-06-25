function [X,Y]= utility(method)

  np= 10;    % number of voters
  nq= 11;    % number of initiatives
  cov= 1;    % covariance in preferences

  % choose choose random preferences for voters
  U= randn(np,nq);
  C= cov*randn(nq,nq,np);
  %C= cov*repmat(randn(nq,nq),[1,1,np]);

  [M,v]= liquidizer(U,C, method);

  % compute the marginal utility for each participant
  nu= zeros(np,nq);
  h=0.01;
  for j= 1 : nq
    M2= double(M);
    M2(j)= M2(j)+h;
    for i= 1 : np
      s1= satisfaction(U(i,:), C(:,:,i), M);
      s2= satisfaction(U(i,:), C(:,:,i), M2);
      nu(i,j)= (s2-s1)/h;
    end
  end

  X= zeros(nq,np);
  Y= zeros(nq,np);
  for i=1:np
    A= sortrows([nu(i,:);v(i,:)]');
    X(:,i)= A(:,1);
    Y(:,i)= A(:,2);
  end
  plot(X,Y,'@')
end
