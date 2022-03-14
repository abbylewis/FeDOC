% Script to import ctd data and plot it in contour plot
clear, clc;

% Load data and assign columns to variables
data=table2array(readtable('../CTD_2019/CTD_matlab_ready_2019_fcr50.csv','TreatAsEmpty','NA'));
date=data(:,1);
elev=data(:,2);
temp=data(:,3);
chla=data(:,4);
turb=data(:,5);
cond=data(:,6);
spcc=data(:,7);
do=data(:,8);
psat=data(:,9);
ph=data(:,10);
orp=data(:,11);
par=data(:,12);
sal=data(:,13);
desc=data(:,14);
dens=data(:,15);
flag=data(:,16);
tss=unique(date);

% Excludes the invalid data (nans)- CHRIS CHEN EDITED THIS - intrepolate between 
% missing data
temp_vidx=~isnan(temp);
chla_vidx=~isnan(chla);
turb_vidx=~isnan(turb);
cond_vidx=~isnan(cond);
spcc_vidx=~isnan(spcc);
do_vidx=~isnan(do);
psat_vidx=~isnan(psat);
ph_vidx=~isnan(ph);
orp_vidx=~isnan(orp);
par_vidx=~isnan(par);
sal_vidx=~isnan(sal);
desc_vidx=~isnan(desc);
dens_vidx=~isnan(dens);
flag_vidx=~isnan(flag);

% Set x and y limits NOTE: y-limits are specific to FCR
% xmin=min(date);
% xmax=max(date);
DateStart = '01-Jun-2019';
DateEnd = '21-Nov-2019';
formatIn = 'dd-mmm-yyyy';
xmin = datenum(DateStart,formatIn);
xmax = datenum(DateEnd,formatIn);
ymin=0; %min(elev);
ymax=9.3; %max(elev);
DO_on = ["2019-06-03 15:57:00" "2019-07-08 13:34:00" "2019-08-05 12:45:00" "2019-09-02 13:00:00"]; 
DO_off = ["2019-06-17 15:04:00" "2019-07-19 15:00:00" "2019-08-19 12:32:00" "2019-11-20 13:00:00"];
formatDO = 'yyyy-mm-dd HH:MM:SS';
DO_onDate = datenum(DO_on,formatDO);
DO_offDate = datenum(DO_off,formatDO);

% Creates a function based on data for T and DO: remove
% invalid data points
F_temp=scatteredInterpolant(date(temp_vidx),elev(temp_vidx),temp(temp_vidx),'linear','linear');
F_chla=scatteredInterpolant(date(chla_vidx),elev(chla_vidx),chla(chla_vidx),'linear','linear');
F_turb=scatteredInterpolant(date(turb_vidx),elev(turb_vidx),turb(turb_vidx),'linear','linear');
F_cond=scatteredInterpolant(date(cond_vidx),elev(cond_vidx),cond(cond_vidx),'linear','linear');
F_spcc=scatteredInterpolant(date(spcc_vidx),elev(spcc_vidx),spcc(spcc_vidx),'linear','linear');
F_do=scatteredInterpolant(date(do_vidx),elev(do_vidx),do(do_vidx),'linear','linear');
F_psat=scatteredInterpolant(date(psat_vidx),elev(psat_vidx),psat(psat_vidx),'linear','linear');
F_ph=scatteredInterpolant(date(ph_vidx),elev(ph_vidx),ph(ph_vidx),'linear','linear');
F_orp=scatteredInterpolant(date(orp_vidx),elev(orp_vidx),orp(orp_vidx),'linear','linear');
F_par=scatteredInterpolant(date(par_vidx),elev(par_vidx),par(par_vidx),'linear','linear');
F_sal=scatteredInterpolant(date(sal_vidx),elev(sal_vidx),sal(sal_vidx),'linear','linear');
F_desc=scatteredInterpolant(date(desc_vidx),elev(desc_vidx),desc(desc_vidx),'linear','linear');
F_dens=scatteredInterpolant(date(dens_vidx),elev(dens_vidx),dens(dens_vidx),'linear','linear');
F_flag=scatteredInterpolant(date(flag_vidx),elev(flag_vidx),flag(flag_vidx),'linear','linear');


