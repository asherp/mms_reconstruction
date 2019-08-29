function setup = PolySetup(intro)
%%
iQuadSys = intro.iSystem - 4; % -1/0/1/2/3/4/5 for quad+, quad,quad-,quad--,2D
setup.iQuadSys = iQuadSys;
iRotate = intro.iRotate;
iv = [];

if( iRotate==0 )
  eLMN0 = [ 1 0 0 ; 0 1 0 ; 0 0 1 ];
elseif( iRotate==1 )
  eLMN0 = [ 0.94434 0.26346  -0.197 ; -0.31375 0.90131 -0.29865 ; 0.098878 0.34384 0.93381 ]; % MDDB brst 1.7 to 3.1
elseif( iRotate==2 )
  eLMN0 = [ 0.97517 0.14392  -0.1683 ; -0.19417 0.92114 -0.33736 ; 0.10648 0.36166 0.92621 ]; % MDDB brst w offsets 1.7 to 3.1
elseif( iRotate==3 )
  eLMN0 = [ 0.9451, 0.2673, -0.1866 ; -0.3139, 0.9011, -0.2990 ; 0.0947, 0.3225, 0.9418 ]; # Kevin MDDB 2 intervals
elseif( iRotate==4 )
  eLMN0 = [ 0.9858, 0.0856, -0.1443 ; -0.1290, 0.9367, -0.3256 ; 0.1073, 0.3395, 0.9341 ]; # Kevin MDDB w offsets 2 intervals
elseif( iRotate==5 )
  eLMN0 = [ 0.9482, -0.2551, -0.1893 ; 0.1818, 0.9245, -0.3350 ; 0.2604, 0.2832, 0.9230 ]; # Kevin hybrid coordinate System
elseif( iRotate==11 )
  eLMN0 = [ 0.3320, 0.03515, 0.9426 ; 0.48134 -0.86566 -0.13725 ; 0.8112, 0.4993, -0.3043 ]; # DEA16
elseif( iRotate==12 )
  eLMN0 = [ -0.1569 -0.54442 0.82401 ; 0.34892 -0.81109 -0.46945 ; 0.92392 0.21386 0.31722 ]; # hybrid Wilder 151209
elseif( iRotate==13 )
  eLMN0 = [ 0.34469     -0.28887      0.89316 ; 0.04977     -0.94451     -0.32469 ; 0.9374      0.15637     -0.31118 ]; # hybrid Burch and Phan system 42.3-44.5
elseif( iRotate==14 )
  eLMN0 = [ 0.34695     -0.29103      0.89159 ; 0.051987     -0.94321     -0.32811 ; 0.93644      0.16019     -0.31212]; # Burh and Phan coords
elseif( iRotate==15 )
  eLMN0 = [ -0.19897      0.97917    -0.040455 ; 0.19496     0.080005      0.97754 ;  0.96042      0.18661     -0.20682 ]; # Stefan 150908 event
elseif( iRotate==16 )
  eLMN0 = [ 0.23322     0.035048      0.97179 ; 0.21511     -0.97645    -0.016409 ;  0.94833      0.21287     -0.23527 ]; # Kevin 161128
elseif( iRotate==17 )
  eLMN0 = [ 0.098095   -0.52482  0.84554 ; -0.40538   -0.79703   -0.44768 ;   0.90887  -0.29885  -0.29093 ]; # Chen 151214
elseif( iRotate==18 )
  eLMN0 = [-0.328, 0.945, -0.017 ; 0.240, 0.101, 0.965 ; 0.914, 0.312, -0.260]; # Stefan2
  for k = 1:3, eLMN0(k,:) = eLMN0(k,:)/norm(eLMN0(k,:)); end, eLMN0(3,:) = cross( eLMN0(1,:) , eLMN0(2,:) );
elseif( iRotate==19 )
  eLMN0 = [ 0.3894, -0.2938, 0.8730 ; -0.0079668 -0.94881 -0.31576 ; 0.9210, 0.1160, -0.3718 ]; # DentonEA18 (Burch first crossing)
elseif( iRotate==20 )
  eLMN0 = [ -0.46173      0.76738      -0.4449 ; 0.23883       0.5906      0.77081 ; 0.85426      0.24965     -0.45597 ]; # Burch and Phan MGG coords 43.2-43.7
