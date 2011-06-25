function rank=schulze(M)

% number of candidates
C= size(M,2);

% distance
d= zeros(C,C);
for i = 1:C
  for j = 1:C
    for k= 1:size(M,1)
      if M(k,i) > M(k,j)
	d(i,j) = d(i,j) + 1;
      end
    end
  end
end

% schulze method according to Wikipedia
for i = 1:C
   for j = 1:C
      if ( i ~= j )
         if ( d(i,j) > d(j,i) )
            p(i,j) = d(i,j);
         end
         else
            p(i,j) = 0;
         end
      end
   end
end
 
for i = 1:C
   for j = 1:C
      if ( i ~= j )
         for k = 1:C
            if ( i ~= k )
               if ( j ~= k )
                  p(j,k) = max ( p(j,k), min ( p(j,i), p(i,k) ) );
               end
            end
         end
      end
   end
end

% count ranking
rank= zeros(1,C);
for i = 1:C
  for j = 1:C
    if p(i,j) < p(j,i)
      rank(i) = rank(i) + 1;
    end
  end
end