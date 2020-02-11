function [ yf,wf ] = getUniformX2Xf( x,y,xf )
%Creates averaged distribution yf on a regular grid xf with dxf > dx
%   x,y is the original data set, must be 1D
%   xf is the new x array
%   yf is the new y array
%   wf = weights onto yf grid

  if( ndims(x)>2 || ndims(y)~=ndims(x) || (size(x,1)>1 && size(x,2)>1) || size(x,1)~=size(y,1) || size(x,2)~=size(y,2) )
    error('ndims>2 || (size(x,1)>1 && size(x,2)>1) || size(x,1)~=size(y,1) || size(x,2)~=size(y,2)) in getUniformX2Xf')
  end

  nin = numel(x);
  dxa = x(2:end)-x(1:end-1);
  dxmin = min(dxa);
  dxmax = max(dxa);
  dx = (x(end)-x(1))/(nin-1);
  
  if( dxmax>1.25*dxmin )
    error('dxmax>1.25*dxmin in getUniformX2Xf')
  end
  
  nf = numel(xf);
  dxfa = xf(2:end)-xf(1:end-1);
  dxfmin = min(dxfa);
  dxfmax = max(dxfa);
  dxf = (xf(end)-xf(1))/(nf-1);
  xfmin = xf(1);
    
  if( dxfmax>1.01*dxfmin || dxf<dx )
    error('dxfmax>1.01*dxfmin || dxf<dx in getUniformX2Xf')
  end
  
  % Calculate interpolated distribution
  if( size(xf,1)>1 )
    yf = zeros(nf,1);
    wf = zeros(nf,1);
  else
    yf = zeros(1,nf);
    wf = zeros(1,nf);
  end
  dfjp = dx/dxf;
  fjpUp = 0.5 + dfjp/2;
  fjpDn = 0.5 - dfjp/2;
  for j = 1:nin
    
    rjj = 1 + (x(j)-xfmin)/dxf;
    jj = floor(rjj);
    jp = jj + 1;
    fjp = rjj - jj;   
    
    if( fjp>fjpUp && jp>=1 && jp<=nf )
      wf(jp) = wf(jp) + 1;
      yf(jp) = yf(jp) + y(j);
    elseif( fjp<fjpDn && jj>=1 && jj<=nf )
      wf(jj) = wf(jj) + 1;
      yf(jj) = yf(jj) + y(j);
    elseif( abs(fjp-0.5)<dfjp/2 )
      fjpp = (fjp-fjpDn)/dfjp;
      fjjp = 1 - fjpp;
      if( jj>=1 && jj<=nf )
        wf(jj) = wf(jj) + fjjp;
        yf(jj) = yf(jj) + fjjp*y(j);
      end
      if( jp>=1 && jp<=nf )
        wf(jp) = wf(jp) + fjpp;
        yf(jp) = yf(jp) + fjpp*y(j);
      end       
    end    
    
  end
  
  yf(wf==0) = NaN;
  yf(wf>0) = yf(wf>0)./wf(wf>0);  

end

