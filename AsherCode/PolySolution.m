function soln = PolySolution(intro, setup)

%% Solve problem
iTest = intro.iTest;
iSystem = intro.iSystem;
iQuadSys = setup.iQuadSys;

iNormFlds = intro.iNormFlds;
wMag = intro.wMag;

if( iTest==1 )
  xvn(1,:,:) = xvn(1,:,:)/10;
end

%%
if( iSystem==1 ) % Special 2D
  neq  = 25;
  nvar = 14;
elseif( iSystem==2 ) % Special3D
  neq  = 25;
  nvar = 17;
elseif( iSystem==8 ) % Special3D Lmin
  neq  = 25;
  nvar = 17;
elseif( iSystem==9 ) % Special3D Lmin
  neq  = 28;
  nvar = 28;
  iv = (1:28);
elseif( iSystem==10 ) % 3D linear
  neq  = 13;
  nvar = 12;
elseif( iSystem==11 ) % 2D linear
  neq  = 13;
  nvar = 9;
elseif( iSystem==12 ) % 3D linear w J
  neq  = 25;
  nvar = 12;
elseif( iSystem==13 ) % 2D linear w J
  neq  = 25;
  nvar = 9;
elseif( iSystem>=3 & iSystem<=7 ) % quad program
  if( iQuadSys==-1 )
    neq = 28; nvar = 28;
    iv = (1:28);
  elseif( iQuadSys==0 )
    neq = 28; nvar = 27;
    iv = (1:27);
  elseif( iQuadSys==1 )
    neq = 27; nvar = 23;
    iv = [ (1:8) 0 (9:16) 0 (17:23) 0 0 ];
  elseif( iQuadSys==2 )
    neq = 27; nvar = 21;
    iv = [ (1:7) 0 0 (8:14) 0 0 (15:21) 0 0 ];
  else
    neq = 27; nvar = 18;
    iv = [ (1:6) 0 0 0 (7:12) 0 0 0 (13:18) 0 0 0 ];
  end
else
  error(['Unsupported iSystem value = ' num2str(iSystem)]);
end
nt = setup.nt;

X = NaN(nt,nvar);
Y = NaN(nt,neq);
iconverge = zeros(nt,1);
Yfit = NaN(nt,neq);
X1 = zeros(nvar,1);
Y1 = zeros(neq,1);
A1 = zeros(neq,nvar);
nit = 1;
iExactB = intro.iExactB;
iScOut = setup.iScOut;
if( exist('iNoJConvert','var')==1 && iNoJConvert==1 )
  mu0e3 = 1;
else
  mu0e3=4.*pi*1.e-7*1.e3;
end
if( iQuadSys==-1 )
  iexact = (1:neq)';
  inotexact = [];
elseif( iExactB==1 )
  iexact = [(1:12) (25:neq)]';
  inotexact = (13:24)';
  if( iScOut~=0 )
    error('need iScOut=0 with iExactB==1' )
  end
elseif( iScOut==1 || iScOut==2 || iScOut==3 || iScOut==4 )
  if( iScOutJOnly==1 )
    if( iSystem==1 || iSystem==2 || iSystem==5 || iSystem==6 || iSystem==7 || iSystem==8 || iSystem==12 || iSystem==13 )
      iexact = [(25:neq)]';
      switch iScOut
        case 1
          inotexact = [(1:12) (14:16) (18:20) (22:24)]';
        case 2
          inotexact = [(1:12) 13 (15:17) (19:21) (23:24)]';
        case 3
          inotexact = [(1:12) (13:14) (16:18) (20:22) 24]';
        case 4
          inotexact = [(1:12) (13:15) (17:19) (21:23)]';
      end
    else
      error('illegal iSystem value with iScOutJOnly==1')
    end    
  else % < iScOutJOnly==1
    if( iSystem==1 || iSystem==2 || iSystem==7 || iSystem==8 || iSystem==12 || iSystem==13 )
        iexact = [(25:neq)]';
        switch iScOut
          case 1
            inotexact = [(2:4) (6:8) (10:12) (14:16) (18:20) (22:24)]';
          case 2
            inotexact = [1 (3:5) (7:9) (11:13) (15:17) (19:21) (23:24)]';
          case 3
            inotexact = [(1:2) (4:6) (8:10) (12:14) (16:18) (20:22) 24]';
          case 4
            inotexact = [(1:3) (5:7) (9:11) (13:15) (17:19) (21:23)]';
        end
    elseif( iSystem==6 )
      inotexact = [];
      switch iScOut
        case 1
          iexact = [(1:12) (14:16) (18:20) (22:24) (25:neq)]';
        case 2
          iexact = [(1:12) 13 (15:17) (19:21) (23:24) (25:neq)]';
        case 3
          iexact = [(1:12) (13:14) (16:18) (20:22) 24 (25:neq)]';
        case 4
          iexact = [(1:12) (13:15) (17:19) (21:23) (25:neq)]';
      end
    elseif( iSystem==10 || iSystem==11 )
      iexact = [(13:neq)]';
      switch iScOut
        case 1
          inotexact = [(2:4) (6:8) (10:12)]';
        case 2
          inotexact = [1 (3:5) (7:9) (11:12)]';
        case 3
          inotexact = [(1:2) (4:6) (8:10) 12]';
        case 4
          inotexact = [(1:3) (5:7) (9:11)]';
      end
    else
      error('unsupported option with iScOut==1 || iScOut==2 || iScOut==3 || iScOut==4');
    end % iSystem options
  end  % < iScOutJOnly~=1
elseif( iSystem==10 )
  iexact = [(13:neq)]';
  inotexact = (1:12)';
elseif( iSystem==11 )
  iexact = [(13:neq)]';
  inotexact = (1:12)';
else
  iexact = [(25:neq)]';
  inotexact = (1:24)';
end
itestbreak = 0;
ita = zeros(nt,1);
dev = zeros(nt,1);

Jpvn2 = setup.Jpvn2;
Jpvavn2 = setup.Jpvavn2;
Jpv2 = setup.Jpv2;
Jpvav2 = setup.Jpvav2;
xvn = setup.xvn;
bvn = setup.bvn;
bavv = setup.bavv;

iIncmprs = intro.iIncmprs;

