
if( iSpin~=0 )
  for isc = 1:4
    sFileSpinPt2 = sprintf('%1d',isc);
    sFileSpin= [ '../' sSpin '/mms' sFileSpinPt2 sFileSpinPt3 ];
    
    fidmag=fopen(sFileSpin,'rt');
    SPIN=fscanf(fidmag,'%4d-%2d-%2d/%2d:%2d:%f%f%f%f',[9,inf]);
    fclose(fidmag);
    
    SPIN=SPIN';
    yr = SPIN(:,1);
    mo = SPIN(:,2);
    dy = SPIN(:,3);
    hh = SPIN(:,4);
    mm = SPIN(:,5);
    ss = SPIN(:,6);
    dSpin(:,1:3,isc) = SPIN(:,7:9);
    
    tSpin = (hh-hr0)*3600 + (mm-mn0)*60 + ss;
  end
end

%%

% save('POS_MAG_POS.mat','tFPI','aFPIpos','aFPImag','aFPIE','aFPIe','aFPIion');
if( iBurst==4 )
  load('POS_MAG_E_FPI_magBurst4.mat');
elseif( iBurst==3 )
  load('POS_MAG_E_FPI_magBurst3.mat');
elseif( iBurst==2 )
  load('POS_MAG_E_FPI_magBurst2.mat');
elseif( iBurst==1 )
  load('POS_MAG_E_FPI_magBurst.mat');
else
  load('POS_MAG_E_FPI.mat');
end

nt = size(tFPI,1);

xvsc = squeeze( aFPIpos(:,:,1:4) );
dposa = xvsc(:,:,2:4) - repmat(xvsc(:,:,1),[1,1,3]); % na , xyz , 2-1,3-1,4-1
dposa = permute(dposa,[1,3,2]);

% nefudge = 1.11*1.04;
nefudge = 1;
aFPIe(:,1,1:4) = nefudge*aFPIe(:,1,1:4); % Ne in cm^-3;
qe = 1.6022e-19; % C
denconv = 1.e6; % 1/cm^3 * (100 cm)^3/m^3
velconv = 1.e3; % km * (1000 m)/km
outunitconv = 1.e9; % A * (1.e9 nA)/A
comp = qe*denconv*velconv*outunitconv;
% comp = 1.00;
% Ji = comp*repmat( aFPIion(:,1,1:4) , [1,3,1] ) .* aFPIion(:,2:4,1:4);
Ji = comp*repmat( aFPIe(:,1,1:4) , [1,3,1] ) .* aFPIion(:,2:4,1:4);
Je = - comp*repmat( aFPIe(:,1,1:4) , [1,3,1] ) .* aFPIe(:,2:4,1:4);
J = Ji + Je;
if( iBurst>=3 )
  J = J * ( 1 + repmat(reshape(sigJa,[1,3,4]),[nt,1,1]) );
end
Jav = squeeze( mean(J , 3) );
JavMag = sqrt( Jav(:,1).^2 + Jav(:,2).^2 + Jav(:,3).^2 );

aa = zeros(nt,24,4);

Jcurl = zeros(nt,5); % J, |J|, div-B
for j = 1:nt
  [Jcurl(j,1:3),Jcurl(j,4),Jcurl(j,5)] = curlometer( [0,0,0], ...
    squeeze(dposa(j,1,:)), squeeze(dposa(j,2,:)), squeeze(dposa(j,3,:)), ...
    aFPImag(j,:,1),aFPImag(j,:,2),aFPImag(j,:,3),aFPImag(j,:,4) );
end
JcurlMag = sqrt( Jcurl(:,1).^2 + Jcurl(:,2).^2 + Jcurl(:,3).^2 );

aa(:,1,:) = aFPIion(:,1,1:4); % Nion in cm^-3
aa(:,2,:) = aa(:,1,:) .* ( aFPIion(:,5,1:4) + 2*aFPIion(:,6,1:4) )/3; % pi now in cm^-3 eV
aa(:,3:5,:) = aFPIion(:,2:4,1:4); % Vion in km/s
aa(:,6:8,:) = aFPImag(:,1:3,1:4); % B in nT
aa(:,9:11,:) = aFPIE(:,1:3,1:4); % E in mV/m
aa(:,12:14,:) = aFPIe(:,2:4,1:4); % Ve in km/s
aa(:,15,:) = aFPIe(:,1,1:4); % Ne in cm^-3
aa(:,16:18,:) = Ji;
aa(:,19:21,:) = Je;
aa(:,22:24,:) = J;
aa(:,25,:) = aFPIion(:,5,1:4); % Tpli in eV
aa(:,26,:) = aFPIion(:,6,1:4); % Tpri in eV
aa(:,27,:) = aFPIe(:,1,1:4); % ne in cm^-3
aa(:,28,:) = aFPIe(:,1,1:4) .* ( aFPIe(:,5,1:4) + 2*aFPIe(:,6,1:4) )/3; % pe now in cm^-3 eV
aa(:,29,:) = aFPIe(:,5,1:4); % Tple in eV
aa(:,30,:) = aFPIe(:,6,1:4); % Tpre in eV

