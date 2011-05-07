
N= 12;
C= 5;

% additional vote
col= 1;
M2= zeros(1,C);
M2(:,col)= 1;

M3= zeros(1,C);
M3(:,1)= 2;
M3(:,2)= 1;
%M3= [C:-1:1]

P= 1000;
a= 0;
b= 0;
c= 0;
for i = 1:P
  % random vote
  M= rand(N,C);
  for j= 1:N
    n= sortrows([M(j,:);1:C]')';
    M(j,:)= n(2,:);
  end

  rank1= schulze(M);
  rank2= schulze([M; M2]);
  rank3= schulze([M; M3]);

  if rank2(col) < rank1(col)
    a=a+1;
    end
  if rank3(col) < rank1(col)
    b=b+1;
  end
end

[P, a, b]