elseif( iRotate==21 )
  eLMN0 = [ 0.17198  0.15714  0.97249 ; 0.40448  -0.9114 0.075735 ; 0.89823  0.38033  -0.2203 ]; # Lavraud 151016 hybrid
elseif( iRotate==22 )
  eLMN0 = [ 0.157, 0.035, 0.987 ; 0.240, -0.971, -0.0039 ; 0.958, 0.237, -0.161 ]; # Kevin event 161128 X pt system
elseif( iRotate==23 )
  eLMN0 = [ -0.0047562      0.66252      0.74903 ; -0.15057     -0.74097      0.65444 ; 0.98859     -0.10967      0.10328 ]; # Hybrid Phan 54.29-54.37
elseif( iRotate==24 )
  eLMN0 = [ -0.091 0.87 0.49 ; -0.25 -0.49 0.83 ; 0.96 -0.05 0.27 ]; # Phan System
  for k = 1:3, eLMN0(k,:) = eLMN0(k,:)/norm(eLMN0(k,:)); end, eLMN0(3,:) = cross( eLMN0(1,:) , eLMN0(2,:) );
elseif( iRotate==25 )
  eLMN0 = [ 0.19281409 0.16251622 0.96768342 ; 0.25113898 -0.96151461 0.11143994 ; 0.94855255 0.22153583 -0.22620772 ]; # Kevin event 161128 combination of MDD-B and MVA-Ve
elseif( iRotate==26 )
  eLMN0 = [ 0.3603  0.64708  0.67192 ; 0.20513 -0.75763 0.61962 ; 0.91 -0.085413 -0.40571 ]; # WilderEA18, 1/28/17 event hyb t = 32.14 t0 32.4
elseif( iRotate==27 )
  eLMN0 = [ -0.16162  0.51616  0.8411 ; 0.10159 -0.83908  0.53444 ; 0.98161 0.17183 0.083176 ]; # WilderEA18, 12/27/16 event hyb t = 43.28 – 43.55
elseif( iRotate==28 )
  eLMN0 = [ 0.99163 -0.10289 -0.077992 ; 0.12718 0.88254 0.45272 ; 0.022249 -0.45885  0.88824 ]; #  ZhouEA19, 170810 event hyb t = 31-36
elseif( iRotate==29 )
  eLMN0 = [ 0.91348 0.37952 0.14671 ; -0.40313  0.79529  0.45277 ; 0.055158 -0.47274 0.87947 ]; # ZhouEA19, 170810 event MDDB t = 32-33.3
elseif( iRotate==30 )
  eLMN0 = [ 0.99921 -0.03951 -0.0042789 ; 0.03621 0.86075 0.50774 ; -0.016378 -0.50749 0.8615 ]; # ZhouEA19, 170810 event MDDB t = 32-32.5, nsmoo = 301, mvav1
elseif( iRotate==31 ) # little, 301, mvav2
  eLMN0 = [ 0.99081 -0.12501  -0.051722 ; 0.13392  0.85218  0.50582 ; -0.019156  -0.5081  0.86109 ]; # ZhouEA19, 170810 event MDDB t = 32-32.5, nsmoo = 301, mvav2
elseif( iRotate==32 )
  eLMN0 = [ 0.99167 -0.10187 -0.07882 ; 0.12664 0.88281 0.45234 ; 0.023504 -0.45855 0.88836 ]; # #  ZhouEA19, 170810 event hyb t = 31-36. nsmoo=501
elseif( iRotate==33 ) # big, 301, 31-36
  eLMN0 = [ 0.99157 -0.10265 -0.079042 ; 0.12744  0.88262  0.45248 ; 0.023316 -0.45874  0.88826 ]; # ZhouEA19, 170810 event hyb t = 31-36. nsmoo=301
elseif( iRotate==34 ) # tiny, 301, mvav2
  eLMN0 = [ 0.93242 0.35196 0.082017 ; -0.34845 0.81537 0.46233 ; 0.095847 -0.45966 0.88291 ]; # ZhouEA19, 170810, MDDB t=32.84-32.94
elseif( iRotate==35 ) # big, 301, 31-35.5
  eLMN0 = [ 0.98721 -0.13055 -0.091487 ; 0.15797 0.8782 0.45146 ; 0.021408 -0.46014  0.88759];  # # ZhouEA19, 170810 event hyb t = 31-35.5. nsmoo=301