% Define the plotting range
[x,y]=meshgrid(xmin:1:xmax,ymin:0.1:ymax);
temp_plot=F_temp(x,y);
chla_plot=F_chla(x,y);
turb_plot=F_turb(x,y);
cond_plot=F_cond(x,y);
spcc_plot=F_spcc(x,y);
do_plot=F_do(x,y);
psat_plot=F_psat(x,y);
ph_plot=F_ph(x,y);
orp_plot=F_orp(x,y);
par_plot=F_par(x,y);
sal_plot=F_sal(x,y);
desc_plot=F_desc(x,y);
dens_plot=F_dens(x,y);
flag_plot=F_flag(x,y);


% Define contours and breaks
t=ceil(max(temp));
contt=(4:0.1:30);

cl=ceil(max(chla));
contchla=(0:0.1:8);

tu=ceil(max(turb));
contturb=(0:0.1:20);

co=ceil(max(cond));
contco=(20:0.1:100);

sp=ceil(max(spcc));
contsp=(20:0.1:130);

d=ceil(max(do));
contd=(0:0.1:12);

ps=ceil(max(psat));
contps=(0:0.1:150);

p=ceil(max(ph));
contp=(5:0.1:10);

or=ceil(max(orp));
contor=(-400:0.1:400);

pr=ceil(max(par));
contpr=(0:1:1000);

sa=ceil(max(sal));
contsa=(0:0.01:0.05);

dc=ceil(max(desc));
contdc=(0:0.01:0.3);

dn=ceil(max(dens));
contdn=(995:0.1:1000);

fg=ceil(max(flag));
contfg=(0:0.1:1);

%% 

% Plot T contours
figure
contourf(x,y,temp_plot,contt,'EdgeColor','none');
set(gca,'FontSize',18)
haxes = gca;
datetick('x','dd mmm ','keeplimits','keepticks')
ylabel('Depth (m)','FontSize',18);
caxis([9,30]);
hT = colorbar;
set(hT,'FontSize',18);
ylabel(hT, 'Temperature (^{o}C)','FontSize',18)
%xlabel('Date','FontSize',10);
colormap(haxes, hot)
set(gca,'YDir','reverse')
hold on

%plot important date lines
plot([DO_onDate DO_onDate],[0 9.3],'-','linewidth',2,'color','black')
plot([DO_offDate DO_offDate],[0 9.3],'--','linewidth',2,'color','black')
hold on

formatIn = 'dd-mmm-yyyy';
dates = datenum(["01-06-2019" "01-07-2019" "01-08-2019" "01-09-2019" "01-10-2019" "01-11-2019" "01-12-2019"],formatIn);
xticks(dates);
xticklabels(datestr(dates, 'mmm'))
xlim('manual')

%plot_loc=sort([DO_onDate' DO_offDate']);
%xticks(plot_loc);
%xticklabels(datestr(plot_loc, 'dd mmm'))
% plot triangles on top of figure showing sampling dates
ylim1=get(gca,'ylim')+0.04;
plot(tss,linspace(ylim1(1),ylim1(1),length(tss)),'v','color','black','markerfacecolor','black');

%date labels for oxygenation
txt_ht_on = repmat(0.6,length(DO_onDate),1);
txt_ht_off = repmat(0.6,length(DO_offDate)-1,1);
txt_pos_on = DO_onDate(1:end) + 1;
txt_pos_off = DO_offDate(1:end-1) + 1;
text(txt_pos_on, txt_ht_on, "on", 'FontSize',18)
text(txt_pos_off, txt_ht_off, "off", 'FontSize',18)

% plot important date labels
%plot_loc=ylim1(2)-(ylim1(2)-ylim1(1))/6;
%text(SSS_on-lb_offset,plot_loc,'SSS ON','color','black','fontsize',10,'rotation',90);

