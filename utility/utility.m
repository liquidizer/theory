function [X, Y, v]= utility(method, U, C, v)

  np= size(U,1); % number of participants
  nq= size(U,2); % number of queries

  v= liquidizer(U,C, method, v);
  M= sum(v,1)>0;
  
  % compute the marginal utility for each participant
%   nu= zeros(np,nq);
%   for j= 1 : nq
%     M2= double(M);
%     h=1*(1-2*M2(j));
%     M2(j)= M2(j)+h;
%     for i= 1 : np
%       s1= satisfaction(U(i,:), C(:,:,i), M);
%       s2= satisfaction(U(i,:), C(:,:,i), M2);
%       nu(i,j)= (s2-s1)/h;
%     end
%   end
% 
  X= zeros(nq,np);
  Y= zeros(nq,np);
  for i=1:np
    %A= sortrows([nu(i,:);v(i,:)]');
    %X(:,i)= A(:,1)/std(A(:,1));
    %Y(:,i)= A(:,2);
    X(:,i)= [1:nq];
    Y(:,i)= v(i,:);
  end
end
