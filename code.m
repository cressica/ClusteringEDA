% create id for unique user-day
formatIn = 'dd-mm-yyyy HH:MM:SS'
datevec=datevec(StartTime,formatIn)
formatOut = 'dd-mm-yyyy';
date=datestr(datevec,formatOut);

formatIn = 'dd-mm-yyyy';

dateNum=datenum(date,formatIn,'2013');

StartTimeNum=datenum(StartTime,formatIn);


dateNum(1:20)

str1=num2str(userid);
str2=num2str(dateNum,6);
str=strcat(str1,str2);

x = str2num(str);

j=1;
id(1,1)=j; 
i=2;
while i<=size(x,1)
    if x(i,1)==x(i-1,1);
        id(i,1)=j;
        i=i+1;
    else 
        j=j+1;
        id(i,1)=j;
        i=i+1;
    end
end


%extract the sequence of time(start-end-start-end) for each person
i=1;
j=1;
while i<=size(id,1) %loop over rows
    seq_userday(j,1)=id(i);
    seqTime(j,1)=startTime(i);
    j=j+1;
    seqTime(j,1)=endTime(i);
    seq_userday(j,1)=id(i);
    j=j+1;
    i=i+1;
end

% convert it to time vector 
formatIn = 'dd-mm-yyyy HH:MM:SS';
seqTimeVec=datevec(seqTime,formatIn);

j=2;
dur(1,1)=0;
while j<=size(seq_userday,1)
    if seq_userday(j)==seq_userday(j-1)
        dur(j,1)=etime(seqTimeVec(j,:),seqTimeVec(j-1,:))/60; %minutes between every two time points. 
        j=j+1;
    else
        dur(j,1)=0;
        j=j+1;
    end
end


% seqTimeVec


% group activities and code 
activity_code=zeros(size(activity,1),1);
activity_code(find(activity=='Home'))=1;
activity_code(find(activity=='Work'))=2;
activity_code(find(activity=='Work-Related Business'))=3;
activity_code(find(activity=='Education'))=4;
activity_code(find(activity=='Pick Up/Drop Off'))=5;
activity_code(find(activity=='Personal Errand/Task'))=6;
activity_code(find(activity=='Meal/Eating Break'))=7;
activity_code(find(activity=='Shopping'))=8;
activity_code(find(activity=='Social'))=9;
activity_code(find(activity=='Recreation'))=10;
activity_code(find(activity=='Entertainment'))=11;
activity_code(find(activity=='Sports/Exercise'))=12;
activity_code(find(activity=='To Accompany Someone'))=13;
%activity_code(find(activity=='Other's Home''))=14;
activity_code(find(activity=='Medical/Dental (Self)'))=15;
activity_code(find(activity=='Other'))=16;
activity_code(find(activity=='Change Mode/Transfer'))=99; %this should be considered as mobility 
activity_code(find(activity_code==0))=14;


mode=nominal(mode1);
mode_code=zeros(size(mode,1),1);
mode_code(find(mode=='Car/Van'))=21;
mode_code(find(mode=='Bus'))=22;
mode_code(find(mode=='LRT/MRT'))=23;
mode_code(find(mode=='Foot'))=24;
mode_code(find(mode=='Taxi'))=25;
mode_code(find(mode=='Motorcycle/Scooter'))=26;
mode_code(find(mode=='Bicycle'))=27;
mode_code(find(mode=='Other'))=28;
% Default(starting point at home) or missing values: 0



%sequence of mode-activity for each person. Output: seqstat
%(mode-act-mode-act...starting mode should be 0(how to reach home at 00:00), but most of them have a mode.
%when creating activity matrix, this value would not affect)

i=1;
j=1;
while i<=size(id,1) %loop over  rows
    seq_userday(j,1)=id(i);
    seqstat(j,1)=mode_code(i);
    j=j+1;
    seqstat(j,1)=activity_code(i);
    seq_userday(j,1)=id(i);
    j=j+1;
    i=i+1;
end


