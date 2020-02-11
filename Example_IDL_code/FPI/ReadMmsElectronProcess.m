
sFilePt1 = 'mms';

% Find optimal grid time for electron data
dt = 0.030;
sFilePt2 = '_des';
tspcrStart = zeros(1,4);
tspcrEnd = zeros(1,4);
for isc = 1:4 
  fidr = fopen([sFilePt1 num2str(isc) sFilePt2 sFilePt3],'r');
  A = textscan(fidr,'%s %f %f %f %f %f %f %f %f %f %f %f %f %f');
  dv1 = datevec(A{1});
  t1 = (dv1(:,4)-hr0)*3600 + (dv1(:,5)-mn0)*60 + dv1(:,6);
  tspcrStart(isc) = t1(1);
  tspcrEnd(isc) = t1(end);
  fclose(fidr) 
end
tspcr = sort(tspcrStart)
t0 = mean(tspcr)
t0dist = (tspcr(1)-t0)^2 + (tspcr(2)-t0)^2 + (tspcr(3)-t0)^2 + (tspcr(4)-t0)^2
for k = 1:3
  tspcr = [ tspcr(2:4) tspcr(1)+dt ]
  t0p = mean(tspcr)
  t0pdist = (tspcr(1)-t0p)^2 + (tspcr(2)-t0p)^2 + (tspcr(3)-t0p)^2 + (tspcr(4)-t0p)^2
  if( t0pdist<t0dist )
    t0 = t0p;
    t0dist = t0pdist;
  end
end
tSmallest = max(tspcrStart);
tLargest   = min(tspcrEnd);
if( t0<tSmallest )
  t0 = t0 + dt;
end

% Get grid time
ntdown = floor( (t0-tSmallest)/dt );
ntup   = floor( (tLargest-t0)/dt ); 
nt = ntup + ntdown + 1;
tFPI = zeros(nt,1);
i0 = ntdown+1;
tFPI(i0) = t0;
tFPI(i0+1:nt) = t0 + dt*(1:ntup)';
tFPI(i0-1:-1:1) = t0 - dt*(1:ntdown)';

if( iCut==1 )
  tFPI = tFPI( tFPI>=tCut1 & tFPI<=tCut2 );
  nt = numel(tFPI);
end

tmin = tFPI(1);
tmax = tFPI(end);

%%
% Get FPI data

for iei = 1:2    % 1 for electrons, 2 for ions
  
if( iei==1 )
  sFilePt2 = '_des';
else
  sFilePt2 = '_dis';
end

aFPI = zeros(nt,13,5);

for isc = 1:4
  
  fidr = fopen([sFilePt1 num2str(isc) sFilePt2 sFilePt3],'r');
  A = textscan(fidr,'%s %f %f %f %f %f %f %f %f %f %f %f %f %f');
  dv1 = datevec(A{1});
  t1 = (dv1(:,4)-hr0)*3600 + (dv1(:,5)-mn0)*60 + dv1(:,6);
  aFPI1 = [ A{2} A{3} A{4} A{5} A{6} A{7} A{8} A{9} A{10} A{11} A{12} A{13} A{14} ];
  % The data format is: 3 components of the SC location, 3 components of the magnetic field, AND field intensity, 
  %  plasma density, 3 components of the bulk velocity, and parallel and perpendicular temperature.
 
  if( iei==1 )
    aFPI(:,:,isc) = interp1(t1,aFPI1,tFPI);
  else
    aFPI(:,:,isc) = interp1(t1,aFPI1,tFPI,'linear','extrap');
  end
  
   if( isc==1 )
    year = dv1(:,1);
    mon  = dv1(:,2);
    day  = dv1(:,3);
  end
  
end

aFPI(:,:,5) = mean(aFPI(:,:,1:4),3);

if( iei==1 )
  aDES = aFPI;
else
  aDIS = aFPI;
end

end
clear aFPI aFPI1 t1 year mon day;

%%