elseif( iRotate==36 ) # rotation about N_35 opposite to that of 35->34
  eLMN0 = [   0.77596     -0.55216     -0.30496   ;   0.63041      0.69527      0.34523   ;  0.021408     -0.46014      0.88759 ];
elseif( iRotate==37 ) # 
  eLMN0 = [   0.98405     -0.17789    0.0017146 ;       0.16255      0.90304      0.39761 ;     -0.072278     -0.39098      0.91755 ]; # 31-35.5 MBB
elseif( iRotate==38 )
  eLMN0 = [   0.19282058,   0.13992811,   0.97120562 ; 0.59811480,  -0.80140370,  -0.0032845179 ; 0.77786818,   0.58152578,  -0.23822020 ]; # Kevin 150919 0741 Event
elseif( iRotate==39 )
  eLMN0 = [ 0.21107   0.14168  0.96715 ; 0.46105   -0.88689  0.029299 ; 0.8619  0.43972  -0.25251 ]; # My Hybrid for Kevin 150919 0741 Event (.5s smooth, 20-30.5 s) 
elseif( iRotate==71 )  
  eLMN0 = [ 0.98838      0.15194   -0.0035189 ; -0.15193      0.98839    0.0026723 ; 0.0038841   -0.0021066      0.99999 ];     # Y Liu 0.1 to 0.58
elseif( iRotate==72 )  
  eLMN0 = [ 1 0 0 ; 0 1 0 ; 0 0 1 ];     % Approx Y Liu
end

iScOutIn = intro.iScOutIn;

if( iScOutIn>10 & iScOutIn<=14 )
  iScOut = iScOutIn-10;
  iScOutJOnly = 1;
else
  iScOut = iScOutIn;
  iScOutJOnly = 0;
end

iSubAvB = intro.iSubAvB;

if( iSubAvB==1 )
  bOffsets = [   -0.015232    -0.023981     0.083778    -0.044564 ; ... % Richard burst data average
    -0.0037842    0.0021172    0.0039243   -0.0022573 ; ...
    0.03126   -0.0076586    -0.025851    0.0022493 ];
elseif( iSubAvB==2 )
  bOffsets = [   -0.00879446  0.00263087   0.0113972   -0.00523364 ; ...  % Kevin quiet
    -0.00100329  0.00331192  -0.00801157   0.00570295 ; ...
    -0.0572085   0.0155371    0.0346972    0.00697424 ];
end
gray1 = .25;
gray = [ gray1 gray1 gray1 ];

% jOffsetsSurvey = [ 0.420834  4.74815       -0.0974320 ]; % from Kevin

% aa(:,1,:) = aFPIion(:,1,1:4); % Nion in cm^-3
% aa(:,2,:) = aa(:,1,:) .* ( aFPIion(:,5,1:4) + 2*aFPIion(:,6,1:4) )/3; % pi now in cm^-3 eV
% aa(:,3:5,:) = aFPIion(:,2:4,1:4); % Vion in km/s
% aa(:,6:8,:) = aFPImag(:,1:3,1:4); % B in nT
% aa(:,9:11,:) = aFPIE(:,1:3,1:4); % E in mV/m
% aa(:,12:14,:) = aFPIe(:,2:4,1:4); % Ve in km/s
% aa(:,15,:) = aFPIe(:,1,1:4); % Ne in cm^-3
% aa(:,16:18,:) = Ji;
% aa(:,19:21,:) = Je;
% aa(:,22:24,:) = J;
% aa(:,25,:) = aFPIion(:,5,1:4); % Tpli in eV
% aa(:,26,:) = aFPIion(:,6,1:4); % Tpri in eV
% aa(:,27,:) = aFPIe(:,1,1:4); % ne in cm^-3
% aa(:,28,:) = aFPIe(:,1,1:4) .* ( aFPIe(:,5,1:4) + 2*aFPIe(:,6,1:4) )/3; % pe now in cm^-3 eV
% aa(:,29,:) = aFPIe(:,5,1:4); % Tple in eV
% aa(:,30,:) = aFPIe(:,6,1:4); % Tpre in eV
% save('mms_read_mag_pos.mat','aa','t','t1','t2','nt','dposa','a_tetrahedron','Jcurl');
% sDirData = './';

sDirData = intro.sDirData;
sDirPlots = './poly/';
iBurst = intro.iBurst;
if( iBurst==2 )
  load([sDirData 'mms_read_mag_pos_magBurst2.mat']);