% plot important date lines
%plot([SSS_on SSS_on],[0 10],'-','linewidth',2,'color','black')

%set(gca,'ylim',[ylim1(1) ylim1(2)])
saveas(gcf,'FCRTEMP2019', 'tif')
hold off


%% 

% Plot DO contours
contourf(x,y,do_plot,contd,'EdgeColor','none');
set(gca,'FontSize',18)
ax1 = gca;
datetick('x','dd mmm','keeplimits','keepticks')
ylabel('Depth (m)','FontSize',18);
caxis([0, 12]);
hDO = colorbar;
set(hDO,'fontsize',18);
ylabel(hDO, 'Dissolved Oxygen (mg L^{-1})','FontSize',18)
colormap(ax1, flipud(jet))

set(gca,'YDir','reverse')
hold on

%plot important date lines
plot([DO_onDate DO_onDate],[0 9.3],'-','linewidth',2,'color','black')
plot([DO_offDate DO_offDate],[0 9.3],'--','linewidth',2,'color','black')
hold on

%Add date labels
formatIn = 'dd-mmm-yyyy';
dates = datenum(["01-06-2019" "01-07-2019" "01-08-2019" "01-09-2019" "01-10-2019" "01-11-2019"],formatIn);
xticks(dates);
xticklabels(datestr(dates, 'mmm'))
xlim manual;
hold on

%date labels for oxygenation
txt_ht_on = repmat(0.6,length(DO_onDate),1);
txt_ht_off = repmat(0.6,length(DO_offDate)-1,1);
txt_pos_on = DO_onDate(1:end) + 1;
txt_pos_off = DO_offDate(1:end-1) + 1;
text(txt_pos_on, txt_ht_on, "on", 'FontSize',18)
text(txt_pos_off, txt_ht_off, "off", 'FontSize',18)

% plot triangles on top of figure showing sampling dates
ylim1=get(gca,'ylim')+0.04;
title("Falling Creek Reservoir")
plot(tss,linspace(ylim1(1),ylim1(1),length(tss)),'v','color','black','markerfacecolor','black')

saveas(gcf,'FCRDO2019', 'tif')

hold off

%% 

% Plot ORP contours
contourf(x,y,orp_plot,contor,'EdgeColor','none');
set(gca,'FontSize',18)
% ax1 = gca
datetick('x','dd mmm','keeplimits','keepticks')
ylabel('Depth (m)','FontSize',18);
%caxis([0, 12]);
hChla = colorbar;
set(hChla,'fontsize',18);
ylabel(hChla, 'ORP','FontSize',18)
colormap(flipud(jet))

set(gca,'YDir','reverse')
hold on

%plot important date lines
plot([DO_onDate DO_onDate],[0 9.3],'-','linewidth',2,'color','black')
plot([DO_offDate DO_offDate],[0 9.3],'--','linewidth',2,'color','black')
hold on

%Add date labels
formatIn = 'dd-mmm-yyyy';
dates = datenum(["01-06-2019" "01-07-2019" "01-08-2019" "01-09-2019" "01-10-2019" "01-11-2019"],formatIn);
xticks(dates);
xticklabels(datestr(dates, 'mmm'))
xlim manual;
hold on

%date labels for oxygenation
txt_ht_on = repmat(0.6,length(DO_onDate),1);
txt_ht_off = repmat(0.6,length(DO_offDate)-1,1);
txt_pos_on = DO_onDate + 1;
txt_pos_off = DO_offDate(1:end-1) + 1;
text(txt_pos_on, txt_ht_on, "on", 'FontSize',18)
text(txt_pos_off, txt_ht_off, "off", 'FontSize',18)

% plot triangles on top of figure showing sampling dates
ylim1=get(gca,'ylim')+0.04;
title("Falling Creek Reservoir")
plot(tss,linspace(ylim1(1),ylim1(1),length(tss)),'v','color','black','markerfacecolor','black')

saveas(gcf,'FCRORP2019', 'tif')

hold off
%% % Script to import ctd data and plot it in contour plot
clear, clc;