for i = 1:nt
  
  for it = 1:nit %
    
    if( it>1 )
      J0x = X1(17) - X1(11);
      J0y = X1( 4) - X1(16);
      J0z = X1( 9) - X1( 3);
      J0 = [ J0x , J0y , J0z ]/mu0e3;
      fne1 = fne(i);
      fne(i) = dot( Jpvavn(i,:) , J0 ) / dot( Jpvavn(i,:) , Jpvavn(i,:) );
      if( fne(i)<0 )
        fnepos(i) = 1;
      else
        fnepos(i) = fne(i);
      end
      Jpvn2(i,:,:) = repmat(fnepos(i),[1,3,4]).*Jpvn(i,:,:);
      Jpvavn2(i,:) = squeeze(mean(Jpvn2(i,:,:),3));
      Jpv2(i,:,:) = repmat(fnepos(i),[1,3,4]).*Jpv(i,:,:);
      Jpvav2(i,:) = squeeze(mean(Jpv2(i,:,:),3));
      iselne(i) = fne(i)>=0.6667 & fne(i)<=1.5;
      if( abs((fne(i)-fne1)/fne1)<1.e-2 )
        iconverge(i) = 1;
        break;
      elseif( fne(i)<0 )
        break;
      end
    end
    
    iLMN2G = [ 2 3 1 ];

    for k = 1:4
      if( iSystem==1 )
        % B_s,L
        A1(k, 1) = 1;
        A1(k, 2) = xvn(i,3,k);
        A1(k, 3) = xvn(i,1,k);
        A1(k, 4) = xvn(i,3,k)^2/2;
        Y1(k) = bvn(i,1,k);
        % B_s,M
        A1(4+k, 5) = 1;
        A1(4+k, 6) = xvn(i,3,k);
        A1(4+k, 7) = xvn(i,1,k);
        A1(4+k, 8) = xvn(i,3,k)^2/2;
        A1(4+k, 9) = xvn(i,1,k)^2/2;
        A1(4+k,10) = xvn(i,3,k)*xvn(i,1,k);
        Y1(4+k) = bvn(i,2,k);
        % B_s,N
        A1(8+k,11) = 1;
        A1(8+k,12) = xvn(i,3,k);
        A1(8+k,13) = xvn(i,1,k);
        A1(8+k,14) = xvn(i,1,k)^2/2;
        Y1(8+k) = bvn(i,3,k);
        % J_s,L
        A1(12+k, 6) = -1;
        A1(12+k, 8) = -xvn(i,3,k);
        A1(12+k,10) = -xvn(i,1,k);
        Y1(12+k) = Jpvn2(i,1,k)*mu0e3;
        % J_s,M
        A1(16+k, 2) =  1;
        A1(16+k, 4) =  xvn(i,3,k);
        A1(16+k,13) = -1;
        A1(16+k,14) = -xvn(i,1,k);
        Y1(16+k) = Jpvn2(i,2,k)*mu0e3;
        % J_s,N
        A1(20+k, 7) =  1;
        A1(20+k,10) =  xvn(i,3,k);
        A1(20+k, 9) =  xvn(i,1,k);
        Y1(20+k) = Jpvn2(i,3,k)*mu0e3;
      elseif( iSystem==2 )
        % B_s,L
        A1(k, 1) = 1;
        A1(k, 2) = xvn(i,3,k);
        A1(k, 3) = xvn(i,1,k);
        A1(k, 4) = xvn(i,2,k);
        A1(k, 5) = xvn(i,3,k)^2/2;
        Y1(k) = bvn(i,1,k);
        % B_s,M
        A1(4+k, 6) = 1;
        A1(4+k, 7) = xvn(i,3,k);
        A1(4+k, 8) = xvn(i,1,k);
        A1(4+k, 9) = xvn(i,2,k);
        A1(4+k,10) = xvn(i,3,k)^2/2;
        A1(4+k,11) = xvn(i,1,k)^2/2;
        A1(4+k,12) = xvn(i,3,k)*xvn(i,1,k);
        Y1(4+k) = bvn(i,2,k);
        % B_s,N
        A1(8+k,13) = 1;
        A1(8+k,14) = xvn(i,3,k);
        A1(8+k,15) = xvn(i,1,k);
        A1(8+k,16) = xvn(i,2,k);
        A1(8+k,17) = xvn(i,1,k)^2/2;
        Y1(8+k) = bvn(i,3,k);
        % J_s,L
        A1(12+k,16) =  1;
        A1(12+k, 7) = -1;
        A1(12+k,10) = -xvn(i,3,k);
        A1(12+k,12) = -xvn(i,1,k);
        Y1(12+k) = Jpvn2(i,1,k)*mu0e3;
        % J_s,M
        A1(16+k, 2) =  1;
        A1(16+k, 5) =  xvn(i,3,k);
        A1(16+k,15) = -1;
        A1(16+k,17) = -xvn(i,1,k);
        Y1(16+k) = Jpvn2(i,2,k)*mu0e3;
        % J_s,N
        A1(20+k, 8) =  1;
        A1(20+k,11) =  xvn(i,1,k);
        A1(20+k,12) =  xvn(i,3,k);
        A1(20+k, 4) = -1;
        Y1(20+k) = Jpvn2(i,3,k)*mu0e3;
      elseif( iSystem==8 )
        % B_s,Llet us hold down
        A1(k, 1) = 1;
        A1(k, 2) = xvn(i,3,k);
        A1(k, 3) = xvn(i,2,k);
        A1(k, 4) = xvn(i,1,k);
        A1(k, 5) = xvn(i,3,k)^2/2;
        A1(k, 6) = xvn(i,2,k)^2/2;
        A1(k, 7) = xvn(i,3,k)*xvn(i,2,k);
        Y1(k) = bvn(i,1,k);
        % B_s,M
        A1(4+k, 8) = 1;
        A1(4+k, 9) = xvn(i,3,k);
        A1(4+k,10) = xvn(i,2,k);
        A1(4+k,11) = xvn(i,1,k);
        A1(4+k,12) = xvn(i,3,k)^2/2;
        Y1(4+k) = bvn(i,2,k);
        % B_s,N
        A1(8+k,13) = 1;
        A1(8+k,14) = xvn(i,3,k);
        A1(8+k,15) = xvn(i,2,k);
        A1(8+k,16) = xvn(i,1,k);
        A1(8+k,17) = xvn(i,2,k)^2/2;
        Y1(8+k) = bvn(i,3,k);
        % J_s,L
        A1(12+k,15) =  1;
        A1(12+k,17) =  xvn(i,2,k);
        A1(12+k, 9) = -1;
        A1(12+k,12) = -xvn(i,3,k);
        Y1(12+k) = Jpvn2(i,1,k)*mu0e3;
        % J_s,M
        A1(16+k, 2) =  1;
        A1(16+k, 5) =  xvn(i,3,k);
        A1(16+k, 7) =  xvn(i,2,k);
        A1(16+k,16) = -1;
        Y1(16+k) = Jpvn2(i,2,k)*mu0e3;
        % J_s,N
        A1(20+k,11) =  1;
        A1(20+k, 3) = -1;
        A1(20+k, 7) = -xvn(i,3,k);
        A1(20+k, 6) = -xvn(i,2,k);
        Y1(20+k) = Jpvn2(i,3,k)*mu0e3;
      elseif( iSystem==10 )
        % B_s,L
        A1(k, 1) = 1;
        A1(k, 2) = xvn(i,3,k);
        A1(k, 3) = xvn(i,1,k);
        A1(k, 4) = xvn(i,2,k);
        Y1(k) = bvn(i,1,k);
        % B_s,M
        A1(4+k, 5) = 1;
        A1(4+k, 6) = xvn(i,3,k);
        A1(4+k, 7) = xvn(i,1,k);
        A1(4+k, 8) = xvn(i,2,k);
        Y1(4+k) = bvn(i,2,k);
        % B_s,N
        A1(8+k,9) = 1;
        A1(8+k,10) = xvn(i,3,k);
        A1(8+k,11) = xvn(i,1,k);
        A1(8+k,12) = xvn(i,2,k);
        Y1(8+k) = bvn(i,3,k);
      elseif( iSystem==11 )
        % B_s,L
        A1(k, 1) = 1;
        A1(k, 2) = xvn(i,3,k);
        A1(k, 3) = xvn(i,1,k);
        Y1(k) = bvn(i,1,k);
        % B_s,M
        A1(4+k, 4) = 1;
        A1(4+k, 5) = xvn(i,3,k);
        A1(4+k, 6) = xvn(i,1,k);
        Y1(4+k) = bvn(i,2,k);
        % B_s,N
        A1(8+k,7) = 1;
        A1(8+k,8) = xvn(i,3,k);
        A1(8+k,9) = xvn(i,1,k);
        Y1(8+k) = bvn(i,3,k);
      elseif( iSystem==12 ) % 3D linear w J
        % B_s,L
        A1(k, 1) = 1;
        A1(k, 2) = xvn(i,3,k);
        A1(k, 3) = xvn(i,1,k);
        A1(k, 4) = xvn(i,2,k);
        Y1(k) = bvn(i,1,k);
        % B_s,M
        A1(4+k, 5) = 1;
        A1(4+k, 6) = xvn(i,3,k);
        A1(4+k, 7) = xvn(i,1,k);
        A1(4+k, 8) = xvn(i,2,k);
        Y1(4+k) = bvn(i,2,k);
        % B_s,N
        A1(8+k,9) = 1;
        A1(8+k,10) = xvn(i,3,k);
        A1(8+k,11) = xvn(i,1,k);
        A1(8+k,12) = xvn(i,2,k);
        Y1(8+k) = bvn(i,3,k);
        % J_s,L
        A1(12+k,12) =  1;
        A1(12+k, 6) = -1;
        Y1(12+k) = Jpvn2(i,1,k)*mu0e3;
        % J_s,M
        A1(16+k, 2) =  1;
        A1(16+k,11) = -1;
        Y1(16+k) = Jpvn2(i,2,k)*mu0e3;
        % J_s,N
        A1(20+k, 7) =  1;
        A1(20+k, 4) = -1;
        Y1(20+k) = Jpvn2(i,3,k)*mu0e3;
      elseif( iSystem==13 ) % 2D linear with J
        % B_s,L
        A1(k, 1) = 1;
        A1(k, 2) = xvn(i,3,k);
        A1(k, 3) = xvn(i,1,k);
        Y1(k) = bvn(i,1,k);
        % B_s,M
        A1(4+k, 4) = 1;
        A1(4+k, 5) = xvn(i,3,k);
        A1(4+k, 6) = xvn(i,1,k);
        Y1(4+k) = bvn(i,2,k);
        % B_s,N
        A1(8+k,7) = 1;
        A1(8+k,8) = xvn(i,3,k);
        A1(8+k,9) = xvn(i,1,k);
        Y1(8+k) = bvn(i,3,k);
        % J_s,L
        A1(12+k, 5) = -1;
        Y1(12+k) = Jpvn2(i,1,k)*mu0e3;
        % J_s,M
        A1(16+k, 2) =  1;
        A1(16+k, 9) = -1;
        Y1(16+k) = Jpvn2(i,2,k)*mu0e3;
        % J_s,N
        A1(20+k, 6) =  1;
        Y1(20+k) = Jpvn2(i,3,k)*mu0e3;
      elseif( iSystem==9 )
        for ic = 1:3
          if( ic==1 );
            kB = k;
            jBoff = 0;
          elseif( ic==2 );
            kB = 4 + k;
            jBoff = 9;
          elseif( ic==3 );
            kB = 8 + k;
            jBoff = 18;
          end
          % B_s,LMN
          A1(kB,jBoff+1) = 1;
          A1(kB,jBoff+2) = xvn(i,3,k); A1(kB,jBoff+3) = xvn(i,1,k); A1(kB,jBoff+4) = xvn(i,2,k);
          A1(kB,jBoff+5) = xvn(i,3,k)^2/2; A1(kB,jBoff+6) = xvn(i,1,k)^2/2;
          A1(kB,jBoff+7) = xvn(i,3,k)*xvn(i,1,k);
          A1(kB,jBoff+8) = xvn(i,3,k)*xvn(i,2,k);
          A1(kB,jBoff+9) = xvn(i,1,k)*xvn(i,2,k); % optional for M and N
          % i28term = 3; 1/2/3/4 for d^3Bl/dn^3, d^3Bm/dn^2 dl, d^3Bn/dl^2 dm, d^3Bl/dn^2dm - only relevant for iSystem=-1 or 9
          if( i28term==1 )
            if( ic==1 )
              A1(kB,28) = xvn(i,3,k)^3/6;
            end
          elseif( i28term==2 )
            if( ic==2 )
              A1(kB,28) = xvn(i,3,k)^2/2 * xvn(i,1,k);
            end
          elseif( i28term==3 )
            if( ic==3 )
              A1(kB,28) = xvn(i,1,k)^2/2 * xvn(i,2,k);
            end
          elseif( i28term==4 )
            if( ic==1 )
              A1(kB,28) = xvn(i,3,k)^2/2 * xvn(i,2,k);
            end
          elseif( i28term==5 )
            if( ic==2 )
              A1(kB,28) = xvn(i,3,k)^2/2 * xvn(i,1,k);
            end
            if( ic==3 )
              A1(kB,28) = xvn(i,1,k)^2/2 * xvn(i,2,k);
            end
            if( ic==1 )
              A1(kB,28) = xvn(i,3,k)^2/2 * xvn(i,2,k);
            end
          end
          Y1(kB) = bvn(i,ic,k);
        end % ic
        % J_s,L
        A1(12+k,22) = 1;
        A1(12+k,26) = xvn(i,3,k);
        A1(12+k,27) = xvn(i,1,k); % optional
        A1(12+k,11) = -1;
        A1(12+k,14) = -xvn(i,3,k);
        A1(12+k,16) = -xvn(i,1,k);
        A1(12+k,17) = -xvn(i,2,k);
        Y1(12+k) = Jpvn2(i,1,k)*mu0e3;
        % J_s,M
        A1(16+k, 2) =  1;
        A1(16+k, 5) =  xvn(i,3,k);
        A1(16+k, 7) =  xvn(i,1,k);
        A1(16+k, 8) =  xvn(i,2,k);
        A1(16+k,21) =  -1;
        A1(16+k,25) = -xvn(i,3,k);
        A1(16+k,24) = -xvn(i,1,k);
        A1(16+k,27) = -xvn(i,2,k); % optional
        Y1(16+k) = Jpvn2(i,2,k)*mu0e3;
        % J_s,N
        A1(20+k,12) = 1;
        A1(20+k,16) =  xvn(i,3,k);
        A1(20+k,15) =  xvn(i,1,k);
        A1(20+k,18) =  xvn(i,2,k); % optional
        A1(20+k, 4) = -1;
        A1(20+k, 8) = -xvn(i,3,k);
        A1(20+k, 9) = -xvn(i,1,k);
        Y1(20+k) = Jpvn2(i,3,k)*mu0e3;
        % i28term = 3; 1/2/3/4 for d^3Bl/dn^3, d^3Bm/dn^2 dl, d^3Bn/dl^2 dm, d^3Bl/dn^2dm - only relevant for iSystem=-1 or 9
        if( i28term==1 )
          A1(16+k,28) = xvn(i,3,k)^2/2;
        elseif( i28term==2 )
          A1(12+k,28) = -xvn(i,3,k) * xvn(i,1,k);
          A1(20+k,28) =  xvn(i,3,k)^2/2;
        elseif( i28term==3 )
          A1(12+k,28) =  xvn(i,1,k)^2/2;
          A1(16+k,28) = -xvn(i,1,k) * xvn(i,2,k);
        elseif( i28term==4 )
          A1(16+k,28) =  xvn(i,3,k) * xvn(i,2,k);
          A1(20+k,28) = -xvn(i,3,k)^2/2;   
        elseif( i28term==5 )
          A1(12+k,28) = -xvn(i,3,k)*xvn(i,1,k) + xvn(i,1,k)^2/2;
          A1(16+k,28) = -xvn(i,1,k)*xvn(i,2,k) + xvn(i,3,k)*xvn(i,2,k);