elseif( iBurst==1 )
  load([sDirData 'mms_read_mag_pos_magBurst.mat']);
else
  load([sDirData 'mms_read_mag_pos.mat']);
end

aa2 = aa;
aa = zeros(size(aa));
aa(:,[6:8,22:24,27],:) = aa2(:,[6:8,22:24,27],:);
clear aa2;

% % save('SpinDir.mat','SpinDir');
% load('SpinDir.mat','SpinDir');

%%
tsub = intro.tsub;
t = t - tsub;
itscreen = intro.itscreen;
tlo = intro.tlo;
thi = intro.thi;

if( itscreen==1 )
  iscreen = find(t>=tlo & t<=thi);
  aa1 = aa(iscreen,:,:);
  dposa = dposa(iscreen,:,:);
  Jcurl = Jcurl(iscreen,:);
  nt = numel(iscreen);
else
  aa1 = aa;
end

dsc = 0;
for k = 1:3
  for i = 1:nt
    dsc = dsc + norm(squeeze(dposa(i,k,:)));
  end
end
dsc = dsc/(3*nt);
iNormD = intro.iNormD;

if( iNormD==1 )
  dposa = dposa/dsc;
end

dt = t(2)-t(1);

iAltSmooth = intro.iAltSmooth;
nsmoothspan0 = intro.nsmoothspan0;

if( iAltSmooth>0 )
  if( iAltSmooth==2 )
    bv = aa1(:,6:8,:);
    bavv = squeeze(mean(bv,3));
    bav0s = bavv(:,1).^2 + bavv(:,2).^2 + bavv(:,3).^2;
    ne = squeeze( mean( aa1(:,27,:) , 3 ) );
    Va = 21.8 * bav0s ./ sqrt(ne); % assuming all protons
    VaSmooth = quantile(Va,0.25)
  else
    VaSmooth = VaSmooth0;
  end
  tsmoothd2 = 0.5*dsc / VaSmooth;
  nsmoothspan = 2*round(tsmoothd2/dt) + 1;
else
  nsmoothspan = nsmoothspan0;
  tsmoothd2 = dt*(nsmoothspan0-1)/2;
end

if( itscreen==1 )
  iscreen = find(t>=max(t(1),tlo-tsmoothd2) & t<=min(t(end),thi+tsmoothd2));
  aa2 = aa(iscreen,:,:);
  t2 = t(iscreen);
else
  aa2 = aa;
  t2 = t;
end

if( nsmoothspan>1 )
  aa1 = aa2;
  for k = 1:size(aa,3)
    for j = 1:size(aa,2)
      aa2(:,j,k) = smooth(aa1(:,j,k),nsmoothspan); % findme
    end
  end
end

if( itscreen==1 )
  iscreen = find(t2>=tlo & t2<=thi);
  aa = aa2(iscreen,:,:);
  t = t2(iscreen);
else
  aa = aa2;
end

bv = aa(:,6:8,:);
Jcv = Jcurl(:,1:3);
if( iSubAvB>0 )
  bv = bv - repmat( reshape(bOffsets,[1,3,4]), [nt,1,1] );
end
Jpv = aa(:,22:24,:);
if( iScOut>=1 && iScOut<=4 )
  switch iScOut
    case 1
      iScInput = (2:4);
    case 2
      iScInput = [1,3,4];
    case 3
      iScInput = [1,2,4];
    case 4
      iScInput = (1:3);
  end
  if( iScOutJOnly==1 )
    bavv = squeeze(mean(bv,3));
  else
    bavv = squeeze(mean(bv(:,:,iScInput),3));
  end
  Jpavv = squeeze(mean(Jpv(:,:,iScInput),3));
else
  bavv = squeeze(mean(bv,3));
  Jpavv = squeeze(mean(Jpv,3));
end
bav0s = bavv(:,1).^2 + bavv(:,2).^2 + bavv(:,3).^2;
bav0 = sqrt(bav0s);
Bnorms = median(bav0s);
xv = zeros(nt,3,4);  xv(:,:,2:4) = permute(dposa,[1,3,2]); xv0 = mean(xv,3); 

iAltOrigin = intro.iAltOrigin;
if( iAltOrigin==0 ) 
  xv = xv - repmat(xv0,[1,1,4]);