aFPIpos = aDES(:,1:3,:);
aFPImag1 = aDES(:,4:7,:); % Replaced below
aFPIe   = aDES(:,8:end,:);
aFPIion = aDIS(:,8:end,:);

%%

% Get burst mode mag data and interpolate to e resolution

aFPImag = zeros(nt,4,5);
for isc=1:4
  sFileMagPt2 = sprintf('%1d',isc);
  sFileMag= [ '../FGM_crib/mms' sFileMagPt2 sFileMagPt3 ];
  
  fidmag=fopen(sFileMag,'rt');
  MAG=fscanf(fidmag,'%4d-%2d-%2d/%2d:%2d:%f%f%f%f%f',[10,inf]);
  fclose(fidmag);
  
  MAG=MAG';
  yr = MAG(:,1);
  mo = MAG(:,2);
  dy = MAG(:,3);
  hh = MAG(:,4);
  mm = MAG(:,5);
  ss = MAG(:,6);
  
  t1 = (hh-hr0)*3600 + (mm-mn0)*60 + ss;
  for ic = 1:3
    [aFPImag(:,ic,isc),~] = getFdistXfIn( t1,MAG(:,6+ic),tFPI );
  end
  aFPImag(:,4,isc) = sqrt( aFPImag(:,1,isc).^2 + aFPImag(:,2,isc).^2 + aFPImag(:,3,isc).^2 );
end
aFPImag(:,:,5) = mean(aFPImag(:,:,1:4),3);
aFPImag(isnan(aFPImag)) = aFPImag1(isnan(aFPImag));

%%
% Get burst mode electric field data and interpolate to e resolution

aFPIE = zeros(nt,4,5);
for isc=1:4
  sFileEPt2 = sprintf('%1d',isc);
  sFileE= [ '../EDP_fast/mms' sFileEPt2 sFileEPt3 ];
  
  fidE=fopen(sFileE,'rt');
  aE=fscanf(fidE,'%4d-%2d-%2d/%2d:%2d:%f %f %f %f %f',[10,inf]);
  fclose(fidE);
  
  aE=aE';
  yr = aE(:,1);
  mo = aE(:,2);
  dy = aE(:,3);
  hh = aE(:,4);
  mm = aE(:,5);
  ss = aE(:,6);
  ssfrac = aE(:,7);
  
%   t1 = (hh-hr0)*3600 + (mm-mn0)*60 + ss;
  t1 = (hh-hr0)*3600 + (mm-mn0)*60 + ssfrac;
  
  for ic = 1:3
    [aFPIE(:,ic,isc),~] = getFdistXfIn( t1,aE(:,7+ic),tFPI );
  end
  aFPIE(:,4,isc) = sqrt( aFPIE(:,1,isc).^2 + aFPIE(:,2,isc).^2 + aFPIE(:,3,isc).^2 );
end
aFPIE(:,:,5) = mean(aFPIE(:,:,1:4),3);

%%

save('POS_MAG_E_FPI.mat','tFPI','aFPIpos','aFPImag','aFPIE','aFPIe','aFPIion');

save('E.mat','tFPI','aFPIE');


%%


figure(1)
set(gcf,'Color','w');
plot(tFPI,aFPIion(:,1,5),'b','Linewidth',1.5)
hold on
plot(tFPI,aFPIe(:,1,5),'r','Linewidth',1.5)
hold off
legend('Ni','Ne');
xlabel(['Seconds after ' num2str(hr0) ':' num2str(mn0) ],'FontSize',12);
ylabel('Density (cm^{-3})','FontSize',12);
set(gcf,'PaperPosition',[0,0,8.5,11])
print('readFPI_160517_Fig01.pdf','-dpdf');