%           A1(20+k,28) = xvn(i,3,k)^2/2 -xvn(i,3,k)^2/2;    % = 0
        end
      else
        for ic = 1:3
          if( ic==1 );
            kB = k; jBoff = 0;
          elseif( ic==2 );
            kB = 4 + k; jBoff = 9;
          elseif( ic==3 );
            kB = 8 + k; jBoff = 18;
          end
          % B_s,LMN
          A1(kB,iv(jBoff+1)) = 1;
          A1(kB,iv(jBoff+2)) = xvn(i,3,k);
          A1(kB,iv(jBoff+3)) = xvn(i,1,k);
          A1(kB,iv(jBoff+4)) = xvn(i,3,k)^2/2;
          A1(kB,iv(jBoff+5)) = xvn(i,3,k)*xvn(i,1,k);
          A1(kB,iv(jBoff+6)) = xvn(i,1,k)^2/2;
          if( iQuadSys<3 )
            A1(kB,iv(jBoff+7)) = xvn(i,2,k);
            if( iQuadSys<1 || ( iQuadSys==1 && ic<3 ) )
              A1(kB,iv(jBoff+8)) = xvn(i,3,k)*xvn(i,2,k);
              if( iQuadSys<1 )
                A1(kB,iv(jBoff+9)) = xvn(i,1,k)*xvn(i,2,k);
              end
            end
          end
          Y1(kB) = bvn(i,ic,k);
        end % ic
        if( iQuadSys==-1 )
          A1(k,28) = xvn(i,3,k)^3/6;
        end
        % J_s,L
        A1(12+k,iv(11)) = -1;
        A1(12+k,iv(13)) = -xvn(i,3,k);
        A1(12+k,iv(14)) = -xvn(i,1,k);
        if( iQuadSys<3 )
          A1(12+k,iv(25)) =  1;
          if( iQuadSys<2 )
            A1(12+k,iv(17)) = -xvn(i,2,k);
            if( iQuadSys<1 )
              A1(12+k,iv(26)) =  xvn(i,3,k);
              A1(12+k,iv(27)) =  xvn(i,1,k);
            end
          end
        end
        if( iQuadSys==-1 )
          A1(12+k,28) = xvn(i,3,k)^2/2;
        end
        Y1(12+k) = Jpvn2(i,1,k)*mu0e3;
        % J_s,M
        A1(16+k,iv( 2)) =  1;
        A1(16+k,iv(21)) = -1;
        A1(16+k,iv( 4)) =  xvn(i,3,k);
        A1(16+k,iv( 5)) =  xvn(i,1,k);
        A1(16+k,iv(23)) = -xvn(i,3,k);
        A1(16+k,iv(24)) = -xvn(i,1,k);
        if( iQuadSys<2 )
          A1(16+k,iv( 8)) =  xvn(i,2,k);
          if( iQuadSys<1 )
            A1(16+k,iv(27)) = -xvn(i,2,k);
          end
        end
        Y1(16+k) = Jpvn2(i,2,k)*mu0e3;
        % J_s,N
        A1(20+k,iv(12)) =  1;
        A1(20+k,iv(14)) =  xvn(i,3,k);
        A1(20+k,iv(15)) =  xvn(i,1,k);
        if( iQuadSys<3 )
          A1(20+k,iv( 7)) = -1;
          if( iQuadSys<2 )
            A1(20+k,iv( 8)) = -xvn(i,3,k);
            if( iQuadSys<1 )
              A1(20+k,iv(18)) =  xvn(i,2,k);
              A1(20+k,iv( 9)) = -xvn(i,1,k);
            end
          end
        end
        Y1(20+k) = Jpvn2(i,3,k)*mu0e3;
      end % iSystem
    end % k sc
    % Div-B,constant
    if( iSystem==1 )
      A1(25, 3) = 1; A1(25,12) = 1; % Y1(25) = 0;
    elseif( iSystem==2 )
      A1(25, 3) = 1; A1(25, 9) = 1; if( iIncmprs==0 ),A1(25,14) = 1; end % Y1(25) = 0;
    elseif( iSystem==8 )
      A1(25,10) = 1; A1(25,14) = 1; if( iIncmprs==0 ),A1(25,4) = 1; end % Y1(25) = 0;
    elseif( iSystem==9 )
      % Div-B,constant
      A1(25, 3) = 1; A1(25,13) = 1; A1(25,20) = 1; % Y1(25) = 0;
      % Div-B,L
      A1(26, 6) = 1; A1(26,18) = 1; A1(26,25) = 1; % Y1(26) = 0;
      % Div-B,M
      A1(27, 9) = 1; A1(27,26) = 1; % Y1(27) = 0;
      % Div-B,N
      A1(28, 7) = 1; A1(28,17) = 1; A1(28,23) = 1; % Y1(28) = 0;
    elseif( iSystem==10 || iSystem==12 )
      % Div-B,constant
      A1(13, 3) = 1; A1(13,8) = 1; A1(13,10) = 1; % Y1(13) = 0;
    elseif( iSystem==11 || iSystem==13 )
      % Div-B,constant
      A1(13, 3) = 1; A1(13,8) = 1; % Y1(13) = 0;   % ****** Oops, 8 was 5 ********
    else
      % Div-B,constant
      A1(25,iv( 3)) = 1; A1(25,iv(20)) = 1; if( iQuadSys<3 && iIncmprs==0 ), A1(25,iv(16)) = 1; end; % Y1(25) = 0;
      % Div-B,N
      A1(26,iv( 5)) = 1; A1(26,iv(22)) = 1; if( iQuadSys<2 && iIncmprs==0 ), A1(26,iv(17)) = 1; end; % Y1(26) = 0;
      % Div-B,L
      A1(27,iv( 6)) = 1; A1(27,iv(23)) = 1; if( iQuadSys<1 && iIncmprs==0 ), A1(27,iv(18)) = 1; end; % Y1(27) = 0;
      % Div-B,M
      if( iQuadSys<1 && iIncmprs==0 ), A1(28,iv( 9)) = 1; A1(28,iv(26)) = 1; end; % Y1(28) = 0;
    end % iSystem
    
    if( iNormFlds==1 )
      Ymax6 = zeros(6,1);
      for i6 = 1:6
        k0 = (i6-1)*4;
        Ymax6(i6) = maxAll(abs(Y1(k0+(1:4))));
        Y1(k0+(1:4)) = Y1(k0+(1:4))*wFlds(i6)/Ymax6(i6);
        A1(k0+(1:4),:) = A1(k0+(1:4),:)*wFlds(i6)/Ymax6(i6);
      end
    elseif( wMag>1 )
      Y1(1:12) = Y1(1:12)*wMag;
      A1(1:12,:) = A1(1:12,:)*wMag;
    end
    
    if( iTest==1 )
      
      XT = (1:nvar)';
      % Div-B const
      if( iSystem==1 )
        XT(12) = -3;
      elseif( iSystem==2 )
        XT(14) = -12;
      elseif( iSystem==8 )
        XT(14) = -14;
      elseif( iSystem==9 )
        XT = [ 1 2 3 4 5 6 7 8 9 ...
          10 11 12 13 14 15 16 17 18  ...
          19 -16 21 22 -24 24 -24 -9 27 ...
          28 ]';
      elseif( iSystem==10 || iSystem==12 )
        XT = [ 1 2 3 4 5 6 7 8 9 ...
          -11 11 12 ]';
      elseif( iSystem==11 || iSystem==13 )
        XT = [ 1 2 3 4 5 6 7 -3 9 ]';
      else
        % Div-B const
        if( iQuadSys<3 )
          XT(iv(20)) = - ( XT(iv( 3)) + XT(iv(16)) );
        else
          XT(iv(20)) = - XT(iv( 3));
        end
        % Div-B N
        if( iQuadSys<2 )
          XT(iv(22)) = - ( XT(iv( 5)) + XT(iv(17)) );
        else
          XT(iv(22)) = - XT(iv( 5));
        end
        % Div-B L
        if( iQuadSys<1 )
          XT(iv(23)) = - ( XT(iv( 6)) + XT(iv(18)) );
        else
          XT(iv(23)) = - XT(iv( 6));
        end
        % Div-B M
        if( iQuadSys<1 )
          XT(iv(26)) = -XT(iv( 9));
        end
      end
      
      if( iSystem==1 )
        % B_s,L
        Y1(1:4) = XT(1) + XT(2)*xvn(1,3,:) + XT(3)*xvn(1,1,:) + XT(4)*xvn(1,3,:).^2/2;
        % B_s,M
        Y1(5:8) = XT(5) + XT(6)*xvn(1,3,:) + XT(7)*xvn(1,1,:) ...
          + XT(8)*xvn(1,3,:).^2/2 + XT(9)*xvn(1,1,:).^2/2 + XT(10)*xvn(1,3,:).*xvn(1,1,:);
        % B_s,N
        Y1(9:12) = XT(11) + XT(12)*xvn(1,3,:) + XT(13)*xvn(1,1,:) + XT(14)*xvn(1,1,:).^2/2;
        % J_s,L
        Y1(13:16) = -XT(6) - XT(8)*xvn(1,3,:) - XT(10)*xvn(1,1,:);
        % J_s,M
        Y1(17:20) = XT(2) + XT(4)*xvn(1,3,:) ...
          -XT(13) - XT(14)*xvn(1,1,:);
        % J_s,N
        Y1(21:24) = XT(7) + XT(10)*xvn(1,3,:) + XT(9)*xvn(1,1,:);
        % Div-B = 0
        Y1(25) = 0;
      elseif( iSystem==2 )
        % B_s,L
        Y1(1:4) = XT(1) + XT(2)*xvn(1,3,:) + XT(3)*xvn(1,1,:) + XT(4)*xvn(1,2,:) ...
          + XT(5)*xvn(1,3,:).^2/2;
        % B_s,M
        Y1(5:8) = XT(6) + XT(7)*xvn(1,3,:) + XT(8)*xvn(1,1,:) + XT(9)*xvn(1,2,:) ...
          + XT(10)*xvn(1,3,:).^2/2 + XT(11)*xvn(1,1,:).^2/2 + XT(12)*xvn(1,3,:).*xvn(1,1,:);
        % B_s,N
        Y1(9:12) = XT(13) + XT(14)*xvn(1,3,:) + XT(15)*xvn(1,1,:) + XT(16)*xvn(1,2,:) ...
          + XT(17)*xvn(1,1,:).^2/2;
        % J_s,L
        Y1(13:16) = XT(16) ...
          - XT( 7) - XT(10)*xvn(1,3,:) - XT(12)*xvn(1,1,:);
        % J_s,M
        Y1(17:20) = XT( 2) + XT( 5)*xvn(1,3,:) ...
          -XT(15) - XT(17)*xvn(1,1,:);
        % J_s,N
        Y1(21:24) = XT( 8) + XT(12)*xvn(1,3,:) + XT(11)*xvn(1,1,:) ...
          -XT( 4);
        % Div-B = 0
        Y1(25) = 0;
      elseif( iSystem==8 )
        % B_s,L
        Y1(1:4) = XT(1) + XT(2)*xvn(1,3,:) + XT(3)*xvn(1,2,:) + XT(4)*xvn(1,1,:) ...
          + XT(5)*xvn(1,3,:).^2/2 + XT(6)*xvn(1,2,:).^2/2 + XT(7)*xvn(1,3,:).*xvn(1,2,:);
        % B_s,M
        Y1(5:8) = XT(8) + XT(9)*xvn(1,3,:) + XT(10)*xvn(1,2,:) + XT(11)*xvn(1,1,:) ...
          + XT(12)*xvn(1,3,:).^2/2;
        % B_s,N
        Y1(9:12) = XT(13) + XT(14)*xvn(1,3,:) + XT(15)*xvn(1,2,:) + XT(16)*xvn(1,1,:) ...
          + XT(17)*xvn(1,2,:).^2/2;
        % J_s,L
        Y1(13:16) = XT(15) + XT(17)*xvn(1,2,:) ...
          - XT( 9) - XT(12)*xvn(1,3,:);
        % J_s,M
        Y1(17:20) = XT( 2) + XT( 5)*xvn(1,3,:) + XT( 7)*xvn(1,2,:) ...
          -XT(16);
        % J_s,N
        Y1(21:24) = XT(11) ...
          -XT( 3) - XT( 7)*xvn(1,3,:) - XT( 6)*xvn(1,2,:);
        % Div-B = 0
        Y1(25) = 0;
      elseif( iSystem==10 )
        % B_s,L
        Y1(1:4) = XT(1) + XT(2)*xvn(1,3,:) + XT(3)*xvn(1,1,:) + XT(4)*xvn(1,2,:);
        % B_s,M
        Y1(5:8) = XT(5) + XT(6)*xvn(1,3,:) + XT(7)*xvn(1,1,:) + XT(8)*xvn(1,2,:);
        % B_s,N
        Y1(9:12) = XT(9) + XT(10)*xvn(1,3,:) + XT(11)*xvn(1,1,:) + XT(12)*xvn(1,2,:);
        % Div-B = 0
        Y1(13) = 0;
      elseif( iSystem==11 )
        % B_s,L
        Y1(1:4) = XT(1) + XT(2)*xvn(1,3,:) + XT(3)*xvn(1,1,:);
        % B_s,M
        Y1(5:8) = XT(4) + XT(5)*xvn(1,3,:) + XT(6)*xvn(1,1,:);
        % B_s,N
        Y1(9:12) = XT(7) + XT(8)*xvn(1,3,:) + XT(9)*xvn(1,1,:);
        % Div-B = 0
        Y1(13) = 0;
       elseif( iSystem==12 )
        % B_s,L
        Y1(1:4) = XT(1) + XT(2)*xvn(1,3,:) + XT(3)*xvn(1,1,:) + XT(4)*xvn(1,2,:);
        % B_s,M
        Y1(5:8) = XT(5) + XT(6)*xvn(1,3,:) + XT(7)*xvn(1,1,:) + XT(8)*xvn(1,2,:);
        % B_s,N
        Y1(9:12) = XT(9) + XT(10)*xvn(1,3,:) + XT(11)*xvn(1,1,:) + XT(12)*xvn(1,2,:);
        % J_s,L
        Y1(13:16) = XT(12) - XT( 6);
        % J_s,M
        Y1(17:20) = XT( 2) - XT(11);
        % J_s,N
        Y1(21:24) = XT( 7) - XT( 4);
        % Div-B = 0
        Y1(25) = 0;
      elseif( iSystem==13 )
        % B_s,L
        Y1(1:4) = XT(1) + XT(2)*xvn(1,3,:) + XT(3)*xvn(1,1,:);
        % B_s,M
        Y1(5:8) = XT(4) + XT(5)*xvn(1,3,:) + XT(6)*xvn(1,1,:);
        % B_s,N
        Y1(9:12) = XT(7) + XT(8)*xvn(1,3,:) + XT(9)*xvn(1,1,:);
        % J_s,L
        Y1(13:16) =        - XT( 5);
        % J_s,M
        Y1(17:20) = XT( 2) - XT( 9);
        % J_s,N
        Y1(21:24) = XT( 6)         ;
        % Div-B = 0
        Y1(25) = 0;
      elseif( iSystem==9 ) 
        % B_s,L
        j0 = 0;
        Y1(1:4) = XT(j0+1) + XT(j0+2)*xvn(1,3,:) + XT(j0+3)*xvn(1,1,:) + XT(j0+4)*xvn(1,2,:) ...
          + XT(j0+5)*xvn(1,3,:).^2/2 + XT(j0+6)*xvn(1,1,:).^2/2 ...
          + XT(j0+7)*xvn(1,3,:).*xvn(1,1,:) + XT(j0+8)*xvn(1,3,:).*xvn(1,2,:) + XT(j0+9)*xvn(1,1,:).*xvn(1,2,:);
        if( i28term==1 )
          Y1(1:4) = Y1(1:4) + reshape( XT(  28)*xvn(1,3,:).^3/6 , [4,1] );
        elseif( i28term==4 || i28term==5 )
          Y1(1:4) = Y1(1:4) + reshape( XT(  28)*xvn(1,3,:).^2/2 .*xvn(1,2,:)  , [4,1] );
        end
        % B_s,M
        j0 = 9;
        Y1(5:8) = XT(j0+1) + XT(j0+2)*xvn(1,3,:) + XT(j0+3)*xvn(1,1,:) + XT(j0+4)*xvn(1,2,:) ...
          + XT(j0+5)*xvn(1,3,:).^2/2 + XT(j0+6)*xvn(1,1,:).^2/2 ...
          + XT(j0+7)*xvn(1,3,:).*xvn(1,1,:) + XT(j0+8)*xvn(1,3,:).*xvn(1,2,:) + XT(j0+9)*xvn(1,1,:).*xvn(1,2,:);
        if( i28term==2 || i28term==5 )
          Y1(5:8) = Y1(5:8) + reshape( XT(  28)*xvn(1,3,:).^2/2 .*xvn(1,1,:) , [4,1] );
        end
        % B_s,N
        j0 = 18;
        Y1(9:12) = XT(j0+1) + XT(j0+2)*xvn(1,3,:) + XT(j0+3)*xvn(1,1,:) + XT(j0+4)*xvn(1,2,:) ...
          + XT(j0+5)*xvn(1,3,:).^2/2 + XT(j0+6)*xvn(1,1,:).^2/2 ...
          + XT(j0+7)*xvn(1,3,:).*xvn(1,1,:) + XT(j0+8)*xvn(1,3,:).*xvn(1,2,:) + XT(j0+9)*xvn(1,1,:).*xvn(1,2,:);
        if( i28term==3 || i28term==5 )
          Y1(9:12) = Y1(9:12) + reshape( XT(  28)*xvn(1,1,:).^2/2 .*xvn(1,2,:) , [4,1] );
        end
        % J_s,L
        Y1(13:16) = XT(22) + XT(26)*xvn(1,3,:) + XT(27)*xvn(1,1,:) ...
          -XT(11) - XT(14)*xvn(1,3,:) - XT(16)*xvn(1,1,:) - XT(17)*xvn(1,2,:);
        if( i28term==2 )
          Y1(13:16) = Y1(13:16) + reshape( -XT(  28)*xvn(1,3,:).*xvn(1,1,:) , [4,1] );
        elseif( i28term==3 )
          Y1(13:16) = Y1(13:16) + reshape( XT(  28)*xvn(1,1,:).^2/2  , [4,1] );
        elseif( i28term==5 )
          Y1(13:16) = Y1(13:16) + reshape( XT(  28)*( -xvn(1,3,:).*xvn(1,1,:) ...
                                                       + xvn(1,1,:).^2/2 ) , [4,1] );
        end
        % J_s,M
        Y1(17:20) = XT( 2) + XT( 5)*xvn(1,3,:) + XT( 7)*xvn(1,1,:) + XT( 8)*xvn(1,2,:) ...
          -XT(21) - XT(25)*xvn(1,3,:) - XT(24)*xvn(1,1,:) - XT(27)*xvn(1,2,:);
        if( i28term==1 )
          Y1(17:20) = Y1(17:20) + reshape( XT(  28)*xvn(1,3,:).^2/2 , [4,1] );
        elseif( i28term==3 )
          Y1(17:20) = Y1(17:20) + reshape( -XT(  28)*xvn(1,1,:).*xvn(1,2,:)  , [4,1] );
        elseif( i28term==4 )
          Y1(17:20) = Y1(17:20) + reshape( XT(  28)*xvn(1,3,:).*xvn(1,2,:)  , [4,1] );
        elseif( i28term==5 )
          Y1(17:20) = Y1(17:20) + reshape( XT(  28)*( -xvn(1,1,:).*xvn(1,2,:) ...
                                                      +xvn(1,3,:).*xvn(1,2,:) ) , [4,1] );
        end
        % J_s,N
        Y1(21:24) = XT(12) + XT(16)*xvn(1,3,:) + XT(15)*xvn(1,1,:) + XT(18)*xvn(1,2,:) ...
          -XT( 4) - XT( 8)*xvn(1,3,:) - XT( 9)*xvn(1,1,:);
        if( i28term==2 )
          Y1(21:24) = Y1(21:24) + reshape( XT(  28)*xvn(1,3,:).^2/2 , [4,1] );
        elseif( i28term==4 )
          Y1(21:24) = Y1(21:24) + reshape( -XT(  28)*xvn(1,3,:).^2/2  , [4,1] );
