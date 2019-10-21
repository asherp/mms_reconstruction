function result = B2d(intro, setup, soln, i, La, Ln)


Lmax = intro.Lmax;
nt = setup.nt;
mv = setup.mv;
iLocalGradCoord = intro.iLocalGradCoord;
X = soln.X;
iSystem = intro.iSystem;
iLocalBM = intro.iLocalBM;
irandsl511 = intro.irandsl511;

nrow = 1;
ncol = 1;
npanels = nrow*ncol;
n41 = nrow*ncol;
ipl = 1;

% if( exist('i41','var')==0 )
%     di41 = ( nt - 1 )/(n41-1);
%     i41 = round( (1:di41:nt) );
% end
% if( numel(i41)~=n41 ), error(['numel(i41) = ' numel(i41) ' <> ' num2str(n41)]); end

% nL = 31; 
% nLcut = 7;
nL = length(La);
% La = linspace(-Lmax,Lmax,nL); dL = La(2) - La(1);

% Lacut = linspace(-Lmax,Lmax,nLcut);
[L2D,N2D] = meshgrid(La);
% [L2Dcut,N2Dcut] = meshgrid(Lacut);
%   M2D = zeros(size(L2D));
casc = [ gray ; 1 0 0 ; 0 .8 0 ; .2 .2 1 ];
fwh = .65;