figure(2)
set(gcf,'Color','w');
plot(tFPI,aFPIion(:,2:4,5),'Linewidth',1.5)
hold on
plot(get(gca,'XLim'),[0,0],'Color',[.2,.2,.2]);
hold off
legend('Vi_X','Vi_Y','Vi_Z');
xlabel(['Seconds after ' num2str(hr0) ':' num2str(mn0) ],'FontSize',12);
ylabel('Vi GSE (km/s)','FontSize',12);
set(gcf,'PaperPosition',[0,0,8.5,11])
print('readFPI_160517_Fig02.pdf','-dpdf');

figure(3)
set(gcf,'Color','w');
plot(tFPI,aFPIe(:,2:4,5),'Linewidth',1.5)
hold on
plot(get(gca,'XLim'),[0,0],'Color',[.2,.2,.2]);
hold off
legend('Ve_X','Ve_Y','Ve_Z');
xlabel(['Seconds after ' num2str(hr0) ':' num2str(mn0) ],'FontSize',12);
ylabel('Ve GSE (km/s)','FontSize',12);
set(gcf,'PaperPosition',[0,0,8.5,11])
print('readFPI_160517_Fig03.pdf','-dpdf');

figure(4)
set(gcf,'Color','w');
plot(tFPI,aFPIE(:,1:3,5),'Linewidth',1.5)
hold on
plot(get(gca,'XLim'),[0,0],'Color',[.2,.2,.2]);
hold off
legend('Eav_X','Eav_Y','Eav_Z');
xlabel(['Seconds after ' num2str(hr0) ':' num2str(mn0) ],'FontSize',12);
ylabel('Eav GSE (mV/m)','FontSize',12);
set(gcf,'PaperPosition',[0,0,8.5,11])
print('readFPI_160517_Fig04.pdf','-dpdf');

figure(5)
set(gcf,'Color','w');
plot(tFPI,aFPImag(:,1:3,5),'Linewidth',1.5)
hold on
plot(get(gca,'XLim'),[0,0],'Color',[.2,.2,.2]);
hold off
legend('Bav_X','Bav_Y','Bav_Z');
xlabel(['Seconds after ' num2str(hr0) ':' num2str(mn0) ],'FontSize',12);
ylabel('Bav GSE (nT)','FontSize',12);
set(gcf,'PaperPosition',[0,0,8.5,11])
print('readFPI_160517_Fig05.pdf','-dpdf');

%%

% BLMN  = zeros(nt,3);
% viLMN = zeros(nt,3);
% veLMN = zeros(nt,3);
% for i = 1:3
%   for j = 1:nt
%      BLMN(j,i) = dot( eLMN(i,:) , squeeze(aFPImag(j,1:3,5)) );
%     viLMN(j,i) = dot( eLMN(i,:) , squeeze(aFPIion(j,2:4,5)) );
%     veLMN(j,i) = dot( eLMN(i,:) , squeeze(aFPIe  (j,2:4,5)) );
%   end
% end
% 
% figure(11)
% set(gcf,'Color','w');
% plot(tFPI,BLMN,'Linewidth',1.5)
% hold on
% plot(get(gca,'XLim'),[0,0],'Color',[.2,.2,.2]);
% hold off
% legend('Bav_L','Bav_M','Bav_N');
% xlabel(['Seconds after ' num2str(hr0) ':' num2str(mn0) ],'FontSize',12);
% ylabel('Bav LMN (km/s)','FontSize',12);
% set(gcf,'PaperPosition',[0,0,8.5,11])
% print('readFPI_160517_Fig11.pdf','-dpdf');
% 
% figure(12)
% set(gcf,'Color','w');
% plot(tFPI,viLMN,'Linewidth',1.5)
% hold on
% plot(get(gca,'XLim'),[0,0],'Color',[.2,.2,.2]);
% hold off
% legend('Vi_L','Vi_M','Vi_N');
% xlabel(['Seconds after ' num2str(hr0) ':' num2str(mn0) ],'FontSize',12);
% ylabel('Vi LMN (km/s)','FontSize',12);
% set(gcf,'PaperPosition',[0,0,8.5,11])
% print('readFPI_160517_Fig12.pdf','-dpdf');
% 
% figure(13)
% set(gcf,'Color','w');
% plot(tFPI,veLMN,'Linewidth',1.5)
% hold on
% plot(get(gca,'XLim'),[0,0],'Color',[.2,.2,.2]);
% hold off
% legend('Ve_L','Ve_M','Ve_N');
% xlabel(['Seconds after ' num2str(hr0) ':' num2str(mn0) ],'FontSize',12);
% ylabel('Ve LMN (km/s)','FontSize',12);
% set(gcf,'PaperPosition',[0,0,8.5,11])
% print('readFPI_160517_Fig13.pdf','-dpdf');

