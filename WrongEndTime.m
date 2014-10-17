% check: if the ending point is 23:59

i=1;
wrongEnd=zeros(size(seq_userday,1),1);

for i=2:1:size(seq_userday,1)
    if seq_userday(i,1)~=seq_userday(i-1,1) && (seqTimeVec(i-1,4)~=23 || seqTimeVec(i-1,5)~=59) %if userday id changes
        wrongEnd(i-1,1)=1;
    end
end

sum(wrongEnd);
wrongEndUserDayID=seq_userday(find(wrongEnd~=0));