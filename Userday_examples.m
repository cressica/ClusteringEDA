user=802; %type in userid (original id)
id(find(userid==user)) %id is user-day id 
DayOfWeek(10:16,:) % look up week of day for user-day(10-16)


figure
colormap(color);
imagesc(M2(cluster1(:,1),:));
set(gca,'xtick',12:12:288);
set(gca,'XTickLabel',1:1:24);
lcolorbar(label,'fontweight','bold','FontSize', 14);
title('Cluster1','FontSize', 18);
xlabel('Time of Day', 'FontSize', 18);
ylabel('Day of Week','FontSize', 18);

figure
colormap(color);
imagesc(M2(cluster2(:,1),:));
set(gca,'xtick',12:12:288);
set(gca,'XTickLabel',1:1:24);
set(gca,'YTickLabel');
lcolorbar(label,'fontweight','bold','FontSize', 14);
title('Cluster2','FontSize', 18);
xlabel('Time of Day', 'FontSize', 18);
ylabel('Day of Week','FontSize', 18);



figure
colormap(color);
imagesc(M2(cluster2(:,1),:));
set(gca,'xtick',12:12:288);
set(gca,'XTickLabel',1:1:24);
set(gca,'YTickLabel',{'Fri';'Wed';'Thu';'Thu';'Thu';'Tue';'Fri'});
lcolorbar(label,'fontweight','bold','FontSize', 14);
title('Cluster3','FontSize', 18);
xlabel('Time of Day', 'FontSize', 18);
ylabel('Day of Week','FontSize', 18);




user=558; %type in userid (original id)
id(find(userid==user)) %id is user-day id  
DayOfWeek(472:475,:)       
    
figure
colormap(color);
imagesc(M2(472:475,:));
set(gca,'xtick',12:12:288);
set(gca,'XTickLabel',1:1:24);
set(gca,'ytick',1:1:5);
set(gca,'YTickLabel',{'Fri';'Fri';'Tue';'Mon';'Thu'});
lcolorbar(label,'fontweight','bold','FontSize', 14);
title('User 558 (Retired/55-59 yrs/Male/No Income','FontSize', 18);
xlabel('Time of Day', 'FontSize', 18);
ylabel('Day of Week','FontSize', 18);


user=558; %type in userid (original id)
id(find(userid==user)) %id is user-day id  
DayOfWeek(472:475,:)       
    
figure
colormap(color);
imagesc(M2(472:475,:));
set(gca,'xtick',12:12:288);
set(gca,'XTickLabel',1:1:24);
set(gca,'ytick',1:1:5);
set(gca,'YTickLabel',{'Fri';'Fri';'Tue';'Mon';'Thu'});
lcolorbar(label,'fontweight','bold','FontSize', 14);
title('User 558 (Retired/55-59 yrs/Male/No Income','FontSize', 18);
xlabel('Time of Day', 'FontSize', 18);
ylabel('Day of Week','FontSize', 18);

user=684; %type in userid (original id)
id(find(userid==user)) %id is user-day id 
DayOfWeek(541:543,:) % look up week of day for user-day(10-16)

figure
colormap(color);
imagesc(M2(541:543,:));
set(gca,'xtick',12:12:288);
set(gca,'XTickLabel',1:1:24);
set(gca,'ytick',1:1:5);
set(gca,'YTickLabel',{'Mon';'Tue';'Wed'});
lcolorbar(label,'fontweight','bold','FontSize', 14);
title('User 684 (Full-time student/20-24 yrs/Male/No Income)','FontSize', 18);
xlabel('Time of Day', 'FontSize', 18);
ylabel('Day of Week','FontSize', 18);


user=462; %type in userid (original id)
id(find(userid==user)) %id is user-day id 
DayOfWeek(507:511,:) % look up week of day for user-day(10-16)

figure
colormap(color);
imagesc(M2(507:511,:));
set(gca,'xtick',12:12:288);
set(gca,'XTickLabel',1:1:24);
set(gca,'ytick',1:1:5);
set(gca,'YTickLabel',{'Wed';'Fri';'Fri';'Thu';'Tue'}); 
lcolorbar(label,'fontweight','bold','FontSize', 14);
title('User 462 (Full-time student/15-19 yrs/Female/No Income)','FontSize', 18);
xlabel('Time of Day', 'FontSize', 18);
ylabel('Day of Week','FontSize', 18);


user=1263; %type in userid (original id)
id(find(userid==user)) %id is user-day id 
DayOfWeek(676:682,:) % look up week of day for user-day(10-16)

figure
colormap(color);
imagesc(M2(676:682,:));
set(gca,'xtick',12:12:288);
set(gca,'XTickLabel',1:1:24);
set(gca,'ytick',1:1:7);
set(gca,'YTickLabel',{'Fri','Tue','Mon','Thu','Wed','Thu','Fri'});
lcolorbar(label,'fontweight','bold','FontSize', 14);
title('User 1263 (Full-time employed/40-44 yrs/Male/8000+)','FontSize', 18);
xlabel('Time of Day', 'FontSize', 18);
ylabel('Day of Week','FontSize', 18);