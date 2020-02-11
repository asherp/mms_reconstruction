%%

sFilePt1 = 'mms';

% Get dt

if( iBurst>=2 )
  nMagFld = 9; sMagFld = '%4d-%2d-%2d/%2d:%2d:%f%f%f%f';
  dt = dtBurst2;
else
  nMagFld = 10; sMagFld = '%4d-%2d-%2d/%2d:%2d:%f%f%f%f%f';
  dt1 = [];
  for isc = 1:4
    sFileMagPt2 = sprintf('%1d',isc);
    sFileMag= [ '../' sMag '/mms' sFileMagPt2 sFileMagPt3 ];
    
    fidmag=fopen(sFileMag,'rt');
    MAG=fscanf(fidmag,sMagFld,[nMagFld,inf]);
    fclose(fidmag);
    
    MAG=MAG';
    yr = MAG(:,1);
    mo = MAG(:,2);
    dy = MAG(:,3);
    hh = MAG(:,4);
    mm = MAG(:,5);
    ss = MAG(:,6);
    
    t1 = (hh-hr0)*3600 + (mm-mn0)*60 + ss;
    dt1 = [ dt1 ; mean(t1(2:end)-t1(1:end-1)) ];
  end
  dt = mean(dt1);
end

%%

% Find optimal grid time for burst mag data
tspcrStart = zeros(1,4);
tspcrEnd = zeros(1,4);
for isc = 1:4
  sFileMagPt2 = sprintf('%1d',isc);
  sFileMag= [ '../' sMag '/mms' sFileMagPt2 sFileMagPt3 ];
  
  fidmag=fopen(sFileMag,'rt');
  MAG=fscanf(fidmag,sMagFld,[nMagFld,inf]);
  fclose(fidmag);
  
  MAG=MAG';
  yr = MAG(:,1);
  mo = MAG(:,2);
  dy = MAG(:,3);
  hh = MAG(:,4);
  mm = MAG(:,5);
  ss = MAG(:,6);
  if( iBurst>=3 )
    ss = ss + sigtflda(isc);
  end
  
  t1 = (hh-hr0)*3600 + (mm-mn0)*60 + ss;
  tspcrStart(isc) = t1(find(t1>tCut1,1));
  tspcrEnd(isc) = t1(end);
end
tSmallest = max(tspcrStart);
tLargest   = min(tspcrEnd);

if( iBurst>=2 )
  t0k = ceil(1000*tSmallest);
  t0 = t0k/1000;
else
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
  if( t0<tSmallest )
    t0 = t0 + dt;
  end
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
end
nt = numel(tFPI);

tmin = tFPI(1);
tmax = tFPI(end);

%%

% Get burst mode mag data and interpolate to tFPI array

% aFPImag = zeros(nt,4,5);
for isc=1:4
  sFileMagPt2 = sprintf('%1d',isc);
  sFileMag= [ '../' sMag '/mms' sFileMagPt2 sFileMagPt3 ];
  
  fidmag=fopen(sFileMag,'rt');
  MAG=fscanf(fidmag,sMagFld,[nMagFld,inf]);
  fclose(fidmag);
  
  MAG=MAG';
  yr = MAG(:,1);
  mo = MAG(:,2);
  dy = MAG(:,3);
  hh = MAG(:,4);
  mm = MAG(:,5);
  ss = MAG(:,6);
  if( iBurst>=3 )
    ss = ss + sigtflda(isc);
  end
  
  t1 = (hh-hr0)*3600 + (mm-mn0)*60 + ss;
  dt1 = t1(2:end)-t1(1:end-1);
  maxdt1 = max(dt1); mindt1 = min(dt1);
  imaxdt1 = find(dt1>.00015)'; imindt1 = find(dt1<.00008)';
  iscMxdtMndtImxImn = [ isc maxdt1 mindt1 imaxdt1 imindt1 ];

  if( iBurst>=2 )
    for ic = 1:3
      % Correct bad t1 values
      dt1 = t1(2:end)-t1(1:end-1);
      jfix = find(dt1<0);
      for jj = 1:numel(jfix)
        t1(jfix(jj)+1) = t1(jfix(jj)+1) + 1;
      end
      [aFPImag(:,ic,isc),~] = getUniformX2Xf( t1,MAG(:,6+ic),tFPI );
    end
  else
    aFPImag(:,1:3,isc) = interp1( t1,MAG(:,7:9),tFPI )
  end
  if( iBurst>=3 )
    aFPImag(:,1:3,isc) = aFPImag(:,1:3,isc) + repmat(reshape(sigBa(:,isc),[1,3,1]),[nt,1,1]);
  end
  aFPImag(:,4,isc) = sqrt( aFPImag(:,1,isc).^2 + aFPImag(:,2,isc).^2 + aFPImag(:,3,isc).^2 );
