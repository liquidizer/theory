function str = formatResult(v)

R= sum(v,1);
str=char(zeros(1,length(R)));
for i=1:length(R)
    if R(i)>0
         str(i)='Y';
    else
        str(i)='N';
    end
end