elseif( iAltOrigin>=11 && iAltOrigin<=14 )
  xv = xv - repmat(xv(:,:,iAltOrigin-10),[1,1,4]) - repmat(1,[nt,3,4]);
elseif( iAltOrigin>=1 && iAltOrigin<=4 )
  xv = xv - repmat(xv(:,:,iAltOrigin),[1,1,4]);
else
  error('Bad iAltOrigin value');
end
if( iNormD==1 )
  Jpv = Jpv*dsc;
  Jpavv = Jpavv*dsc;
  Jcv = Jcv*dsc;
end
if( iSubAvB>0 )
  [ JcvOffsets, ~, ~ ] = curlometer( xv(1,:,1), xv(1,:,2), xv(1,:,3), xv(1,:,4), bOffsets(:,1), bOffsets(:,2), bOffsets(:,3), bOffsets(:,4) );
  if( iNormD==1 )
    JcvOffsets = JcvOffsets/dsc;
  end
  Jcv = Jcv - repmat(JcvOffsets',[nt,1]);
end
ne = aa(:,27,:);
Va0 = squeeze( 21.812 * bav0 ./ sqrt( mean(ne,3) ) );
VaLoMnMdHi = [ min(Va0) mean(Va0) median(Va0) max(Va0) ];

if( iRotate>0 )
  eLMN0p = eLMN0';
  for i = 1:nt
    for k = 1:4
      bv(i,:,k) = bv(i,:,k)*eLMN0p;
      Jpv(i,:,k) = Jpv(i,:,k)*eLMN0p;
      xv(i,:,k) = xv(i,:,k)*eLMN0p;
    end
    bavv(i,:) = bavv(i,:)*eLMN0p;
    Jpavv(i,:) = Jpavv(i,:)*eLMN0p;
    Jcv(i,:) = Jcv(i,:)*eLMN0p;
    for k = 1:3
      dposold = reshape(dposa(i,k,:),[1,3]);
      dposnew = dposold*eLMN0p;
      dposa(i,k,:) = reshape(dposnew,[1,1,3]);
    end
  end
  eLMN0 = [ 1 0 0 ; 0 1 0 ; 0 0 1 ];
end
eLMN0p = eLMN0';
% M0 = eLMN0(2,:);  % tentative M value

% Calculate gradient of one component of bv
mgb = zeros(nt,3,3);
dfcol = zeros(3,1);
grad1 = zeros(3,1);
g = zeros(nt,3);
for ic = 1:3
  cbv = reshape(bv(:,ic,:),nt,4);
  for i = 1:nt
    dpos = squeeze(dposa(i,:,:));
    dfcol = reshape(cbv(i,2:4)-cbv(i,1),[3,1]);
    grad1 = dpos\dfcol;
    g(i,:) = reshape(grad1,[1,3]);
  end
  mgb(:,:,ic) = g(:,:);      % mgb dimensions (time,xyz,bxbybz)
end
mgb = mgb/a_tetrahedron;

% Solve MDDB
mbg = permute(mgb,[1 3 2]);
mgbbg = zeros(3,3);
lambda = zeros(nt,3);
mv = zeros(nt,3,3);
mvMG = zeros(nt,3,3);
mv2last = zeros(3,3);
mv2 = zeros(3,3);
angMM0 = zeros(nt,1);

iNormFlds = intro.iNormFlds;

for iV = 1:2
  for i = 1:nt
    
    if( iV==1 )
      mgbbg = reshape(mgb(i,:,:),3,3) * reshape(mbg(i,:,:),3,3);
    else
      mgbbg = reshape(mbg(i,:,:),3,3) * reshape(mgb(i,:,:),3,3);
    end
    
    % Solve eigenvalue problem
    [mv1,md1] = eig(mgbbg);
    
    % Sort matrices
    lambda1 = zeros(1,3);
    for ij= 1:3
      lambda1(ij) = md1(ij,ij);
    end
    if( iNormFlds==1 ), lambda1 = lambda1/Bnorms; end
    
    [lambda2,isort] = sort(lambda1,'descend');
    mv21 = mv1(:,isort);
    

    
    if( iV==1 )
      mv2(:,3) = mv21(:,1);
      if( dot(mv2(:,3),eLMN0(3,:)')<0 )
        mv2(:,3) = -mv2(:,3);
      end
      mv2(:,2) = mv21(:,3);
      if( dot(mv2(:,2),eLMN0(2,:)')<0 )
        mv2(:,2) = -mv2(:,2);
      end
      mv2(:,1) = cross( mv2(:,2), mv2(:,3) );
      
      mv(i,:,:) = mv2;
      angMM0(i) = dangle(eLMN0(2,:),mv2(:,3)');
      lambda(i,:) = lambda2([2,3,1]);
    else
      mv2(:,1) = mv21(:,1);
      if( dot(mv2(:,1),eLMN0(1,:)')<0 )
        mv2(:,1) = -mv2(:,1);
      end
      mv2(:,3) = mv21(:,3);
      if( dot(mv2(:,3),eLMN0(3,:)')<0 )
        mv2(:,3) = -mv2(:,3);
      end
      mv2(:,2) = cross( mv2(:,3), mv2(:,1) );
      mvMG(i,:,:) = mv2;
    end
    
    %   mbg1 = squeeze( mbg(i,:,:) );
    %   mvMG(i,:,:) = mbg1*mv2;
    
  end
end

mvcalc = zeros(nt,3,3,2);
mvcalc(:,:,:,1) = mv;
mvcalc(:,:,:,2) = mvMG;
iNoXRotation = intro.iNoXRotation;
if( iNoXRotation==1 )
  mv = repmat( reshape( eLMN0' , [1,3,3] ) , [nt,1,1] );
end

epsLambda = [ median(lambda(:,1)./lambda(:,2)) median(lambda(:,2)./lambda(:,3)) ];
% lambdaMedian = median(lambda,3)

%% Get vectors in new coordinates
% bv = aa(:,6:8,:);
% Jpv = aa(:,22:24,:);
% Jcv = Jcurl(:,1:3);
% xv = zeros(nt,3,4);
bvn = zeros(size(bv));
Jpvn = zeros(size(Jpv));
Jcvn = zeros(size(Jcv));
xvn = zeros(size(xv));
% SpinDirn = zeros(nt,3,4);
for i = 1:nt
  for j = 1:3
    for k = 1:4
      bvn(i,j,k) = dot( bv(i,:,k) , mv(i,:,j) );
      Jpvn(i,j,k) = dot( Jpv(i,:,k) , mv(i,:,j) );
      xvn(i,j,k) = dot( xv(i,:,k) , mv(i,:,j) );
      %       SpinDirn(i,j,k) = dot( SpinDir(:,k) , mv(i,:,j) );
    end %k sc
    Jcvn(i,j) = dot( Jcv(i,:) , mv(i,:,j) );
  end %j comp
end %i t
Jpvavn = squeeze(mean(Jpvn,3));
% SpinDirAvn = squeeze(mean(SpinDirn,3));

%% Adjust electron density for best match of Jpvn to Jcvn
fne = zeros(nt,1); % density fudge
for i = 1:nt
  fne(i) = dot( Jpvavn(i,:) , Jcvn(i,:) ) / dot( Jpvavn(i,:) , Jpvavn(i,:) );
end
iselne = fne>=0.6667 & fne<=1.5;
fracfnegood = numel(find(iselne==1))/nt;
iPlot32 = intro.iPlot32;
if( iPlot32>0 )
  figure(32)
  semilogy(t,fne)
  % xlabel('t(s) after 22:30 UT')
  ylabel('fne density fudge')
end
iAltNe = intro.iAltNe;
if( iAltNe==1 )
  fnepos = fne; fnepos(fne<0) = 1;
elseif( iAltNe==2 )
  fnepos = repmat( median(fne(:)) , [nt,1] );
  iselne = (1:nt)';
else
  fnepos = ones(nt,1);
  iselne = (1:nt)';
end

setup.fnepos = fnepos;


Jpvn2 = repmat(fnepos,[1,3,4]).*Jpvn;
Jpvavn2 = squeeze(mean(Jpvn2,3));
Jpv2 = repmat(fnepos,[1,3,4]).*Jpv;
Jpvav2 = squeeze(mean(Jpv2,3));

setup.nt = nt;
setup.iScOut = iScOut;

setup.xvn = xvn;
setup.bvn = bvn;
setup.Jpvn = Jpvn;
setup.Jpvn2 = Jpvn2;
setup.Jpvavn2 = Jpvavn2;
setup.Jpv2 = Jpv2;
setup.Jpvav2 = Jpvav2;

setup.bvn = bvn;
setup.bavv = bavv;
setup.mv = mv;

end % end function
