% Script to import ctd data and plot it in contour plot
clear, clc;

% Load data and assign columns to variables
data=table2array(readtable('fcr_metals_matlab.csv','TreatAsEmpty','NA'));
date=data(:,1);
depth=data(:,2);
tfe=data(:,3);
sfe = data(:,4);
tss=unique(date);

% Interp missing data
tfe_interp=~isnan(tfe);
sfe_interp=~isnan(sfe);

% Deal with dates
DateStart = '01-Jun-2019';
DateEnd = '15-Aug-2019';
formatIn = 'dd-mmm-yyyy';
xmin = datenum(DateStart,formatIn);
xmax = datenum(DateEnd,formatIn);
ymin=0; %min(elev);
ymax=9.3; %max(elev);
DO_on = ["2019-06-03 15:57:00" "2019-07-08 9:30:00" "2019-08-05 12:45:00" "2019-09-02 13:00:00"]; 
DO_off = ["2019-06-17 15:04:00" "2019-07-18 00:00:00" "2019-08-19 13:00:00" "2019-10-31 00:00:00"];
formatDO = 'yyyy-mm-dd HH:MM:SS';
DO_onDate = datenum(DO_on,formatDO);
DO_offDate = datenum(DO_off,formatDO);

% Creates a function to interpolate concentrations as a function of date and depth
F_tfe=scatteredInterpolant(date(tfe_interp),depth(tfe_interp), tfe(tfe_interp),'linear');
F_sfe=scatteredInterpolant(date(sfe_interp),depth(sfe_interp), sfe(sfe_interp),'linear');

% Define the plotting range
[x,y]=meshgrid(xmin:1:xmax,ymin:0.1:ymax);
tfe_plot=F_tfe(x,y);
sfe_plot=F_sfe(x,y);

% Define contours and breaks
t2=ceil(max(tfe));
s2=ceil(max(sfe));

%% 

% Plot Tfe contours
subplot(2,2,3)
contourf(x,y,tfe_plot,'EdgeColor','none');
set(gca,'FontSize',18)
haxes = gca;
datetick('x','dd mmm ','keeplimits','keepticks')
ylabel('Depth (m)','FontSize',18);
caxis([0,20]);
hT2 = colorbar;
set(hT2,'FontSize',18);
ylabel(hT2, 'Total Fe (mg L^{-1})','FontSize',18)
%xlabel('Date','FontSize',10);
colormap(jet)
set(gca,'YDir','reverse')
hold on

%plot important date lines
plot([DO_onDate DO_onDate],[0 9.3],'-','linewidth',2,'color','white')
plot([DO_offDate DO_offDate],[0 9.3],'--','linewidth',2,'color','white')
hold on

formatIn = 'dd-mmm-yyyy';
dates = datenum(["01-06-2019" "01-07-2019" "01-08-2019" "01-09-2019" "01-10-2019"],formatIn);
xticks(dates);
xticklabels(datestr(dates, 'mmm'))
xlim('manual')

%date labels for oxygenation
txt_ht_on = repmat(0.6,length(DO_onDate),1);
txt_ht_off = repmat(0.6,length(DO_offDate),1);
txt_pos_on = DO_onDate + 2;
txt_pos_off = DO_offDate + 2;
text(txt_pos_on, txt_ht_on, "on", 'color','white','FontSize',18)
text(txt_pos_off, txt_ht_off, "off", 'color','white','FontSize',18)

%plot sampling dates as ticks
ylim1=get(gca,'ylim')+0.04;
plot(tss,linspace(ylim1(1),ylim1(1),length(tss)),'v','color','white','markerfacecolor','white');

saveas(gcf,'FCRTFe2019', 'tif')
hold off


%% 

% Plot Sfe contours
subplot(2,2,1)
contourf(x,y,sfe_plot,'EdgeColor','none');
set(gca,'FontSize',18)
haxes = gca;
datetick('x','dd mmm ','keeplimits','keepticks')
ylabel('Depth (m)','FontSize',18);
caxis([0,20]);
hS2 = colorbar;
set(hS2,'FontSize',18);
ylabel(hS2, 'Soluble Fe (mg L^{-1})','FontSize',18)
%xlabel('Date','FontSize',10);
colormap(jet)
set(gca,'YDir','reverse')
hold on

%plot important date lines
plot([DO_onDate DO_onDate],[0 9.3],'-','linewidth',2,'color','white')
plot([DO_offDate DO_offDate],[0 9.3],'--','linewidth',2,'color','white')
hold on