%         elseif( i28term==5 )
%           Y1(21:24) = Y1(21:24) + reshape( XT(  28)*( xvn(1,3,:).^2/2 ...
%                                                        - xvn(1,3,:).^2/2 )  , [4,1] );   % = 0
        end
        % Div-B = 0
        Y1(25) = 0;
        Y1(26) = 0;
        Y1(27) = 0;
        Y1(28) = 0;
      else
        % B_s,L
        j0 = 0; iY1 = (1:4);
        Y1(iY1) = XT(iv(j0+1)) + XT(iv(j0+2))*xvn(1,3,:) + XT(iv(j0+3))*xvn(1,1,:)  ...
          + XT(iv(j0+4))*xvn(1,3,:).^2/2 + XT(iv(j0+5))*xvn(1,3,:).*xvn(1,1,:) + XT(iv(j0+6))*xvn(1,1,:).^2/2;
        if( iQuadSys<1 )
          Y1(iY1) = Y1(iY1) + reshape( XT(iv(j0+7))*xvn(1,2,:) + XT(iv(j0+8))*xvn(1,3,:).*xvn(1,2,:) + XT(iv(j0+9))*xvn(1,1,:).*xvn(1,2,:) , [4,1] );
        elseif( iQuadSys==1 )
          Y1(iY1) = Y1(iY1) + reshape( XT(iv(j0+7))*xvn(1,2,:) + XT(iv(j0+8))*xvn(1,3,:).*xvn(1,2,:) , [4,1] );
        elseif( iQuadSys==2 )
          Y1(iY1) = Y1(iY1) + reshape( XT(iv(j0+7))*xvn(1,2,:) , [4,1] );
        end
        if( iQuadSys==-1 )
          Y1(iY1) = Y1(iY1) + reshape( XT(28)*xvn(1,3,:).^3/6 , [4,1] );
        end
        % B_s,M
        j0 = 9; iY1 = (5:8);
        Y1(iY1) = XT(iv(j0+1)) + XT(iv(j0+2))*xvn(1,3,:) + XT(iv(j0+3))*xvn(1,1,:)  ...
          + XT(iv(j0+4))*xvn(1,3,:).^2/2 + XT(iv(j0+5))*xvn(1,3,:).*xvn(1,1,:) + XT(iv(j0+6))*xvn(1,1,:).^2/2;
        if( iQuadSys<1 )
          Y1(iY1) = Y1(iY1) + reshape( XT(iv(j0+7))*xvn(1,2,:) + XT(iv(j0+8))*xvn(1,3,:).*xvn(1,2,:) + XT(iv(j0+9))*xvn(1,1,:).*xvn(1,2,:) , [4,1] );
        elseif( iQuadSys==1 )
          Y1(iY1) = Y1(iY1) + reshape( XT(iv(j0+7))*xvn(1,2,:) + XT(iv(j0+8))*xvn(1,3,:).*xvn(1,2,:) , [4,1] );
        elseif( iQuadSys==2 )
          Y1(iY1) = Y1(iY1) + reshape( XT(iv(j0+7))*xvn(1,2,:) , [4,1] );
        end
        % B_s,N
        j0 = 18; iY1 = (9:12);
        Y1(iY1) = XT(iv(j0+1)) + XT(iv(j0+2))*xvn(1,3,:) + XT(iv(j0+3))*xvn(1,1,:)  ...
          + XT(iv(j0+4))*xvn(1,3,:).^2/2 + XT(iv(j0+5))*xvn(1,3,:).*xvn(1,1,:) + XT(iv(j0+6))*xvn(1,1,:).^2/2;
        if( iQuadSys<1 )
          Y1(iY1) = Y1(iY1) + reshape( XT(iv(j0+7))*xvn(1,2,:) + XT(iv(j0+8))*xvn(1,3,:).*xvn(1,2,:) + XT(iv(j0+9))*xvn(1,1,:).*xvn(1,2,:) , [4,1] );
        elseif( iQuadSys<3 )
          Y1(iY1) = Y1(iY1) + reshape( XT(iv(j0+7))*xvn(1,2,:) , [4,1] );
        end
        % J_s,L
        iY1 = (13:16);
        Y1(iY1) = -XT(iv(11)) - XT(iv(13))*xvn(1,3,:) - XT(iv(14))*xvn(1,1,:);
        if( iQuadSys<1 )
          Y1(iY1) = Y1(iY1) + reshape( XT(iv(25)) - XT(iv(17))*xvn(1,2,:) + XT(iv(26))*xvn(1,3,:) + XT(iv(27))*xvn(1,1,:) , [4,1] );
        elseif( iQuadSys==1 )
          Y1(iY1) = Y1(iY1) + reshape( XT(iv(25)) - XT(iv(17))*xvn(1,2,:) , [4,1] );
        elseif( iQuadSys==2 )
          Y1(iY1) = Y1(iY1) + repmat( XT(iv(25)) , [4,1] );
        end
        % J_s,M
        iY1 = (17:20);
        Y1(iY1) = XT(iv( 2)) - XT(iv(21)) + XT(iv( 4))*xvn(1,3,:) + XT(iv( 5))*xvn(1,1,:) - XT(iv(23))*xvn(1,3,:) - XT(iv(24))*xvn(1,1,:);
        if( iQuadSys<1 )
          Y1(iY1) = Y1(iY1) + reshape( XT(iv( 8))*xvn(1,2,:) - XT(iv(27))*xvn(1,2,:) , [4,1] );
        elseif( iQuadSys==1 )
          Y1(iY1) = Y1(iY1) + reshape( XT(iv( 8))*xvn(1,2,:) , [4,1] );
        end
        if( iQuadSys==-1 )
          Y1(iY1) = Y1(iY1) + reshape( XT(28)*xvn(1,3,:).^2/2 , [4,1] );
        end
        % J_s,N
        iY1 = (21:24);
        Y1(iY1) = XT(iv(12)) + XT(iv(14))*xvn(1,3,:) + XT(iv(15))*xvn(1,1,:);
        if( iQuadSys<1 )
          Y1(iY1) = Y1(iY1) + reshape( -XT(iv( 7)) - XT(iv( 8))*xvn(1,3,:) + XT(iv(18))*xvn(1,2,:) - XT(iv( 9))*xvn(1,1,:) , [4,1] );
        elseif( iQuadSys==1 )
          Y1(iY1) = Y1(iY1) + reshape( -XT(iv( 7)) - XT(iv( 8))*xvn(1,3,:) , [4,1] );
        elseif( iQuadSys==2 )
          Y1(iY1) = Y1(iY1) + repmat( -XT(iv( 7)) , [4,1] );
        end
        % Div-B = 0
        Y1(25) = 0;
        Y1(26) = 0;
        Y1(27) = 0;
        if( iQuadSys<1 )
          Y1(28) = 0;
        end
      end
      
      [~,idxli]=licols(A1);
      
    end
    
    %     [~,idxli]=licols(A1);
    
    % Solve equations
    %     X1 = A1\Y1;
    if( iQuadSys==-1 || iSystem==9 ) 
      X1 = A1\Y1;
    else
      X1 = lsqlin(A1(inotexact,:),Y1(inotexact),[],[],A1(iexact,:),Y1(iexact),[],[]);
    end
    
    if( iNormFlds==1 )
      for i6 = 1:6
        k0 = (i6-1)*4;
        Y1(k0+(1:4)) = Y1(k0+(1:4))/wFlds(i6)*Ymax6(i6);
        A1(k0+(1:4),:) = A1(k0+(1:4),:)/wFlds(i6)*Ymax6(i6);
      end
    elseif( wMag>1 )
      Y1(1:12) = Y1(1:12)/wMag;
      A1(1:12,:) = A1(1:12,:)/wMag;
    end
    
    if( iTest==1 )
      idxli
      Y12 = A1*X1;
      YT = A1*XT
      
      Xtest = [ (1:nvar)' XT X1 XT-X1 (XT-X1)./abs(XT) ]
      Ytest = [ (1:neq )' Y1 Y12 YT Y12-Y1 YT-Y1]
      
      itestbreak = 1;
      break;
    end
    
  end % it
  
  X(i,:) = X1';
  Y(i,:) = Y1';
  Yfit(i,:) = ( A1*X1 )';
  dev(i) = sqrt(mean( (Y(i,:)-Yfit(i,:)).^2 ))/norm(bavv(i,:));
  ita(i) = it - 1;
  
  if( itestbreak == 1 ), error('That''s all for test'); end;
  
end % i

%%

Bfitloc1 = Yfit(:,1:12);
Bfitloc2 = reshape(Bfitloc1,[nt,4,3]);
Bfitloc = permute(Bfitloc2,[1,3,2]);
if( iSystem==1 )
  B0fitloc = [X(:,1) X(:,5) X(:,11)];
elseif( iSystem==2 )
  B0fitloc = [X(:,1) X(:,6) X(:,13)];
elseif( iSystem==8 )
  B0fitloc = [X(:,1) X(:,8) X(:,13)];
elseif( iSystem==10 || iSystem==12 )
  B0fitloc = [X(:,1) X(:,5) X(:,9)];
elseif( iSystem==11 || iSystem==13 )
  B0fitloc = [X(:,1) X(:,4) X(:,7)];
else
  B0fitloc = [X(:,iv(1)) X(:,iv(10)) X(:,iv(19))];
end
if( iSystem==10 || iSystem==12 )
  Jp0fitloc = [ X(:,12)-X(:,6) X(:,2)-X(:,11) X(:,7)-X(:,4) ]; % /mu0e3;
  Jpfitloc3 = repmat(Jp0fitloc,[1,1,4]);
elseif( iSystem==11 || iSystem==13 )
  Jp0fitloc = [ -X(:,5) X(:,2)-X(:,9) X(:,6) ]; % /mu0e3
  Jpfitloc3 = repmat(Jp0fitloc,[1,1,4]);
else
  Jpfitloc1 = Yfit(:,13:24);
  Jpfitloc2 = reshape(Jpfitloc1,[nt,4,3]);
  Jpfitloc3 = permute(Jpfitloc2,[1,3,2]);
end
Jpfitloc  = Jpfitloc3; %/mu0e3;
% Jp0fitloc1 = squeeze(mean(Jpfitloc,3)); % matches with formula below
if( iSystem==1 )
  Jp0fitloc = [ -X(:,6) X(:,2)-X(:,13) X(:,7) ]; % /mu0e3;
elseif( iSystem==2 )
  Jp0fitloc = [ X(:,16)-X(:,7) X(:,2)-X(:,15) X(:,8)-X(:,4) ]; % /mu0e3;
elseif( iSystem==8 )
  Jp0fitloc = [ X(:,15)-X(:,9) X(:,2)-X(:,16) X(:,11)-X(:,3) ]; % /mu0e3;
elseif( iSystem==10 || iSystem==11 || iSystem==12 || iSystem==13 )
  % nothing needed
elseif( iSystem==9 )
  Jp0fitloc = [ X(:,22)-X(:,11) X(:,2)-X(:,21) X(:,12)-X(:,4) ]; % /mu0e3;
else
  Jp0fitloc = [ -X(:,iv(11)) X(:,iv( 2))-X(:,iv(21)) X(:,iv(12)) ]; % /mu0e3;
  if( iQuadSys<3 )
    Jp0fitloc = Jp0fitloc + [ X(:,iv(25)) repmat(0,[nt,1]) -X(:,iv( 7)) ]; % /mu0e3;
  end
end
Jpvav3 = Jpvav2*mu0e3;
Jpv3 = Jpv2*mu0e3;

% Transform back to fixed coordinates
Bfit = zeros(nt,3,4);
B0fit = zeros(nt,3);
Jpfit = zeros(nt,3,4);
Jp0fit = zeros(nt,3);
mv = setup.mv;
for i = 1:nt
  mv1 = squeeze(mv(i,:,:));
  mv1p = mv1';
  for k = 1:4
    Bfit(i,:,k) = Bfitloc(i,:,k)*mv1p;
    Jpfit(i,:,k) = Jpfitloc(i,:,k)*mv1p;
  end %k sc
  B0fit(i,:) = B0fitloc(i,:)*mv1p;
  Jp0fit(i,:) = Jp0fitloc(i,:)*mv1p;
end %i t

soln.dev = dev;
soln.Bfit = Bfit;
soln.B0fit = B0fit;
soln.Jpfit = Jpfit;
soln.Jp0fit = Jp0fit;
soln.Jpvav3 = Jpvav3;
soln.Jpv3 = Jpv3;

soln.X = X;
soln.Y = Y;

end
% end functino