%%

figure(21)
set(gcf,'Color','w');
plot(tFPI,aFPIion(:,end-1,1),'r',tFPI,aFPIion(:,end,1),'b','Linewidth',1.5)
hold on
plot(get(gca,'XLim'),[0,0],'Color',[.2,.2,.2]);
hold off
hl = legend('Ti_{//}','Ti_{\perp}' );

xlabel(['Seconds after ' num2str(hr0) ':' num2str(mn0) ],'FontSize',12);
ylabel('T','FontSize',12);
set(gcf,'PaperPosition',[0,0,8.5,11])
print('readFPI_160517_Fig21.pdf','-dpdf');

%%
%tFPI,aFPIion(:,2:4,5)

isel = find( tFPI>=30 & tFPI<=34 );
viav = mean( squeeze(aFPIion(isel,2:4,5)) , 1 )

%%

error('stop');

i124 = [1,2,3,4];
% i124 = 1;

B124v  = squeeze( mean( aFPImag(:,  :,i124) , 3 ) );
Vi124v = squeeze( mean( aFPIion(:,2:4,i124) , 3 ) );
Ve124v = squeeze( mean( aFPIe  (:,2:4,i124) , 3 ) );

figure(32)
set(gcf,'Color','w');
plot(tFPI,Vi124v,'Linewidth',1.5)
hold on
plot(get(gca,'XLim'),[0,0],'Color',[.2,.2,.2]);
hold off
legend('Vi_X','Vi_Y','Vi_Z');
xlabel(['Seconds after ' num2str(hr0) ':' num2str(mn0) ],'FontSize',12);
ylabel('Vi124av GSE (km/s)','FontSize',12);
set(gcf,'PaperPosition',[0,0,8.5,11])
print('readFPI_160517_Fig32.pdf','-dpdf');

figure(33)
set(gcf,'Color','w');
plot(tFPI,Ve124v,'Linewidth',1.5)
hold on
plot(get(gca,'XLim'),[0,0],'Color',[.2,.2,.2]);
hold off
legend('Ve_X','Ve_Y','Ve_Z');
xlabel(['Seconds after ' num2str(hr0) ':' num2str(mn0) ],'FontSize',12);
ylabel('Ve124av GSE (km/s)','FontSize',12);
set(gcf,'PaperPosition',[0,0,8.5,11])
print('readFPI_160517_Fig33.pdf','-dpdf');

figure(35)
set(gcf,'Color','w');
plot(tFPI,B124v,'Linewidth',1.5)
hold on
plot(get(gca,'XLim'),[0,0],'Color',[.2,.2,.2]);
hold off
legend('Bav_X','Bav_Y','Bav_Z');
xlabel(['Seconds after ' num2str(hr0) ':' num2str(mn0) ],'FontSize',12);
ylabel('B124av GSE (nT)','FontSize',12);
set(gcf,'PaperPosition',[0,0,8.5,11])
print('readFPI_160517_Fig35.pdf','-dpdf');

isel = find( tFPI>=28.5 & tFPI<=34 );
vi124av = mean( Vi124v(isel,:) , 1 )
ve124av = mean( Ve124v(isel,:) , 1 );
B124av = mean( B124v(isel,:) , 1 )

jrev = find(abs(B124v(:,2))==min(abs(B124v(:,2))));
verev = Ve124v(jrev,:)