maxAbsValx = 0;
l2D = zeros(nL); m2D = zeros(nL); n2D = zeros(nL);
BL2D = zeros(nL); BM2D = zeros(nL); BN2D = zeros(nL);
BL2Da = zeros(nL,nL,n41);   BM2Da = zeros(nL,nL,n41);   BN2Da = zeros(nL,nL,n41); 
% for ipl = 1:n41 % nt %findme
  
  % i = i41(ipl);
  
  mv1 = squeeze(mv(i,:,:));
  for i1 = 1:nL
    for j1 = 1:nL
      Pos1 = [ L2D(j1,i1) 0 N2D(j1,i1) ];
      if( iLocalGradCoord==1 )
        pos1 = Pos1;
      else
        pos1 = Pos1 * mv1;       
      end
      l2D(j1,i1) = pos1(1);
      m2D(j1,i1) = pos1(2);
      n2D(j1,i1) = pos1(3);
    end
  end
  
  X1 = X(i,:);
  
  if( iSystem==1 )
    % B_s,L
    j0 = 0;
    Bl2D = X1(j0+1) + X1(j0+2)*n2D + X1(j0+3)*l2D + X1(j0+4)*n2D.^2/2;
    % B_s,M
    j0 = 4;
    Bm2D = X1(j0+1) + X1(j0+2)*n2D + X1(j0+3)*l2D +  ...
      + X1(j0+4)*n2D.^2/2 + X1(j0+5)*l2D.^2/2 + X1(j0+6)*n2D.*l2D;
    % B_s,N
    j0 = 10;
    Bn2D = X1(j0+1) + X1(j0+2)*n2D + X1(j0+3)*l2D + X1(j0+4)*l2D.^2/2;
  elseif( iSystem==2 )
    % B_s,L
    j0 = 0;
    Bl2D = X1(j0+1) + X1(j0+2)*n2D + X1(j0+3)*l2D + X1(j0+4)*m2D ...
      + X1(j0+5)*n2D.^2/2;
    % B_s,M
    j0 = 5;
    Bm2D = X1(j0+1) + X1(j0+2)*n2D + X1(j0+3)*l2D + X1(j0+4)*m2D ...
      + X1(j0+5)*n2D.^2/2 + X1(j0+6)*l2D.^2/2 ...
      + X1(j0+7)*n2D.*l2D;
    % B_s,N
    j0 = 12;
    Bn2D = X1(j0+1) + X1(j0+2)*n2D + X1(j0+3)*l2D + X1(j0+4)*m2D ...
      + X1(j0+5)*l2D.^2/2;
  elseif( iSystem==8 )
    % B_s,L
    j0 = 0;
    Bl2D = X1(j0+1) + X1(j0+2)*n2D + X1(j0+3)*m2D + X1(j0+4)*l2D ...
      + X1(j0+5)*n2D.^2/2 + X1(j0+6)*m2D.^2/2 + X1(j0+7)*n2D.*m2D;
    % B_s,M
    j0 = 7;
    Bm2D = X1(j0+1) + X1(j0+2)*n2D + X1(j0+3)*m2D + X1(j0+4)*l2D ...
      + X1(j0+5)*n2D.^2/2;
    % B_s,N
    j0 = 12;
    Bn2D = X1(j0+1) + X1(j0+2)*n2D + X1(j0+3)*m2D + X1(j0+4)*l2D ...
      + X1(j0+5)*m2D.^2/2;
  elseif( iSystem==10 || iSystem==12 )
      % B_s,L
      j0 = 0;
      Bl2D = X1(j0+1) + X1(j0+2)*n2D + X1(j0+3)*l2D + X1(j0+4)*m2D;
      % B_s,M
      j0 = 4;
      Bm2D = X1(j0+1) + X1(j0+2)*n2D + X1(j0+3)*l2D + X1(j0+4)*m2D;
      % B_s,N
      j0 = 8;
      Bn2D = X1(j0+1) + X1(j0+2)*n2D + X1(j0+3)*l2D + X1(j0+4)*m2D;
  elseif( iSystem==11 || iSystem==13 )
      % B_s,L
      j0 = 0;
      Bl2D = X1(j0+1) + X1(j0+2)*n2D + X1(j0+3)*l2D;
      % B_s,M
      j0 = 3;
      Bm2D = X1(j0+1) + X1(j0+2)*n2D + X1(j0+3)*l2D;
      % B_s,N
      j0 = 6;
      Bn2D = X1(j0+1) + X1(j0+2)*n2D + X1(j0+3)*l2D;
  elseif( iSystem==9 ) 
    % B_s,L
    j0 = 0;
    Bl2D = X1(j0+1) + X1(j0+2)*n2D + X1(j0+3)*l2D + X1(j0+4)*m2D ...
      + X1(j0+5)*n2D.^2/2 + X1(j0+6)*l2D.^2/2 ...
      + X1(j0+7)*n2D.*l2D + X1(j0+8)*n2D.*m2D + X1(j0+9)*l2D.*m2D;
    if( i28term==1 )
      Bl2D = Bl2D + X1(  28)*n2D.^3/6;
    elseif( i28term==4 || i28term==5 )
      Bl2D = Bl2D + X1(  28)*n2D.^2/2 .*m2D;
    end
    % B_s,M
    j0 = 9;
    Bm2D = X1(j0+1) + X1(j0+2)*n2D + X1(j0+3)*l2D + X1(j0+4)*m2D ...
      + X1(j0+5)*n2D.^2/2 + X1(j0+6)*l2D.^2/2 ...
      + X1(j0+7)*n2D.*l2D + X1(j0+8)*n2D.*m2D + X1(j0+9)*l2D.*m2D;
    if( i28term==2 || i28term==5 )
      Bm2D = Bm2D + X1(  28)*n2D.^2/2 .*l2D;
    end
    % B_s,N
    j0 = 18;
    Bn2D = X1(j0+1) + X1(j0+2)*n2D + X1(j0+3)*l2D + X1(j0+4)*m2D ...
      + X1(j0+5)*n2D.^2/2 + X1(j0+6)*l2D.^2/2 ...
      + X1(j0+7)*n2D.*l2D + X1(j0+8)*n2D.*m2D + X1(j0+9)*l2D.*m2D;
    if( i28term==3 || i28term==5 )
      Bn2D = Bn2D + X1(  28)*l2D.^2/2 .*m2D;
    end
  elseif( iSystem==28 ) 
    nnn2D = n2D.^3/6;
    lll2D = l2D.^3/6;
    nnl2D = n2D.^2.*l2D/2;
    nnm2D = n2D.^2.*m2D/2;
    lln2D = l2D.^2.*n2D/2;
    llm2D = l2D.^2.*m2D/2;
    nlm2D = n2D.*l2D.*m2D;
    % B_s,L
    j0 = 0;
    Bl2D = X1(j0+1) + X1(j0+2)*n2D + X1(j0+3)*l2D + X1(j0+4)*m2D ...
      + X1(j0+5)*n2D.^2/2 + X1(j0+6)*l2D.^2/2 ...
      + X1(j0+7)*n2D.*l2D + X1(j0+8)*n2D.*m2D + X1(j0+9)*l2D.*m2D ...
      + X1(28)*nnm2D + X1(32)*nnn2D + X1(36)*nnl2D + X1(37)*lln2D + X1(38)*lll2D + X1(39)*nlm2D + X1(40)*llm2D;
    % B_s,M
    j0 = 9;
    Bm2D = X1(j0+1) + X1(j0+2)*n2D + X1(j0+3)*l2D + X1(j0+4)*m2D ...
      + X1(j0+5)*n2D.^2/2 + X1(j0+6)*l2D.^2/2 ...
      + X1(j0+7)*n2D.*l2D + X1(j0+8)*n2D.*m2D + X1(j0+9)*l2D.*m2D ...
      + X1(29)*nnl2D + X1(30)*lln2D + X1(33)*nnn2D + X1(34)*lll2D;
    % B_s,N
    j0 = 18;
    Bn2D = X1(j0+1) + X1(j0+2)*n2D + X1(j0+3)*l2D + X1(j0+4)*m2D ...
      + X1(j0+5)*n2D.^2/2 + X1(j0+6)*l2D.^2/2 ...
      + X1(j0+7)*n2D.*l2D + X1(j0+8)*n2D.*m2D + X1(j0+9)*l2D.*m2D ...
      + X1(31)*llm2D + X1(35)*lll2D - X1(36)*nnn2D - X1(37)*nnl2D - X1(38)*lln2D - X1(39)*nnm2D - X1(40)*nlm2D;
  else
    % B_s,L
    j0 = 0;
    Bl2D = X1(iv(j0+1)) + X1(iv(j0+2))*n2D + X1(iv(j0+3))*l2D  ...
      + X1(iv(j0+4))*n2D.^2/2 + X1(iv(j0+5))*n2D.*l2D + X1(iv(j0+6))*l2D.^2/2;
    if( iQuadSys==-1 )
      Bl2D = Bl2D + X1(iv(j0+7))*m2D + X1(iv(j0+8))*n2D.*m2D + X1(iv(j0+9))*l2D.*m2D + X1(28)*n2D.^3/6;
    elseif( iQuadSys==0 )
      Bl2D = Bl2D + X1(iv(j0+7))*m2D + X1(iv(j0+8))*n2D.*m2D + X1(iv(j0+9))*l2D.*m2D;
    elseif( iQuadSys==1 )
      Bl2D = Bl2D + X1(iv(j0+7))*m2D + X1(iv(j0+8))*n2D.*m2D;
    elseif( iQuadSys==2 )
      Bl2D = Bl2D + X1(iv(j0+7))*m2D;
    end
    % B_s,M
    j0 = 9;
    Bm2D = X1(iv(j0+1)) + X1(iv(j0+2))*n2D + X1(iv(j0+3))*l2D  ...
      + X1(iv(j0+4))*n2D.^2/2 + X1(iv(j0+5))*n2D.*l2D + X1(iv(j0+6))*l2D.^2/2;
    if( iQuadSys<1 )
      Bm2D = Bm2D + X1(iv(j0+7))*m2D + X1(iv(j0+8))*n2D.*m2D + X1(iv(j0+9))*l2D.*m2D;
    elseif( iQuadSys==1 )
      Bm2D = Bm2D + X1(iv(j0+7))*m2D + X1(iv(j0+8))*n2D.*m2D;
    elseif( iQuadSys==2 )
      Bm2D = Bm2D + X1(iv(j0+7))*m2D;
    end
    % B_s,N
    j0 = 18;
    Bn2D = X1(iv(j0+1)) + X1(iv(j0+2))*n2D + X1(iv(j0+3))*l2D  ...
      + X1(iv(j0+4))*n2D.^2/2 + X1(iv(j0+5))*n2D.*l2D + X1(iv(j0+6))*l2D.^2/2;
    if( iQuadSys<1 )
      Bn2D = Bn2D + X1(iv(j0+7))*m2D + X1(iv(j0+8))*n2D.*m2D + X1(iv(j0+9))*l2D.*m2D;
    elseif( iQuadSys<3 )
      Bn2D = Bn2D + X1(iv(j0+7))*m2D;
    end
  end % iSystem
  
  if( iLocalGradCoord==1 )
    BL2D = Bl2D; BM2D = Bm2D; BN2D = Bn2D;
  else
    mv1p = mv1';
    for i1 = 1:nL
      for j1 = 1:nL
        mag1 = [ Bl2D(j1,i1) Bm2D(j1,i1) Bn2D(j1,i1) ];
        Mag1 = mag1 * mv1p;
        BL2D(j1,i1) = Mag1(1);
        BM2D(j1,i1) = Mag1(2);
        BN2D(j1,i1) = Mag1(3);
      end
    end
  end
  
  if( iLocalBM==1 )
    maxAbsVal = maxAll( abs( BM2D(:)-B0fit(i,2) ) );
  else
    maxAbsVal = maxAll( abs( BM2D(:) ) );
  end
  maxAbsValx = max( maxAbsValx,maxAbsVal );
  
  BL2Da(:,:,ipl) = BL2D; BM2Da(:,:,ipl) = BM2D; BN2Da(:,:,ipl) = BN2D; 
  