end % isc
aFPImag(:,:,5) = mean(aFPImag(:,:,1:4),3);
% aFPImag(isnan(aFPImag)) = aFPImag1(isnan(aFPImag));

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
    
    sFileFPI= [ '../' sFPI '/' sFilePt1 num2str(isc) sFilePt2 sFilePt3 ];
    fidr = fopen(sFileFPI,'r');
    A = textscan(fidr,'%s %f %f %f %f %f %f %f %f %f %f %f %f %f');
    dv1 = datevec(A{1});
    t1 = (dv1(:,4)-hr0)*3600 + (dv1(:,5)-mn0)*60 + dv1(:,6);
    aFPI1 = [ A{2} A{3} A{4} A{5} A{6} A{7} A{8} A{9} A{10} A{11} A{12} A{13} A{14} ];
    % The data format is: 3 components of the SC location, 3 components of the magnetic field, AND field intensity,
    %  plasma density, 3 components of the bulk velocity, and parallel and perpendicular temperature.
    
    % Optionally rewrite information with partial moment data
    if( iBurst==4 )
      sFileB4p = [sFileB4_1 sFileB4_2 num2str(isc) sFileB4_4 sFileB4_5{iei,2} sFileB4_6];
      [datap,infop] = spdfcdfread(sFileB4p);
      epochp = datap{1};
      datevp = datevec(epochp);
      tp = (datevp(:,4)-hr0)*3600 + (datevp(:,5)-mn0)*60 + datevp(:,6);
      iSelp = find(tp>=t1(1) & tp<=t1(end));
      tp = tp(iSelp);
      aFPIp = [ datap{5}(iSelp,iB4en) (squeeze(datap{7}(iB4en,:,iSelp)))' ...
                datap{12}(iSelp,iB4en) datap{13}(iSelp,iB4en) ];
      aFPI1p = interp1(tp,aFPIp,t1);
      aFPI1(:,8:end) = aFPI1p;
      
      if( iei==1 && iBurst4spintone==1 )
        sFileB4f = [sFileB4_1 sFileB4_2 num2str(isc) sFileB4_4 sFileB4_5{iei,1} sFileB4_6];
        [dataf,infof] = spdfcdfread(sFileB4f);
        Vspin = dataf{30}(iSelp,:);
        Vspin1 = interp1(tp,Vspin,t1);
        aFPI1(:,9:11) = aFPI1(:,9:11) - Vspin1;
      end
    end
      
    if( iBurst>=3 )
      t1 = t1 + sigtfpia(isc);
      if( iei==1 )
        ncol = size(aFPI1,1);
        aFPI1(:,9:11) = aFPI1(:,9:11) + repmat(sigVa(:,isc)',[ncol,1]);
      end
    end    
    
    if( iei==1 )
      if( iBurst==0 )
        for ic = 1:size(aFPI1,2)
          [aFPI(:,ic,isc),~] = getUniformX2Xf( t1,aFPI1(:,ic),tFPI );
        end
      else
        aFPI(:,:,isc) = interp1(t1,aFPI1,tFPI);
      end
    else
      aFPI(:,:,isc) = interp1(t1,aFPI1,tFPI,'linear','extrap');
    end
    
  end %isc
  
  if( isc==1 )
    year = dv1(:,1);
    mon  = dv1(:,2);
    day  = dv1(:,3);
  end
  
  aFPI(:,:,5) = mean(aFPI(:,:,1:4),3);
  
  if( iei==1 )
    aDES = aFPI;
  else
    aDIS = aFPI;
  end
  
end %iei
clear aFPI aFPI1 t1 year mon day;

%%

aFPIpos = aDES(:,1:3,:);
if( iBurst>=3 )
  aFPIpos = aFPIpos + repmat(reshape(sigposa,[1,3,5]),[nt,1,1]);
end
% aFPImag1 = aDES(:,4:7,:); % Replaced below
aFPIe   = aDES(:,8:end,:);
aFPIion = aDIS(:,8:end,:);



%%
% Get burst mode electric field data and interpolate to e resolution

aFPIE = zeros(nt,4,5);
for isc=1:4
  sFileEPt2 = sprintf('%1d',isc);
  sFileE= [ '../' sElec '/mms' sFileEPt2 sFileEPt3 ];
  
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
  if( iBurst>=3 )
    t1 = t1 + sigtflda(isc);
  end
  
  
  for ic = 1:3
    if( iBurst==0 || (iBurst>=2 && iBurstE==1) )
      [aFPIE(:,ic,isc),~] = getUniformX2Xf( t1,aE(:,7+ic),tFPI );
    else
      aFPIE(:,ic,isc) = interp1( t1,aE(:,7+ic),tFPI );
    end
  end
  aFPIE(:,4,isc) = sqrt( aFPIE(:,1,isc).^2 + aFPIE(:,2,isc).^2 + aFPIE(:,3,isc).^2 );
end
aFPIE(:,:,5) = mean(aFPIE(:,:,1:4),3);

%%

if( iBurst==1 )
  save('POS_MAG_E_FPI_magBurst.mat','tFPI','aFPIpos','aFPImag','aFPIE','aFPIe','aFPIion');
  save('E_magBurst.mat','tFPI','aFPIE');
elseif( iBurst==2 )
  save('POS_MAG_E_FPI_magBurst2.mat','tFPI','aFPIpos','aFPImag','aFPIE','aFPIe','aFPIion');
  save('E_magBurst2.mat','tFPI','aFPIE');
elseif( iBurst==3 )
  save('POS_MAG_E_FPI_magBurst3.mat','tFPI','aFPIpos','aFPImag','aFPIE','aFPIe','aFPIion');
  save('E_magBurst3.mat','tFPI','aFPIE');
elseif( iBurst==4 )
  save('POS_MAG_E_FPI_magBurst4.mat','tFPI','aFPIpos','aFPImag','aFPIE','aFPIe','aFPIion');
  save('E_magBurst3.mat','tFPI','aFPIE');
else
  save('POS_MAG_E_FPI.mat','tFPI','aFPIpos','aFPImag','aFPIE','aFPIe','aFPIion');
  save('E.mat','tFPI','aFPIE');
end

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

figure(6)
set(gcf,'Color','w');
plot(tFPI,repmat(-aFPIe(:,1,5),[1,3,1]).*aFPIe(:,2:4,5),'Linewidth',1.5)
hold on
plot(tFPI,repmat(aFPIion(:,1,5),[1,3,1]).*aFPIion(:,2:4,5),':','Linewidth',1.5)
plot(get(gca,'XLim'),[0,0],'Color',[.2,.2,.2]);
hold off
legend('Jav_X','Jav_Y','Jav_Z');
xlabel(['Seconds after ' num2str(hr0) ':' num2str(mn0) ],'FontSize',12);
ylabel('Jav GSE (nT)','FontSize',12);
title('solid = e, dotted = ions')
set(gcf,'PaperPosition',[0,0,8.5,11])

figure(7)
set(gcf,'Color','w');
plot(tFPI,repmat(aFPIe(:,1,5),[1,3,1]).*(aFPIion(:,2:4,5)-aFPIe(:,2:4,5)),'Linewidth',1.5)
hold on
% plot(tFPI,repmat(aFPIion(:,1,5),[1,3,1]).*aFPIion(:,2:4,5),':','Linewidth',1.5)
plot(get(gca,'XLim'),[0,0],'Color',[.2,.2,.2]);
hold off
legend('Jav_X','Jav_Y','Jav_Z');
xlabel(['Seconds after ' num2str(hr0) ':' num2str(mn0) ],'FontSize',12);
ylabel('Jav GSE (nT)','FontSize',12);
title('total with Ne')
set(gcf,'PaperPosition',[0,0,8.5,11])

figure(8)
set(gcf,'Position',[700,300,500,700])
set(gcf,'Color','w');
ca = [ 0 0 0 ; .8 0 0 ; 0 .75 0 ; .4 .4 1 ; .85 .65 .125 ; .85 .65 .125 ; 0 0 0 ; .8 0 0 ; 0 .75 0 ; .4 .4 1 ];
sC = { 'X' 'Y' 'Z' };
subplotrc(4,1,1,1)
for k = 1:4
  plot(tFPI,aFPIe(:,1,k),'Color',ca(k,:),'Linewidth',1.5)
  if( k==1 ), hold on; end
end
hold off
xlabel(['Seconds after ' num2str(hr0) ':' num2str(mn0) ],'FontSize',12);
ylabel(['Ne (cm^{-3})'],'FontSize',12);
for ic = 1:3
  subplotrc(4,1,1+ic,1)
  for k = 1:4
    plot(tFPI,aFPIe(:,1,k).*(aFPIion(:,1+ic,k)-aFPIe(:,1+ic,k)),'Color',ca(k,:),'Linewidth',1.5)
    if( k==1 ), hold on; end
    end
    % plot(tFPI,repmat(aFPIion(:,1,5),[1,3,1]).*aFPIion(:,2:4,5),':','Linewidth',1.5)
    plot(get(gca,'XLim'),[0,0],'Color',[.2,.2,.2]);
    hold off
    xlabel(['Seconds after ' num2str(hr0) ':' num2str(mn0) ],'FontSize',12);
    ylabel(['J_' sC{ic} ' GSE (nT)'],'FontSize',12);
  end
  set(gcf,'PaperPosition',[0,0,8.5,11])