% verify a user 2's information 
ind=find(seq_userday==2);
seq_userday(ind); 
seqTime(ind); 
seqstat(ind);

% create activity-mode matrix for 24-hour period for each user-day (id) 

%for i=1:1:size(seq_userday)
M_new=ones(1111,288);%1111 userdays * 288 intervals. 
M_new=-M_new;

i=1;
j=0;
for row=1:1:1111 %row: userday 
    j=0;
    if (ismember(row,wrongStartUserDayID)==1) %if starting time is not 00:00:00
        temp=find(seq_userday==row);
        elapse=(seqTimeVec(temp(1),4)*60+seqTimeVec(temp(1),5));
        step=round(elapse/5);
        M_new(row,(j+1):(j+step))=1; % update to home
        j=j+step;
    end 
    while (seq_userday(i,1)==row && j<=288)
        step=round(dur(i,1)/5);
        if(step>=1)
            if (j+step<=288)
                M_new(row,(j+1):(j+step))=seqstat(i,1);
                j=j+step;
            else   
                M_new(row,(j+1):288)=seqstat(i,1);
            end
        end
        i=i+1;
    end
    if (j<288 && M_new(row,(j+1))<0)
        M_new(row,(j+1):288)=M_new(row,j);
    end
    if (ismember(row,wrongEndUserDayID)==1)
        temp1=find(seq_userday==row);
        last=size(temp1,1);
        TimeLeft=1440-(seqTimeVec(temp1(last),4)*60+seqTimeVec(temp1(last),5));
        step1=round(TimeLeft/5);
        M_new(row,(288-step1+1):288)=1;
    end
end


% combine activity categories: M1
%M1: activity+travel: combined activities;combine all modes to travel:100 (no mode)

M=M_new;
M1=M;
M1(find(M==10|M==11|M==12))=17; %17-recreation/entertainment/sports.
M1(find(M==15|M==6))=18; % 18-personal (include medical)
M1(find(M==13|M==14))=19; % 19-other's home (include accompany someone)
M1(find(M==0))=16; %16-other(including missing values-0)
M1(find(M>20))=100;% 100-travel 


%M2: recode the activities and travel(0) to match the Boston labels. 
M2=M1;
M2(find(M1==100))=0;%Travel 
M2(find(M1==1))=1;% Home
M2(find(M1==5))=2;
M2(find(M1==2))=3;
M2(find(M1==3))=4;
M2(find(M1==4))=5;
M2(find(M1==8))=6;
M2(find(M1==9))=7;
M2(find(M1==17))=8;
M2(find(M1==7))=9;
M2(find(M1==18))=10;
M2(find(M1==19))=11;
M2(find(M1==16))=12;


%color map 
figure
colormap(color)

label={'Travel','Home','Pu/Do','Work','Work-Rel','School','Shopping','Social','Recreation','Eating','Errand/Task','Visit Someone','Other'};

imagesc(M2);
set(gca,'xtick',12:12:288);
set(gca,'XTickLabel',1:1:24);
xlabel('Time of Day', 'FontSize', 18);
ylabel('User-Day ID','FontSize', 18);
title('Individual daily activities (all user-days)');
lcolorbar(label,'fontweight','bold','FontSize', 18);



color =

    0.5843    0.3882    0.3882
    1.0000    0.9686    0.9216
    1.0000    0.6000    0.7843
         0    0.4000    1.0000
    0.8549    0.7020    1.0000
    1.0000    1.0000         0
    0.8706    0.4902         0
    0.6784    0.9216    1.0000
         0    0.4980         0
    1.0000    0.6941    0.3922
    0.7569    0.8667    0.7765
    0.7490         0    0.7490
    1.0000    0.9490    0.8667

    




% create day of week variable for each user-day 

[DayNumber,DayName] = weekday(datenum(startTime,'dd-mm-yyyy HH:MM:SS'));% day of week for each stay in the original data

i=1;
j=1;
DayOfWeek(j,:)=DayName(i,:);
for i=2:1:size(id,1) %id is user-day id
    if id(i,1)~=id(i-1,1)
        j=j+1;
        ID_MBW(j,1)=id(i,1);
        DayOfWeek(j,:)=DayName(i,:);
    end
