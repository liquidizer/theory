M = [ ...
   1   5   3   4   2
   3   2   1   5   4
   2   4   3   1   5
   3   5   2   4   1
   2   1   3   4   5
   5   2   4   1   3
   4   1   5   2   3
   5   4   1   3   2
   3   5   2   4   1
   3   1   5   2   4
   2   3   5   4   1
   1   2   5   4   3];

% make wiki syntax
out=fopen('voters.txt','w')
fprintf(out,"{|\n")
chars="ABCDEF";
fprintf(out,"| preference/voter\n")
for col= 1:size(M,1)
  fprintf(out,"| %d\n", col)
end
for row= 1:size(M,2)
  fprintf(out,"|-\n")
  fprintf(out,"| %d",row)
  for col= 1:size(M,1)
    fprintf(out,"| %s\n", chars(find(M(col,:)==row))) 
  end
end
fprintf(out,"|}\n")
fclose(out)

% print rankings
rank1= schulze(M)
rank2= schulze([M;1,0,0,0,0])
rank3= schulze([M;2,1,0,0,0])