formatIn = 'dd-mmm-yyyy';
dates = datenum(["01-06-2019" "01-07-2019" "01-08-2019" "01-09-2019" "01-10-2019"],formatIn);
xticks(dates);
xticklabels(datestr(dates, 'mmm'))
xlim('manual')
%set(gca,'Xticklabel',[])

%date labels for oxygenation
txt_ht_on = repmat(0.6,length(DO_onDate),1);
txt_ht_off = repmat(0.6,length(DO_offDate),1);
txt_pos_on = DO_onDate + 2;
txt_pos_off = DO_offDate + 2;
text(txt_pos_on, txt_ht_on, "on", 'color','white','FontSize',18)
text(txt_pos_off, txt_ht_off, "off", 'color','white','FontSize',18)

%plot sampling dates as ticks
ylim1=get(gca,'ylim')+0.04;

title("Falling Creek Reservoir")
plot(tss,linspace(ylim1(1),ylim1(1),length(tss)),'v','color','white','markerfacecolor','white');

saveas(gcf,'FCRTFe2019', 'tif')
hold off


%% 
% Load data and assign columns to variables
data=table2array(readtable('bvr_metals_matlab.csv','TreatAsEmpty','NA'));
date=data(:,1);
depth=data(:,2);
tfe=data(:,3);
sfe = data(:,4);
tss=unique(date);

% Interp missing data
tfe_interp=~isnan(tfe);
sfe_interp=~isnan(sfe);

% Deal with dates
DateStart = '01-Jun-2019';
DateEnd = '15-Aug-2019';
formatIn = 'dd-mmm-yyyy';
xmin = datenum(DateStart,formatIn);
xmax = datenum(DateEnd,formatIn);
ymin=0.1; %min(elev);
ymax=10; %max(elev);

% Creates a function to interpolate concentrations as a function of date and depth
F_tfe=scatteredInterpolant(date(tfe_interp),depth(tfe_interp), tfe(tfe_interp),'linear');
F_sfe=scatteredInterpolant(date(sfe_interp),depth(sfe_interp), sfe(sfe_interp),'linear');

% Define the plotting range
[x,y]=meshgrid(xmin:1:xmax,ymin:0.1:ymax);
tfe_plot=F_tfe(x,y);
sfe_plot=F_sfe(x,y);

% Define contours and breaks
t2=ceil(max(tfe));
s2=ceil(max(sfe));

%% 

% Plot Tfe contours
subplot(2,2,4)
contourf(x,y,tfe_plot,'EdgeColor','none');
set(gca,'FontSize',18)
haxes = gca;
datetick('x','dd mmm ','keeplimits','keepticks')
ylabel('Depth (m)','FontSize',18);
caxis([0,20]);
hT2 = colorbar;
set(hT2,'FontSize',18);
ylabel(hT2, 'Total Fe (mg L^{-1})','FontSize',18)
%xlabel('Date','FontSize',10);
colormap(jet)
set(gca,'YDir','reverse')
hold on

%plot important date lines
formatIn = 'dd-mmm-yyyy';
dates = datenum(["01-06-2019" "01-07-2019" "01-08-2019" "01-09-2019" "01-10-2019"],formatIn);
xticks(dates);
xticklabels(datestr(dates, 'mmm'))
xlim('manual')

%plot sampling dates as ticks
ylim1=get(gca,'ylim')+0.04;
plot(tss,linspace(ylim1(1),ylim1(1),length(tss)),'v','color','white','markerfacecolor','white');

saveas(gcf,'FCRTFe2019', 'tif')
hold off


%% 

% Plot Sfe contours
subplot(2,2,2)
contourf(x,y,sfe_plot,'EdgeColor','none');
set(gca,'FontSize',18)
haxes = gca;
datetick('x','dd mmm ','keeplimits','keepticks')
ylabel('Depth (m)','FontSize',18);
caxis([0,20]);
hS2 = colorbar;
set(hS2,'FontSize',18);
ylabel(hS2, 'Soluble Fe (mg L^{-1})','FontSize',18)
%xlabel('Date','FontSize',10);
colormap(jet)
set(gca,'YDir','reverse')
hold on

%plot important date lines
formatIn = 'dd-mmm-yyyy';
dates = datenum(["01-06-2019" "01-07-2019" "01-08-2019" "01-09-2019" "01-10-2019"],formatIn);
xticks(dates);
xticklabels(datestr(dates, 'mmm'))
xlim('manual')
%set(gca,'Xticklabel',[])

%plot sampling dates as ticks
ylim1=get(gca,'ylim')+0.04;

title("Beaverdam Reservoir")
plot(tss,linspace(ylim1(1),ylim1(1),length(tss)),'v','color','white','markerfacecolor','white');

saveas(gcf,'FCRTFe2019', 'tif')
hold off
