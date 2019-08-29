%% Solve problem

if( iTest==1 );
  xvn(1,:,:) = xvn(1,:,:)/10;
end

%%
neq  = 28;
nvar = 28;
iv = (1:28);
nvarm = nvar - 1;
nvarx = 13;
nvart = nvarm + nvarx;

X = zeros(nt,nvart);
Xa = zeros(nt,nvart,nvarx);
Y = NaN(nt,neq);
iconverge = zeros(nt,1);
Yfit = zeros(nt,neq);
Yfita = NaN(nt,neq,nvarx);
w28a = zeros(nt,nvarx);
nit = 1;
if( exist('iNoJConvert','var')==1 && iNoJConvert==1 )
  mu0e3 = 1;
else
  mu0e3=4.*pi*1.e-7*1.e3;
end
itestbreak = 0;
ita = zeros(nt,nvarx);
dev = zeros(nt,1);
deva = zeros(nt,nvarx);
icXnorm = [ 1 2 2 3 1 2 2 3 4 4 4 4 4 1 2 3 ];
denIcX = [ 2 2 2 2 6 6 6 6 2 2 6 1 2 2 2 2 ; 0 0 0 0 0 0 0 0 6 2 2 2 1 0 0 0 ];
mulIcX = zeros(size(denIcX));
mulIcX(denIcX~=0) = 1./denIcX(denIcX~=0);
w28 = zeros(1,nvarx);
xvn_n = reshape( xvn(:,3,:) , [nt,4] );
xvn_l = reshape( xvn(:,1,:) , [nt,4] );
xvn_m = reshape( xvn(:,2,:) , [nt,4] );
xvn_nn = reshape( xvn(:,3,:).^2 / 2 , [nt,4] );
xvn_ll = reshape( xvn(:,1,:).^2 / 2 , [nt,4] );
xvn_mm = reshape( xvn(:,2,:).^2 / 2 , [nt,4] );
xvn_nl = reshape( xvn(:,3,:).*xvn(:,1,:) , [nt,4] );
xvn_nm = reshape( xvn(:,3,:).*xvn(:,2,:) , [nt,4] );
xvn_lm = reshape( xvn(:,1,:).*xvn(:,2,:) , [nt,4] );
xvn_nnn = reshape( xvn(:,3,:).^3 / 6 , [nt,4] );
xvn_lll = reshape( xvn(:,1,:).^3 / 6 , [nt,4] );
xvn_nnl = reshape( xvn(:,3,:).^2.*xvn(:,1,:) / 2 , [nt,4] );
xvn_nnm = reshape( xvn(:,3,:).^2.*xvn(:,2,:) / 2 , [nt,4] );
xvn_lln = reshape( xvn(:,1,:).^2.*xvn(:,3,:) / 2 , [nt,4] );
xvn_llm = reshape( xvn(:,1,:).^2.*xvn(:,2,:) / 2 , [nt,4] );
xvn_nlm = reshape( xvn(:,3,:).*xvn(:,1,:).*xvn(:,2,:) , [nt,4] );