end

i=1;
j=1;
DayOfWeek_Num(j,:)=DayNumber(i,:);
for i=2:1:size(id,1) %id is user-day id
    if id(i,1)~=id(i-1,1)
        j=j+1;
        ID_MBW(j,1)=id(i,1);
        DayOfWeek_Num(j,:)=DayNumber(i,:);
    end
end

DayOfWeek_Num=DayOfWeek_Num-1;


% create date variable for each user-day (1111) using seqTimeVec

i=1;
j=1;
Date(j,:)=seqTimeVec(i,1:3);
for i=2:1:size(seq_userday,1) %id is user-day id
    if seq_userday(i,1)~=seq_userday(i-1,1)
        j=j+1;
        Date(j,:)=seqTimeVec(i,1:3);
    end
end


% create date variable for each user-day (1111) using seqTime

i=1;
j=1;
DateComb(j,:)=seqTime(i,1);
for i=2:1:size(id,1) %id is user-day id
    if id(i,1)~=id(i-1,1)
        j=j+1;
        DateComb(j,:)=seqTime(i,1);
    end
end

%create serial date for each user-day(1111) using dateNum

i=1;
j=1;
dateSerial(j,:)=dateNum(i,1);

for i=2:1:size(id,1) %id is user-day id
    if id(i,1)~=id(i-1,1)
        j=j+1;
        dateSerial(j,:)=dateNum(i,1);
    end
end



csvwrite('Date.csv',Date);
csvwrite('dateSerial.csv',dateSerial);


%% UserID, UserDayID 

ID1 = unique(ID,'rows')



%% visualize individual users' activity-travel pattern 



% Check the clustering results by visualizing the locaiton matrix 
figure
colormap(color);
imagesc(M2([],:));
set(gca,'xtick',12:12:288);
set(gca,'XTickLabel',1:1:24);
lcolorbar(label,'fontweight','bold','FontSize', 14);


figure
colormap(color);
imagesc(M2([231  233  248  251  259  272  273  276  277  318  333  360  362  363  364  366  367  375  379  380  390  423  424  425  426  438  443  444  445  479  480],:));
set(gca,'xtick',12:12:288);
set(gca,'XTickLabel',1:1:24);
lcolorbar(label,'fontweight','bold','FontSize', 14);



imagesc(M2(97,:));
imagesc(M2(313,:));
lcolorbar(label,'fontweight','bold','FontSize', 14);


figure
colormap(color);
imagesc(M2([350  355  388  393  419  436  449  453  528  529  551  567  592  593  607  609  612  625  627  634  651  667  673  675  678  679  680  687  693  712  733],:));
set(gca,'xtick',12:12:288);
set(gca,'XTickLabel',1:1:24);
lcolorbar(label,'fontweight','bold','FontSize', 14);


figure
colormap gray
imagesc(MBW_act(4:5,:));


    %% generate binary matrix: MBW_act
[Mbw] = generate_binary(M2); %L_a12 is the color matrix with 12 types of activities 
MBW_act=Mbw;
save MBW_act; 

figure
colormap gray
imagesc(MBW_act);

label=('Home','Pu/Do','Work','Work-Rel','School','Shopping','Social','Recreation','Eating','Errand/Task','Visit Someone','Other','Travel'};
set(gca,'xtick',144:288:3600);
set(gca,'XTickLabel',label_act,'FontSize',13);
ylabel('User-day ID','FontSize',16);


csvwrite('DayOfWeek_Num.csv',DayOfWeek_Num);

%%



%% 



'Home'
'Work'
'Work-Related Business'
'Education'
'Pick Up/Drop Off'
'Personal Errand/Task'
'Meal/Eating Break'
'Shopping'
'Social'
'Recreation'
'Entertainment'
'Sports/Exercise'
'To Accompany Someone'
'Other's Home'
'Other'

'Change Mode/Transfer'