% Load data and assign columns to variables
data=table2array(readtable('../CTD_2019/CTD_matlab_ready_2019_bvr50.csv','TreatAsEmpty','NA'));
date=data(:,1);
elev=data(:,2);
temp=data(:,3);
chla=data(:,4);
turb=data(:,5);
cond=data(:,6);
spcc=data(:,7);
do=data(:,8);
psat=data(:,9);
ph=data(:,10);
orp=data(:,11);
par=data(:,12);
sal=data(:,13);
desc=data(:,14);
dens=data(:,15);
flag=data(:,16);
tss=unique(date);

% Excludes the invalid data (nans)- CHRIS CHEN EDITED THIS - intrepolate between 
% missing data
temp_vidx=~isnan(temp);
chla_vidx=~isnan(chla);
turb_vidx=~isnan(turb);
cond_vidx=~isnan(cond);
spcc_vidx=~isnan(spcc);
do_vidx=~isnan(do);
psat_vidx=~isnan(psat);
ph_vidx=~isnan(ph);
orp_vidx=~isnan(orp);
par_vidx=~isnan(par);
sal_vidx=~isnan(sal);
desc_vidx=~isnan(desc);
dens_vidx=~isnan(dens);
flag_vidx=~isnan(flag);

% Set x and y limits NOTE: y-limits are specific to FCR
% xmin=min(date);
% xmax=max(date);
DateStart = '15-Jun-2019';
DateEnd = '20-Oct-2019';
formatIn = 'dd-mmm-yyyy';
xmin = datenum(DateStart,formatIn);
xmax = datenum(DateEnd,formatIn);
ymin=0.1; %min(elev);
ymax=10; %max(elev);

% Creates a function based on data for T and DO: remove
% invalid data points
F_temp=scatteredInterpolant(date(temp_vidx),elev(temp_vidx),temp(temp_vidx),'linear','linear');
F_chla=scatteredInterpolant(date(chla_vidx),elev(chla_vidx),chla(chla_vidx),'linear','linear');
F_turb=scatteredInterpolant(date(turb_vidx),elev(turb_vidx),turb(turb_vidx),'linear','linear');
F_cond=scatteredInterpolant(date(cond_vidx),elev(cond_vidx),cond(cond_vidx),'linear','linear');
F_spcc=scatteredInterpolant(date(spcc_vidx),elev(spcc_vidx),spcc(spcc_vidx),'linear','linear');
F_do=scatteredInterpolant(date(do_vidx),elev(do_vidx),do(do_vidx),'linear','linear');
F_psat=scatteredInterpolant(date(psat_vidx),elev(psat_vidx),psat(psat_vidx),'linear','linear');
F_ph=scatteredInterpolant(date(ph_vidx),elev(ph_vidx),ph(ph_vidx),'linear','linear');
F_orp=scatteredInterpolant(date(orp_vidx),elev(orp_vidx),orp(orp_vidx),'linear','linear');
F_par=scatteredInterpolant(date(par_vidx),elev(par_vidx),par(par_vidx),'linear','linear');
F_sal=scatteredInterpolant(date(sal_vidx),elev(sal_vidx),sal(sal_vidx),'linear','linear');
F_desc=scatteredInterpolant(date(desc_vidx),elev(desc_vidx),desc(desc_vidx),'linear','linear');
F_dens=scatteredInterpolant(date(dens_vidx),elev(dens_vidx),dens(dens_vidx),'linear','linear');
F_flag=scatteredInterpolant(date(flag_vidx),elev(flag_vidx),flag(flag_vidx),'linear','linear');


% Define the plotting range
[x,y]=meshgrid(xmin:1:xmax,ymin:0.1:ymax);
temp_plot=F_temp(x,y);
chla_plot=F_chla(x,y);
turb_plot=F_turb(x,y);
cond_plot=F_cond(x,y);
spcc_plot=F_spcc(x,y);
do_plot=F_do(x,y);
psat_plot=F_psat(x,y);
ph_plot=F_ph(x,y);
orp_plot=F_orp(x,y);
par_plot=F_par(x,y);
sal_plot=F_sal(x,y);
desc_plot=F_desc(x,y);
dens_plot=F_dens(x,y);
flag_plot=F_flag(x,y);