% end % ipl

 zcolorM = [ -maxAbsValx ; 0 ; maxAbsValx ];
 colorsM = [ fwh fwh 1 ; 1 1 1 ;  1 fwh fwh ];
 colorM = colormap_colors(zcolorM,colorsM);
 
% for ipl = 1:n41 % nt
  % i = i41(ipl);
  irow = floor((ipl-1)/ncol) + 1;
  icol = ipl - (irow-1)*ncol;
  
  BL2D = squeeze(BL2Da(:,:,ipl)); BM2D = squeeze(BM2Da(:,:,ipl)); BN2D = squeeze(BN2Da(:,:,ipl)); 
  if( iLocalBM==1 )
    Bvar3 = BM2D-B0fit(i,2);
  else
    Bvar3 = BM2D;
  end
  
  BLN2D = sqrt( BL2D.^2 + BN2D.^2 );
  csN = cumsum( BLN2D , 1 );
  csL = cumsum( csN(end,:) );
  csL = csL/csL(end);
  for ii = 1:nL
    csN(:,ii) = csN(:,ii)/csN(end,ii);
  end
  nsl = 131;
  Lsl = zeros(nsl,1);
  Nsl = zeros(nsl,1);
  if( irandsl511==1 )
    if( irow==1 && ipl==1 )
      randa = rand(nsl,2);
    end
    for isl = 1:nsl
      ri = 1 + randa(isl,1)*(nL-1);
      ii = floor(ri);
      ip = 1 + ii;
      fip = ri - ii;
      fii = 1 - fip;
      Lsl(isl) = fii*La(ii) + fip*La(ip);
      csN1 = 0.5*( fii*csN(:,ii) + fip*csN(:,ip) );
      rj = 1 + randa(isl,2)*(nL-1);
      jj = floor(rj);
      jp = 1 + jj;
      fjp = rj - jj;
      fjj = 1 - fjp;
      Nsl(isl) = fjj*La(jj) + fjp*La(jp);
    end
  else
    Llen = 2*Lmax;
    dLlen = Llen/nsl;
    for isl = 1:nsl
      Lsl(isl) = -Lmax + dLlen/2 + (isl-1)*dLlen;
      Nsl(isl) = -Lmax + nrev(isl,2)*Llen;
    end      
  end
% end

result.L2D = L2D;
result.N2D = N2D;
result.BL2D = BL2D;
result.BN2D = BN2D;
result.Lsl = Lsl;
result.Nsl = Nsl;
result.t = setup.t(i);

end % end function