itrange = find(tFPI>=tCut1 & tFPI<=tCut2);
dposa = dposa(itrange,:,:);
aa = aa(itrange,:,:);
t = tFPI(itrange);
Jcurl = Jcurl(itrange,:);
JcurlMag = JcurlMag(itrange);
Jav = Jav(itrange,:);
JavMag = JavMag(itrange);

a_tetrahedron = 1;

t1 = tCut1; t2 = tCut2;
if( iBurst==4 )
  save('mms_read_mag_pos_magBurst4.mat','aa','t','t1','t2','nt','dposa','a_tetrahedron','Jcurl');
elseif( iBurst==3 )
  save('mms_read_mag_pos_magBurst3.mat','aa','t','t1','t2','nt','dposa','a_tetrahedron','Jcurl');
elseif( iBurst==2 )
  save('mms_read_mag_pos_magBurst2.mat','aa','t','t1','t2','nt','dposa','a_tetrahedron','Jcurl');
elseif( iBurst==1 )
  save('mms_read_mag_pos_magBurst.mat','aa','t','t1','t2','nt','dposa','a_tetrahedron','Jcurl');
else
  save('mms_read_mag_pos.mat','aa','t','t1','t2','nt','dposa','a_tetrahedron','Jcurl');
end

%%

Bv = aa(:,6:8,:);
Bvav = squeeze( mean( Bv , 3 ) );

figure(16)
set(gcf,'Position',[500,300,400,700]);
set(gcf,'Color','w');
col = [ 0 0 0 ; 1 0 0 ; 0 .8 0 ; .2 .2 1 ; .955 .765 .225];
sYlab1 = { 'X' ,'Y' ,'Z' };
for i = 1:3
  subplotrc(3,1,i,1)
  plot(t,Bvav(:,i),'Color',col(5,:),'LineWidth',2)
  hold on
  for k = 1:4
    plot(t,Bv(:,i,k),'Color',col(k,:))
  end
  hold off
  if( itPlotLim==1 ), xlim([241.7 243.1]); end
  xlabel('t (s)')
  ylabel(['B' sYlab1{i} '_{GSE} (nT)'])
end
export_fig('mms_read_mag_pos_Fig6.pdf','-dpdf')

%%


figure(17)
clf
set(gcf,'Position',[600,300,800,400]);
col = [ 0.2 0.2 1 ; 0 .8 0 ; 1 0 0 ];
subplotrc(1,2,1,1)
hold on
for i = 1:3
  plot(t,Jav(:,i),'Color',col(i,:),'LineWidth',1);
end
plot(t,smooth(JavMag,51),'Color','k','LineWidth',1.5);
hold off
% xlim([-660 -540]);
if( iScreenOffsets == 1 )
  xlim([t1Off t2Off])
end
xlabel('Seconds after 23:00 UT 11 July 2017')
ylabel('Jav (nA/m^2) GSE')

subplotrc(1,2,1,2)
hold on
for i = 1:3
  plot(t,Jcurl(:,i),'Color',col(i,:),'LineWidth',1);
end
plot(t,smooth(JcurlMag,51),'Color','k','LineWidth',1.5);
hold off
% xlim([-700 -500]);
if( iScreenOffsets == 1 )
  xlim([t1Off t2Off])
end
xlabel('Seconds after 23:00 UT 11 July 2017')
ylabel('Jcurl (nA/m^2) GSE')

figure(19)
hold on
for i = 1:3
  plot(t,Jav(:,i)-Jcurl(:,i),'Color',col(i,:),'LineWidth',1);
end
% plot(t,smooth(JcurlMag,51),'Color','k','LineWidth',1.5);
hold off
% xlim([-700 -500]);
if( iScreenOffsets == 1 )
  xlim([t1Off t2Off])
end
xlabel(['Seconds after ' stime ' UT'])
ylabel('Jpav - Jcurl (nA/m^2) GSE')

Bv = aa(:,6:8,:);
if( iScreenOffsets == 1 )
  Bvc = Bv(t>=t1Off & t<=t2Off,:,:);
else
  Bvc = Bv;
end
Bvcmn = squeeze( mean(Bvc,1) );
Bvcmnav = mean( Bvcmn,2 );
Offsets = Bvcmn - repmat(Bvcmnav,[1,4])

if( iSpin~=0 )
  Bspin = zeros(1,4);
  SpinDir = zeros(3,4);
  BSpinOffsets = zeros(3,4);
  for k = 1:4
    dSpint = interp1(tSpin,squeeze(dSpin(:,:,k)),t);
    bspin = dot( dSpint , squeeze(Bv(:,1:3,k)) , 2 );
    Bspin(k) = mean(bspin);
    iSel = find( t>=t1SpinOff & t<=t2SpinOff );
    SpinDir(:,k) = mean( dSpint(iSel,:) , 1 )';
    BSpinOffsets(:,k) = Bspin(k) * SpinDir(:,k);
  end
  BSpinOffsets = BSpinOffsets - repmat( mean( BSpinOffsets , 2 ) , [1,4] )  
  save('SpinDir.mat','SpinDir');
end

