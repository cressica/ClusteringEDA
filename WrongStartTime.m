% check: if the starting point is 0:00

i=1;
wrongStart=zeros(size(seq_userday,1),1);

for i=2:1:size(seq_userday,1)
    if (seq_userday(i,1)~=seq_userday(i-1,1) && (seqTimeVec(i,4)~=0 || seqTimeVec(i,5)~=0)) %if userday id changes
        wrongStart(i)=1;
    end
end

sum(wrongStart)

wrongStartUserDayID=seq_userday(find(wrongStart~=0));





    

