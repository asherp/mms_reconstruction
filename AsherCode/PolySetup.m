function setup = PolySetup(intro, mms)
%%
iQuadSys = intro.iSystem - 4; % -1/0/1/2/3/4/5 for quad+, quad,quad-,quad--,2D
setup.iQuadSys = iQuadSys;
iRotate = intro.iRotate;
iv = [];

eLMN0 = elmn_init(iRotate);

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

% sDirData = intro.sDirData;
sDirPlots = './poly/';
% iBurst = intro.iBurst;


aa = mms.aa;
t = mms.t;
dposa = mms.dposa;
Jcurl = mms.Jcurl;
a_tetrahedron = mms.a_tetrahedron;


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

setup.xv = xv;
setup.xvn = xvn;
setup.bvn = bvn;
setup.Jpvn = Jpvn;
setup.Jpvn2 = Jpvn2;
setup.Jpvavn2 = Jpvavn2;
setup.Jpv2 = Jpv2;
setup.Jpvav2 = Jpvav2;

setup.bv = bv;
setup.bvn = bvn;
setup.bavv = bavv;
setup.mv = mv;

setup.lambda = lambda;
setup.t = t;
setup.mvcalc = mvcalc;

setup.dsc = dsc;

end % end function