% Define contours and breaks
t=ceil(max(temp));
contt=(4:0.1:30);

cl=ceil(max(chla));
contchla=(0:0.1:8);

tu=ceil(max(turb));
contturb=(0:0.1:20);

co=ceil(max(cond));
contco=(20:0.1:100);

sp=ceil(max(spcc));
contsp=(20:0.1:130);

d=ceil(max(do));
contd=(0:0.1:12);

ps=ceil(max(psat));
contps=(0:0.1:150);

p=ceil(max(ph));
contp=(5:0.1:10);

or=ceil(max(orp));
contor=(-400:0.1:400);

pr=ceil(max(par));
contpr=(0:1:1000);

sa=ceil(max(sal));
contsa=(0:0.01:0.05);

dc=ceil(max(desc));
contdc=(0:0.01:0.3);

dn=ceil(max(dens));
contdn=(995:0.1:1000);

fg=ceil(max(flag));
contfg=(0:0.1:1);

%% 

% Plot T contours
contourf(x,y,temp_plot,contt,'EdgeColor','none');
set(gca,'FontSize',18)
haxes = gca;
datetick('x','dd mmm ','keeplimits','keepticks')
ylabel('Depth (m)','FontSize',18);
caxis([9,30]);
hT = colorbar;
set(hT,'FontSize',18);
ylabel(hT, 'Temperature (^{o}C)','FontSize',18)
%xlabel('Date','FontSize',10);
colormap(haxes, hot)
set(gca,'YDir','reverse')
hold on


formatIn = 'dd-mmm-yyyy';
dates = datenum(["01-06-2019" "01-07-2019" "01-08-2019" "01-09-2019" "01-10-2019" "01-11-2019"],formatIn);
xticks(dates);
xticklabels(datestr(dates, 'mmm'))
xlim('manual')

%plot_loc=sort([DO_onDate' DO_offDate']);
%xticks(plot_loc);
%xticklabels(datestr(plot_loc, 'dd mmm'))
% plot triangles on top of figure showing sampling dates
ylim1=get(gca,'ylim')+0.04;
plot(tss,linspace(ylim1(1),ylim1(1),length(tss)),'v','color','black','markerfacecolor','black')

% plot important date labels
%plot_loc=ylim1(2)-(ylim1(2)-ylim1(1))/6;
%text(SSS_on-lb_offset,plot_loc,'SSS ON','color','black','fontsize',10,'rotation',90);

% plot important date lines
%plot([SSS_on SSS_on],[0 10],'-','linewidth',2,'color','black')

%set(gca,'ylim',[ylim1(1) ylim1(2)])
hold off


%% 

% Plot DO contours
contourf(x,y,do_plot,contd,'EdgeColor','none');
set(gca,'FontSize',18)
ax1 = gca;
datetick('x','dd mmm','keeplimits','keepticks')
ylabel('Depth (m)','FontSize',18);
caxis([0, 12]);
hDO = colorbar;
set(hDO,'fontsize',18);
ylabel(hDO, 'Dissolved Oxygen (mg L^{-1})','FontSize',18)
colormap(ax1, flipud(jet))

set(gca,'YDir','reverse')
hold on


%Add date labels
formatIn = 'dd-mmm-yyyy';
dates = datenum(["01-06-2019" "01-07-2019" "01-08-2019" "01-09-2019" "01-10-2019" "01-11-2019"],formatIn);
xticks(dates);
xticklabels(datestr(dates, 'mmm'))
xlim('manual')
hold on

% plot triangles on top of figure showing sampling dates
ylim1=get(gca,'ylim')+0.04;

title("Beaverdam Reservoir")
plot(tss,linspace(ylim1(1),ylim1(1),length(tss)),'v','color','black','markerfacecolor','black')

hold off