for i = 1:nt
  
  % Get norm Bs
  bnormX28 = zeros(1,4);
  for ic = 1:3
    bnormX28(ic) = max( maxAll(bvn(i,ic,:)) - minAll(bvn(i,ic,:)) , bnorm0 );
  end
  bnormX28(4) = min( bnormX28(1) , bnormX28(3) );
  
  for icX = 1:nvarx
    
    
    for it = 1:nit %
      
      X1 = zeros(nvar,1);
      Y1 = zeros(neq,1);
      A1 = zeros(neq,nvar);
      
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
      
      
      % Define A1
      for k = 1:4
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
          Y1(kB) = bvn(i,ic,k);
        end % ic
        switch icX
          case 1
            A1(  k,28) = xvn_nnm(i,k);
          case 2
            A1(4+k,28) = xvn_nnl(i,k);
          case 3
            A1(4+k,28) = xvn_lln(i,k);
          case 4
            A1(8+k,28) = xvn_llm(i,k);
          case 5
            A1(  k,28) = xvn_nnn(i,k);
          case 6
            A1(4+k,28) = xvn_nnn(i,k);
          case 7
            A1(4+k,28) = xvn_lll(i,k);
          case 8
            A1(8+k,28) = xvn_lll(i,k);
          case 9
            A1(  k,28) =  xvn_nnl(i,k);
            A1(8+k,28) = -xvn_nnn(i,k);
          case 10
            A1(  k,28) =  xvn_lln(i,k);
            A1(8+k,28) = -xvn_nnl(i,k);
          case 11
            A1(  k,28) =  xvn_lll(i,k);
            A1(8+k,28) = -xvn_lln(i,k);
          case 12
            A1(  k,28) =  xvn_nlm(i,k);
            A1(8+k,28) = -xvn_nnm(i,k);
          case 13
            A1(  k,28) =  xvn_llm(i,k);
            A1(8+k,28) = -xvn_nlm(i,k);
        end
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
        switch icX
          case 1
            A1(16+k,28) =  xvn_nm(i,k);
            A1(20+k,28) = -xvn_nn(i,k);
          case 2
            A1(12+k,28) = -xvn_nl(i,k);
            A1(20+k,28) =  xvn_nn(i,k);
          case 3
            A1(12+k,28) = -xvn_ll(i,k);
            A1(20+k,28) =  xvn_nl(i,k);
          case 4
            A1(12+k,28) =  xvn_ll(i,k);
            A1(16+k,28) = -xvn_lm(i,k);
          case 5
            A1(16+k,28) =  xvn_nn(i,k);
          case 6
            A1(12+k,28) = -xvn_nn(i,k);
          case 7
            A1(20+k,28) =  xvn_ll(i,k);
          case 8
            A1(16+k,28) = -xvn_ll(i,k);
          case 9
            A1(16+k,28) =  xvn_nl(i,k);
          case 10
            A1(16+k,28) =  xvn_ll(i,k) + xvn_nn(i,k);
          case 11
            A1(16+k,28) =  xvn_nl(i,k);
          case 12
            A1(12+k,28) = -xvn_nn(i,k);
            A1(16+k,28) =  xvn_lm(i,k);
            A1(20+k,28) = -xvn_nl(i,k);
          case 13
            A1(12+k,28) = -xvn_nl(i,k);
            A1(16+k,28) =  xvn_nm(i,k);
            A1(20+k,28) = -xvn_ll(i,k);
          case 14
            A1(20+k,28) = -xvn_m(i,k);
            % case 15
            % 0
          case 16
            A1(12+k,28) =  xvn_m(i,k);
        end
      end % k
      
      % Div-B,constant
      A1(25, 3) = 1; A1(25,13) = 1; A1(25,20) = 1; % Y1(25) = 0;
      % Div-B,L
      A1(26, 6) = 1; A1(26,18) = 1; A1(26,25) = 1; % Y1(26) = 0;
      % Div-B,M
      A1(27, 9) = 1; A1(27,26) = 1; % Y1(27) = 0;
      if( icX==15 ), A1(27,28) = 1; end
      % Div-B,N
      A1(28, 7) = 1; A1(28,17) = 1; A1(28,23) = 1; % Y1(28) = 0;
      
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
        
        if( icX~=15 )
          XT = [ 1 2 3 4 5 6 7 8 9 ...
            10 11 12 13 14 15 16 17 18  ...
            19 -16 21 22 -24 24 -24 -9 27 ...
            28 ]';
        else
          XT = [ 1 2 3 4 5 6 7 8 9 ...
            10 11 12 13 14 15 16 17 18  ...
            19 -16 21 22 -24 24 -24 26 27 ...
            -35 ]';
        end
        
        % B_s,L
        j0 = 0;
        Y1(1:4) = XT(j0+1) + XT(j0+2)*xvn(1,3,:) + XT(j0+3)*xvn(1,1,:) + XT(j0+4)*xvn(1,2,:) ...
          + XT(j0+5)*xvn(1,3,:).^2/2 + XT(j0+6)*xvn(1,1,:).^2/2 ...
          + XT(j0+7)*xvn(1,3,:).*xvn(1,1,:) + XT(j0+8)*xvn(1,3,:).*xvn(1,2,:) + XT(j0+9)*xvn(1,1,:).*xvn(1,2,:);
        % B_s,M
        j0 = 9;
        Y1(5:8) = XT(j0+1) + XT(j0+2)*xvn(1,3,:) + XT(j0+3)*xvn(1,1,:) + XT(j0+4)*xvn(1,2,:) ...
          + XT(j0+5)*xvn(1,3,:).^2/2 + XT(j0+6)*xvn(1,1,:).^2/2 ...
          + XT(j0+7)*xvn(1,3,:).*xvn(1,1,:) + XT(j0+8)*xvn(1,3,:).*xvn(1,2,:) + XT(j0+9)*xvn(1,1,:).*xvn(1,2,:);
        % B_s,N
        j0 = 18;
        Y1(9:12) = XT(j0+1) + XT(j0+2)*xvn(1,3,:) + XT(j0+3)*xvn(1,1,:) + XT(j0+4)*xvn(1,2,:) ...
          + XT(j0+5)*xvn(1,3,:).^2/2 + XT(j0+6)*xvn(1,1,:).^2/2 ...
          + XT(j0+7)*xvn(1,3,:).*xvn(1,1,:) + XT(j0+8)*xvn(1,3,:).*xvn(1,2,:) + XT(j0+9)*xvn(1,1,:).*xvn(1,2,:);
        switch icX
          case 1
            Y1(1:4 ) = Y1(1:4 ) + reshape( XT(28)*xvn_nnm(i,:) , [4,1] );
          case 2
            Y1(5:8 ) = Y1(5:8 ) + reshape( XT(28)*xvn_nnl(i,:) , [4,1] );
          case 3
            Y1(5:8 ) = Y1(5:8 ) + reshape( XT(28)*xvn_lln(i,:) , [4,1] );
          case 4
            Y1(9:12) = Y1(9:12) + reshape( XT(28)*xvn_llm(i,:) , [4,1] );
          case 5
            Y1(1:4 ) = Y1(1:4 ) + reshape( XT(28)*xvn_nnn(i,:) , [4,1] );
          case 6
            Y1(5:8 ) = Y1(5:8 ) + reshape( XT(28)*xvn_nnn(i,:) , [4,1] );
          case 7
            Y1(5:8 ) = Y1(5:8 ) + reshape( XT(28)*xvn_lll(i,:) , [4,1] );
          case 8
            Y1(9:12) = Y1(9:12) + reshape( XT(28)*xvn_lll(i,:) , [4,1] );
          case 9
            Y1(1:4 ) = Y1(1:4 ) + reshape( XT(28)*xvn_nnl(i,:) , [4,1] );
            Y1(9:12) = Y1(9:12) - reshape( XT(28)*xvn_nnn(i,:) , [4,1] );
          case 10
            Y1(1:4 ) = Y1(1:4 ) + reshape( XT(28)*xvn_lln(i,:) , [4,1] );
            Y1(9:12) = Y1(9:12) - reshape( XT(28)*xvn_nnl(i,:) , [4,1] );
          case 11
            Y1(1:4 ) = Y1(1:4 ) + reshape( XT(28)*xvn_lll(i,:) , [4,1] );
            Y1(9:12) = Y1(9:12) - reshape( XT(28)*xvn_lln(i,:) , [4,1] );
          case 12
            Y1(1:4 ) = Y1(1:4 ) + reshape( XT(28)*xvn_nlm(i,:) , [4,1] );
            Y1(9:12) = Y1(9:12) - reshape( XT(28)*xvn_nnm(i,:) , [4,1] );
          case 13
            Y1(1:4 ) = Y1(1:4 ) + reshape( XT(28)*xvn_llm(i,:) , [4,1] );
            Y1(9:12) = Y1(9:12) - reshape( XT(28)*xvn_nlm(i,:) , [4,1] );
          case 14
            Y1(1:4 ) = Y1(1:4 ) + reshape( XT(28)*xvn_mm(i,:) , [4,1] );
          case 15
            Y1(5:8 ) = Y1(5:8 ) + reshape( XT(28)*xvn_mm(i,:) , [4,1] );
          case 16
            Y1(9:12) = Y1(9:12) + reshape( XT(28)*xvn_mm(i,:) , [4,1] );
        end
        % J_s,L
        Y1(13:16) = XT(22) + XT(26)*xvn(1,3,:) + XT(27)*xvn(1,1,:) ...
          -XT(11) - XT(14)*xvn(1,3,:) - XT(16)*xvn(1,1,:) - XT(17)*xvn(1,2,:);
        % J_s,M
        Y1(17:20) = XT( 2) + XT( 5)*xvn(1,3,:) + XT( 7)*xvn(1,1,:) + XT( 8)*xvn(1,2,:) ...
          -XT(21) - XT(25)*xvn(1,3,:) - XT(24)*xvn(1,1,:) - XT(27)*xvn(1,2,:);
        % J_s,N
        Y1(21:24) = XT(12) + XT(16)*xvn(1,3,:) + XT(15)*xvn(1,1,:) + XT(18)*xvn(1,2,:) ...
          -XT( 4) - XT( 8)*xvn(1,3,:) - XT( 9)*xvn(1,1,:);
        switch icX
          case 1
            Y1(17:20) = Y1(17:20) + reshape( XT(28)*xvn_nm(i,:) , [4,1] );
            Y1(21:24) = Y1(21:24) - reshape( XT(28)*xvn_nn(i,:) , [4,1] );
          case 2
            Y1(13:16) = Y1(13:16) - reshape( XT(28)*xvn_nl(i,:) , [4,1] );
            Y1(21:24) = Y1(21:24) + reshape( XT(28)*xvn_nn(i,:) , [4,1] );
          case 3
            Y1(13:16) = Y1(13:16) - reshape( XT(28)*xvn_ll(i,:) , [4,1] );
            Y1(21:24) = Y1(21:24) + reshape( XT(28)*xvn_nl(i,:) , [4,1] );
          case 4
            Y1(13:16) = Y1(13:16) + reshape( XT(28)*xvn_ll(i,:) , [4,1] );
            Y1(17:20) = Y1(17:20) - reshape( XT(28)*xvn_lm(i,:) , [4,1] );
          case 5
            Y1(17:20) = Y1(17:20) + reshape( XT(28)*xvn_nn(i,:) , [4,1] );
          case 6
            Y1(13:16) = Y1(13:16) - reshape( XT(28)*xvn_nn(i,:) , [4,1] );
          case 7
            Y1(21:24) = Y1(21:24) + reshape( XT(28)*xvn_ll(i,:) , [4,1] );
          case 8
            Y1(17:20) = Y1(17:20) - reshape( XT(28)*xvn_ll(i,:) , [4,1] );
          case 9
            Y1(17:20) = Y1(17:20) + reshape( XT(28)*xvn_nl(i,:) , [4,1] );
          case 10
            Y1(17:20) = Y1(17:20) + reshape( XT(28)*( xvn_ll(i,:) + xvn_nn(i,:) ) , [4,1] );
          case 11
            Y1(17:20) = Y1(17:20) + reshape( XT(28)*xvn_nl(i,:) , [4,1] );
          case 12
            Y1(13:16) = Y1(13:16) - reshape( XT(28)*xvn_nn(i,:) , [4,1] );
            Y1(17:20) = Y1(17:20) + reshape( XT(28)*xvn_lm(i,:) , [4,1] );
            Y1(21:24) = Y1(21:24) - reshape( XT(28)*xvn_nl(i,:) , [4,1] );
          case 13
            Y1(13:16) = Y1(13:16) - reshape( XT(28)*xvn_nl(i,:) , [4,1] );
            Y1(17:20) = Y1(17:20) + reshape( XT(28)*xvn_nm(i,:) , [4,1] );
            Y1(21:24) = Y1(21:24) - reshape( XT(28)*xvn_ll(i,:) , [4,1] );
          case 14
            Y1(21:24) = Y1(21:24) - reshape( XT(28)*xvn_m(i,:) , [4,1] );
            % case 15
            % 0
          case 16
            Y1(13:16) = Y1(13:16) + reshape( XT(28)*xvn_m(i,:) , [4,1] );
        end
        % Div-B = 0
        Y1(25) = 0;
        Y1(26) = 0;
        Y1(27) = 0;
        Y1(28) = 0;
        
        [~,idxli]=licols(A1);
        
      end
      
      %     [~,idxli]=licols(A1);
      
      % Solve equations
      X1 = A1\Y1;
      
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
    
    if( icX==1 ), Y(i,:) = Y1'; end
    Xa(i,1:27,icX) = X1(1:27)'; Xa(i,27+icX,icX) = X1(28);
    Yfita(i,:,icX) = ( A1*X1 )';
    deva(i,icX) = sqrt(mean( (Y(i,:)-Yfita(i,:,icX)).^2 ))/norm(bavv(i,:));
    ita(i,icX) = it - 1;
    if( i28termRaw==1 )
      w28(icX) =  1 / abs(X1(28));
    else
      if( icXnorm(icX)<=3 )
        w28(icX) = bnormX28(icXnorm(icX)) / ( abs(X1(28))*mulIcX(1,icX) );
      else
        w28l = bnormX28(1) / ( abs(X1(28))*mulIcX(1,icX) );
        w28n = bnormX28(3) / ( abs(X1(28))*mulIcX(2,icX) );
        w28(icX) = min(w28l,w28n);
      end
    end
    
  end % icX
  
  if( itestbreak == 1 ), error('That''s all for test'); end;
  
  w28max = max(w28);
  i28ok = find(w28>=w28max/3); % For test: find(w28==w28max); ****** WANT find(w28>=w28max/3);
  w28sum = sum(w28(i28ok));
  n28ok = numel(i28ok);
  w28(i28ok) = w28(i28ok)/w28sum;
  for ii28 = 1:n28ok
    i28 = i28ok(ii28);
    X(i,:) = X(i,:) + w28(i28) * Xa(i,:,i28);
    Yfit(i,:) = Yfit(i,:) + w28(i28) * Yfita(i,:,i28);
  end
  w28a(i,i28ok) = w28(i28ok);
  
end % i

%%

Bfitloc1 = Yfit(:,1:12);
Bfitloc2 = reshape(Bfitloc1,[nt,4,3]);
Bfitloc = permute(Bfitloc2,[1,3,2]);
B0fitloc = [X(:,iv(1)) X(:,iv(10)) X(:,iv(19))];
Jpfitloc1 = Yfit(:,13:24);
Jpfitloc2 = reshape(Jpfitloc1,[nt,4,3]);
Jpfitloc3 = permute(Jpfitloc2,[1,3,2]);
Jpfitloc  = Jpfitloc3; %/mu0e3;
% Jp0fitloc1 = squeeze(mean(Jpfitloc,3)); % matches with formula below
Jp0fitloc = [ X(:,22)-X(:,11) X(:,2)-X(:,21) X(:,12)-X(:,4) ]; % /mu0e3;
Jpvav3 = Jpvav2*mu0e3;
Jpv3 = Jpv2*mu0e3;

% Transform back to fixed coordinates
Bfit = zeros(nt,3,4);
B0fit = zeros(nt,3);
Jpfit = zeros(nt,3,4);
Jp0fit = zeros(nt,3);
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