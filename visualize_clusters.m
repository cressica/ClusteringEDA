% Jaccard Index 
% Ward:6 clusters 
% cluster 1:  

figure
colormap(color);
imagesc(M2(cluster1(:,1),:));
set(gca,'xtick',12:12:288);
set(gca,'XTickLabel',1:1:24);
xlabel('Time of Day', 'FontSize', 18);
ylabel('User-Day ID','FontSize', 18);
lcolorbar(label,'fontweight','bold','FontSize', 14);



figure
colormap(color);
imagesc(M2(cluster2(:,1),:));
set(gca,'xtick',12:12:288);
set(gca,'XTickLabel',1:1:24);
xlabel('Time of Day', 'FontSize', 18);
ylabel('User-Day ID','FontSize', 18);
lcolorbar(label,'fontweight','bold','FontSize', 14);

figure
colormap(color);
imagesc(M2(cluster3(:,1),:));
set(gca,'xtick',12:12:288);
set(gca,'XTickLabel',1:1:24);
xlabel('Time of Day', 'FontSize', 18);
ylabel('User-Day ID','FontSize', 18);
lcolorbar(label,'fontweight','bold','FontSize', 14);

figure
colormap(color);
imagesc(M2(cluster4(:,1),:));
set(gca,'xtick',12:12:288);
set(gca,'XTickLabel',1:1:24);
xlabel('Time of Day', 'FontSize', 18);
ylabel('User-Day ID','FontSize', 18);
lcolorbar(label,'fontweight','bold','FontSize', 14);

figure
colormap(color);
imagesc(M2(cluster5(:,1),:));
set(gca,'xtick',12:12:288);
set(gca,'XTickLabel',1:1:24);
xlabel('Time of Day', 'FontSize', 18);
ylabel('User-Day ID','FontSize', 18);
lcolorbar(label,'fontweight','bold','FontSize', 14);

figure
colormap(color);
imagesc(M2(cluster6(:,1),:));
set(gca,'xtick',12:12:288);
set(gca,'XTickLabel',1:1:24);
xlabel('Time of Day', 'FontSize', 18);
ylabel('User-Day ID','FontSize', 18);
lcolorbar(label,'fontweight','bold','FontSize', 14);



%% day of week summary for each cluster
c1day=DayOfWeek_Num(cluster1,:);
c2day=DayOfWeek_Num(cluster2,:);
c3day=DayOfWeek_Num(cluster3,:);
c4day=DayOfWeek_Num(cluster4,:);
c5day=DayOfWeek_Num(cluster5,:);
c6day=DayOfWeek_Num(cluster6,:);

tabulate(c1day)
tabulate(c2day)
tabulate(c3day)
tabulate(c4day)
tabulate(c5day)
tabulate(c6day)


%% write cluster id to a variable.
l=size(UserID_ID,1);
class=zeros(l,1);

class(cluster1,1)=1;
class(cluster2,1)=2;
class(cluster3,1)=3;
class(cluster4,1)=4;
class(cluster5,1)=5;
class(cluster6,1)=6;


csvwrite('class.csv',class);
















  