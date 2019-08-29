%% iPlot30

if( iPlot30>0 )
  figure(30)
  clf;
  set(gcf,'Color','w');
  set(gcf,'Position',[500,200,750,520]);
  xsc1 = 0.13; xsc2 = 0.87; ysc1 = 0.13; ysc2 = .96; hgap = .01; vgap = .02;
  ticklen = [0.04 0.02];
  fxlab = .15; fylab = .8;
  casc = [ 0 0 0 ; 1 0 0 ; 0 .8 0 ; .3 .3 1 ];
  
 wid1 = 1; wid2 = 1.5; wid3 = 2; fs1 = 9; fs2 = 12;
  
  if( iNormD == 1 )
    mingrads = (.1)^2;
  else
    mingrads = (.1/dsc)^2;
  end
    
    my_subplotrc4(4,2,1,1,xsc1,xsc2,ysc1,ysc2, hgap, vgap);
    semilogy(t,lambda(:,1)/mingrads,'Color',casc(4,:),'Linewidth',wid1);
    hold on
    semilogy(t,lambda(:,2)/mingrads,'Color',casc(3,:),'Linewidth',wid1);
    semilogy(t,lambda(:,3)/mingrads,'Color',casc(2,:),'Linewidth',wid1);
    semilogy([t(1),t(end)],[1 1],'k:','Linewidth',wid2);
    ylim([1.e-3 max(lambda(:,3))/mingrads]);   
    hold off
    xlim([t(1) t(end)]);
    set(gca,'XTickLabel','');
    set(gca,'YTick',[1.e-8 1.e-7 1.e-6 1.e-5 1.e-4 1.e-3 .01 .1 1 10 100 1000 10000 1.e5 1.e6 1.e7]);
%     if( iNormFlds==1 )
      ylabel({'\lambda_{MDDB}' '(0.1 nT/L_{sc})^2'},'Fontsize',fs2);
%     else
%       ylabel({'\lambda_{MDDB}' '(nT/km)^2'},'Fontsize',fs2);
%     end
    title('MDDB')
    
    hax = my_subplotrc4(4,2, 1, 2, xsc1,xsc2,ysc1,ysc2, hgap, vgap);
    h1 = plot(t,bavv(:,1),'Color',casc(4,:),'Linewidth',wid1);
    set(gca,'yaxislocation','right');
    xlim([t(1) t(end)])
    hold on
    h2 = plot(t,bavv(:,2),'Color',casc(3,:),'Linewidth',wid1);
    h3 = plot(t,bavv(:,3),'Color',casc(2,:),'Linewidth',wid1);
    plot([t(1),t(end)],[0 0],'k:','Linewidth',wid2);
    hold off
    set(gca,'Fontsize',11);
    set(gca,'TickLength',ticklen);
    set(gca,'XMinorTick','on');
    set(gca,'YMinorTick','on');
    if( iRotate>0 )
      ylabel({'{\bfB}_{av} LMN' '(nT)'},'Fontsize',fs2);
    else
      ylabel({'{\bfB}_{av} GSE' '(nT)'},'Fontsize',fs2);
    end
    set(gca,'XTickLabel','')
     title('MGAB')
    
%     set(hxl, 'Units', 'Normalized', 'Position', [0.5, -.33, 0])
      
    
    sYLaba = { '{\bfe}_{l}' '{\bfe}_{m}' '{\bfe}_{n}' };
    for iV = 1:2
    for ic = 1:3
      hax = my_subplotrc4(4,2,ic+1,iV,xsc1,xsc2,ysc1,ysc2, hgap, vgap);
      plot(t,mvcalc(:,1,ic,iV),'Color',casc(4,:),'Linewidth',wid1);
      if( iV==2 )
        set(gca,'yaxislocation','right');
      end
      hold on
      plot(t,mvcalc(:,2,ic,iV),'Color',casc(3,:),'Linewidth',wid1);
      plot(t,mvcalc(:,3,ic,iV),'Color',casc(2,:),'Linewidth',wid1);
      plot([t(1),t(end)],[0 0],'k:','Linewidth',wid2);
%       if( iV==1 )
        ylim([-1 1]);
%       end
      hold off
      xlim([t(1) t(end)]);
      if( iRotate>0 )
        ylabel({sYLaba{ic} 'LMN'},'Fontsize',fs2);
      else
        ylabel({sYLaba{ic} 'GSE'},'Fontsize',fs2);
      end
      if( ic==3 )
        hxl = xlabel(['t(s) after ' sTime ' UT'],'Fontsize',fs2);
      else
        set(gca,'XTickLabel','')
      end
      set(gca,'Fontsize',11);
    end
    end
    
   if( iPlot30==2 ), export_fig([sDirPlots 'Poly_MddMg_BscOut' num2str(iScOutIn) '_Brs' num2str(iBurst) '_Smo' num2str(nsmoothspan) '_Sub' num2str(iSubAvB) '_Rot' num2str(iRotate) '_noXRot' num2str(iNoXRotation) '_iSys' num2str(iSystem) '_iIncmprs' num2str(iIncmprs) '_iexctB' num2str(iExactB) '_iNF' num2str(iNormFlds) '_' num2str(wFlds(1)) '-' num2str(wFlds(2)) '-' num2str(wFlds(3)) '-' num2str(wFlds(4)) '-' num2str(wFlds(5)) '-' num2str(wFlds(6)) '_wB' num2str(wMag) '_iAltNe' num2str(iAltNe) '_t' num2str(tlo,3) '-' num2str(thi,3)  '.pdf '],'-pdf'); end


end % iPlot30


%% iPlot31

if( iPlot31>0 )
  figure(31)
  clf;
  set(gcf,'Color','w');
  set(gcf,'Position',[500,100,470,400]);
  xsc1 = 0.2; xsc2 = 0.98; ysc1 = 0.13; ysc2 = .97;
  ticklen = [0.02 0.01];
  fxlab = .15; fylab = .8;
  casc = [ 0 0 0 ; 1 0 0 ; 0 .8 0 ; .3 .3 1 ];
  
 wid1 = 1; wid2 = 1.5; wid3 = 2; fs1 = 9; fs2 = 12;
  
  if( iNormD == 1 )
    mingrads = (.1)^2/Bnorms;
  else
    mingrads = (.1/dsc)^2;
  end
    
    my_subplotrc3(5,1,1,1,xsc1,xsc2,ysc1,ysc2);
    semilogy(t,lambda(:,1),'Color',casc(4,:),'Linewidth',wid1);
    hold on
    semilogy(t,lambda(:,2),'Color',casc(3,:),'Linewidth',wid1);
    semilogy(t,lambda(:,3),'Color',casc(2,:),'Linewidth',wid1);
    semilogy([t(1),t(end)],[mingrads mingrads],'k:','Linewidth',wid2);
    if( iNormFlds==1 ), ylim([1.e-6 1.]); else, ylim([1.e-3 100.]); end   
    hold off
    xlim([t(1) t(end)]);
    set(gca,'Fontsize',11);
    set(gca,'TickLength',ticklen);
    set(gca,'XMinorTick','on');
    set(gca,'YMinorTick','on');
        set(gca,'XTickLabel','');
    set(gca,'YTick',[1.e-8 1.e-7 1.e-6 1.e-5 1.e-4 1.e-3 .01 .1 1 10 100 1000 10000]);
    if( iNormFlds==1 )
      ylabel({'\lambda_{MDDB}' '(B_0/L_{sc})^2'},'Fontsize',fs2);
    else
      ylabel({'\lambda_{MDDB}' '(nT/km)^2'},'Fontsize',fs2);
    end
      
    
    sYLaba = { '{\bfe}_{l}' '{\bfe}_{m}' '{\bfe}_{n}' };
    for ic = 1:3
      my_subplotrc3(5,1,ic+1,1,xsc1,xsc2,ysc1,ysc2);
      plot(t,mvcalc(:,1,ic,1),'Color',casc(4,:),'Linewidth',wid1);
      hold on
      plot(t,mvcalc(:,2,ic,1),'Color',casc(3,:),'Linewidth',wid1);
      plot(t,mvcalc(:,3,ic,1),'Color',casc(2,:),'Linewidth',wid1);
      plot([t(1),t(end)],[0 0],'k:','Linewidth',wid2);
      ylim([-1 1]);
      hold off
      xlim([t(1) t(end)]);
      set(gca,'Fontsize',11);
      set(gca,'TickLength',ticklen);
      set(gca,'XMinorTick','on');
      set(gca,'YMinorTick','on');
      if( iRotate>0 )
        ylabel({sYLaba{ic} 'LMN'},'Fontsize',fs2);
      else
        ylabel({sYLaba{ic} 'GSE'},'Fontsize',fs2);
      end
      set(gca,'XTickLabel','')
    end
    
    hax = my_subplotrc3(5,1, 5, 1, xsc1,xsc2,ysc1,ysc2);
    h1 = plot(t,bavv(:,1),'Color',casc(4,:),'Linewidth',wid1);
    hold on
    h2 = plot(t,bavv(:,2),'Color',casc(3,:),'Linewidth',wid1);
    h3 = plot(t,bavv(:,3),'Color',casc(2,:),'Linewidth',wid1);
    plot([t(1),t(end)],[0 0],'k:','Linewidth',wid2);
    hold off
    xlim([t(1) t(end)]);
    set(gca,'Fontsize',11);
    set(gca,'TickLength',ticklen);
    set(gca,'XMinorTick','on');
    set(gca,'YMinorTick','on');
    if( iRotate>0 )
      ylabel({'{\bfB}_{av} LMN' '(nT)'},'Fontsize',fs2);
    else
      ylabel({'{\bfB}_{av} GSE' '(nT)'},'Fontsize',fs2);
    end
    hxl = xlabel(['t(s) after ' sTime ' UT']);
%     set(hxl, 'Units', 'Normalized', 'Position', [0.5, -.33, 0])

if( iPlot31==2 ), export_fig([sDirPlots 'Poly_MDD_BscOut' num2str(iScOutIn) '_Brs' num2str(iBurst) '_Smo' num2str(nsmoothspan) '_Sub' num2str(iSubAvB) '_Rot' num2str(iRotate) '_noXRot' num2str(iNoXRotation) '_iSys' num2str(iSystem) '_iIncmprs' num2str(iIncmprs) '_iexctB' num2str(iExactB) '_iNF' num2str(iNormFlds) '_' num2str(wFlds(1)) '-' num2str(wFlds(2)) '-' num2str(wFlds(3)) '-' num2str(wFlds(4)) '-' num2str(wFlds(5)) '-' num2str(wFlds(6)) '_wB' num2str(wMag) '_iAltNe' num2str(iAltNe) '_t' num2str(tlo,3) '-' num2str(thi,3)  '.pdf '],'-pdf'); end


end % iPlot31

%%
if( iPlot33>0 )
  figure(33)
  clf;
  set(gcf,'Color','w');
  set(gcf,'Position',[50,50,600,950]);
  xsc1 = 0.14; xsc2 = 0.98; ysc1 = 0.08; ysc2 = 1; blue = [0.4,.4,1]; wid1 = 1; wid2 = 1.5; wid3 = 3; ticklen = [0.02 0.01];
  ms = 10;
  vgap = 0.015;
  nrow = 7;
  fxlab = .04; fylab = .8;
  sLab = { '(a)' '(b)' '(c)' '(d)' '(e)' '(f)' '(g)' };
  if( iNormD==1 )
    if( iRotate>0 )
      sYLab = { '$\frac{n_{e{\rm ,used}}}{n_{e{\rm ,measured}}}$' 'B_L (nT)' 'B_M GSE (nT)' 'B_N GSE (nT)' 'J_L GSE (nT/L_{sc})' 'J_M GSE (nT/L_{sc})' 'J_N GSE (nT/L_{sc})' };
    else
      sYLab = { '$\frac{n_{e{\rm ,used}}}{n_{e{\rm ,measured}}}$' 'B_X GSE (nT)' 'B_Y GSE (nT)' 'B_Z GSE (nT)' 'J_X GSE (nT/L_{sc})' 'J_Y GSE (nT/L_{sc})' 'J_Z GSE (nT/L_{sc})' };
    end
  else
    if( iRotate>0 )
      sYLab = { '$\frac{n_{e{\rm ,used}}}{n_{e{\rm ,measured}}}$' 'B_L GSE (nT)' 'B_M GSE (nT)' 'B_N GSE (nT)' 'J_L GSE (mA/m^2)' 'J_M GSE (mA/m^2)' 'J_N GSE (mA/m^2)' };
    else
      sYLab = { '$\frac{n_{e{\rm ,used}}}{n_{e{\rm ,measured}}}$' 'B_X GSE (nT)' 'B_Y GSE (nT)' 'B_Z GSE (nT)' 'J_X GSE (mA/m^2)' 'J_Y GSE (mA/m^2)' 'J_Z GSE (mA/m^2)' };
    end
  end
  sXLab = ['t(s) after ' sTime ' UT'];
  ca = [ 0 0 0 ; .8 0 0 ; 0 .75 0 ; .4 .4 1 ; .85 .65 .125 ; .85 .65 .125 ; 0 0 0 ; .8 0 0 ; 0 .75 0 ; .4 .4 1 ];
  wida = [ wid1 wid1 wid1 wid1 wid3 wid3 wid2 wid2 wid2 wid2 ];
  slnsty = { '-' '-' '-' '-' ':' '-' ':' ':' ':' ':' };
  
  hax = my_subplotrc4(nrow,1, 1, 1, xsc1,xsc2,ysc1,ysc2,0,vgap );
  plot(t(iselne),fnepos(iselne),'k','LineWidth',wid2);
  set(gca,'TickLength',ticklen);
  set(gca,'XMinorTick','on');
  set(gca,'YMinorTick','on');
  ylabel(sYLab{1},'FontSize',24,'Interpreter','LaTeX');
  set(gca,'XTickLabel','');
  if( itscreen==1 ); xlim([tlo thi]); end
  textNormFig( gca, fxlab, fylab, sLab{1}, 12 );
  
  for ifld = 1:2
    for ic = 1:3
      if( ifld==1 )
        a = [ squeeze(Bfit(:,ic,:)) bavv(:,ic) B0fit(:,ic) squeeze(bv(:,ic,:)) ];
        nl = 10;
        amin1 = minAll(bv(:,ic,:)); amax1 = maxAll(bv(:,ic,:));  
      else
        a = [ squeeze(Jpfit(:,ic,:)) Jpvav3(:,ic) Jp0fit(:,ic) squeeze(Jpv3(:,ic,:)) ];
        nl = 10;
        amin1 = minAll(Jpv3(:,ic,:)); amax1 = maxAll(Jpv3(:,ic,:)); 
      end
      amin2 = minAll(a); amax2 = maxAll(a); arange1 = amax1 - amin1; amin3 = amin1-arange1/2; amax3 = amax1+arange1/2;
      amin = max( amin2 , amin3 ); amax = min( amax2 , amax3 );
      irow = (ifld-1)*3 + ic + 1;
      hax = my_subplotrc4(nrow,1, irow, 1, xsc1,xsc2,ysc1,ysc2,0,vgap );
      for il = 1:nl
        plot(t(iselne),a(iselne,il),slnsty{il},'Color',ca(il,:),'LineWidth',wida(il));
        if( il==1 ), hold on; end
      end
      ylim([amin , amax])
      ylim1 = get(gca,'YLim');
      if( ylim1(1)<0 && ylim1(2)>0 )
        plot([t(iselne(1)) t(iselne(end))],[0 0],':','Color',gray);
      end
      hold off
      set(gca,'TickLength',ticklen);
      set(gca,'XMinorTick','on');
      set(gca,'YMinorTick','on');
      ylabel(sYLab{irow},'FontSize',12);
      if( irow==nrow )
        xlabel(sXLab,'FontSize',12);
      else
        set(gca,'XTickLabel','');
      end
      if( itscreen==1 ); xlim([tlo thi]); end
      textNormFig( gca, fxlab, fylab, sLab{irow}, 12 );
    end % ic
  end % ifld
  if( iPlot33==2 ), export_fig([sDirPlots 'Poly_BJ_BscOut' num2str(iScOutIn) '_Brs' num2str(iBurst) '_Smo' num2str(nsmoothspan) '_Sub' num2str(iSubAvB) '_Rot' num2str(iRotate) '_noXRot' num2str(iNoXRotation) '_iSys' num2str(iSystem) '_iIncmprs' num2str(iIncmprs) '_iexctB' num2str(iExactB) '_iNF' num2str(iNormFlds) '_' num2str(wFlds(1)) '-' num2str(wFlds(2)) '-' num2str(wFlds(3)) '-' num2str(wFlds(4)) '-' num2str(wFlds(5)) '-' num2str(wFlds(6)) '_wB' num2str(wMag) '_iAltNe' num2str(iAltNe) '_t' num2str(tlo,3) '-' num2str(thi,3)  '.pdf '],'-pdf'); end
end % iPlot33

%%
if( iPlot34>0 )
  
  sLabRow = { 'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' };
  sLabCol = { 'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' };
  
  if( iSystem<3 || iSystem==8 || iSystem>=10 )
    figure(34)
    clf;
    set(gcf,'Color','w');
    
    if( iSystem==1 )
      set(gcf,'Position',[500,300,600,700]);
      nrow = 6;
      iv = [ (1:4) 0 0 (5:10) (11:13) 0 14 0 ]';
      if( iNormD==1 )
        sYLab = { {'B_{i,0}' '(nT)'} {'\partialB_i/\partialn' '(nT/L_{sc})'} {'\partialB_i/\partiall' '(nT/L_{sc})'} ...
          {'\partial^2B_i/\partialn^2' '(nT/L_{sc}^2)'} {'\partial^2B_i/\partiall^2' '(nT/L_{sc}^2)'} ...
          {'\partial^2B_i/\partialn\partiall' '(nT/L_{sc}^2)'} };
      else
        sYLab = { {'B_{i,0}' '(nT)'} {'\partialB_i/\partialn' '(nT/km)'} {'\partialB_i/\partiall' '(nT/km)'} ...
          {'\partial^2B_i/\partialn^2' '(nT/km^2)'} {'\partial^2B_i/\partiall^2' '(nT/km^2)'} ...
          {'\partial^2B_i/\partialn\partiall' '(nT/km^2)'} };
      end
    elseif( iSystem==2 )
      set(gcf,'Position',[500,300,500,660]);
      nrow = 7;
      iv = [ (1:5) 0 0 (6:12) (13:16) 0 17 0 ]';
      if( iNormD==1 )
        sYLab = { {'B_{i,0}' '(nT)'} {'\partialB_i/\partialn' '(nT/L_{sc})'} {'\partialB_i/\partiall' '(nT/L_{sc})'} {'\partialB_i/\partialm' '(nT/L_{sc})'} ...
          {'\partial^2B_i/\partialn^2' '(nT/L_{sc}^2)'} {'\partial^2B_i/\partiall^2' '(nT/L_{sc}^2)'} ...
          {'\partial^2B_i/\partialn\partiall' '(nT/L_{sc}^2)'} };
      else
        sYLab = { {'B_{i,0}' '(nT)'} {'\partialB_i/\partialn' '(nT/km)'} {'\partialB_i/\partiall' '(nT/km)'} {'\partialB_i/\partialm' '(nT/km)'} ...
          {'\partial^2B_i/\partialn^2' '(nT/km^2)'} {'\partial^2B_i/\partiall^2' '(nT/km^2)'} ...
          {'\partial^2B_i/\partialn\partiall' '(nT/km^2)'} };
      end
    elseif( iSystem==8 )
      set(gcf,'Position',[50,50,600,760]);
      nrow = 7;
      iv = [ (1:5) 0 0 (6:12) (13:16) 0 17 0 ]';
      if( iNormD==1 )
        sYLab = { {'B_{i,0}' '(nT)'} {'\partialB_i/\partialn' '(nT/L_{sc})'} {'\partialB_i/\partialm' '(nT/L_{sc})'} {'\partialB_i/\partiall' '(nT/L_{sc})'} ...
          {'\partial^2B_i/\partialn^2' '(nT/L_{sc}^2)'} {'\partial^2B_i/\partialm^2' '(nT/L_{sc}^2)'} ...
          {'\partial^2B_i/\partialn\partialm' '(nT/L_{sc}^2)'} };
      else
        sYLab = { {'B_{i,0}' '(nT)'} {'\partialB_i/\partialn' '(nT/km)'} {'\partialB_i/\partialm' '(nT/km)'} {'\partialB_i/\partiall' '(nT/km)'} ...
          {'\partial^2B_i/\partialn^2' '(nT/km^2)'} {'\partial^2B_i/\partialm^2' '(nT/km^2)'} ...
          {'\partial^2B_i/\partialn\partialm' '(nT/km^2)'} };
      end
    elseif( iSystem==10 )
      set(gcf,'Position',[50,50,600,500]);
      nrow = 4;
      iv = (1:12)';
      if( iNormD==1 )
        sYLab = { {'B_{i,0}' '(nT)'} {'\partialB_i/\partialn' '(nT/L_{sc})'} {'\partialB_i/\partiall' '(nT/L_{sc})'} {'\partialB_i/\partialm' '(nT/L_{sc})'} };
      else
        sYLab = { {'B_{i,0}' '(nT)'} {'\partialB_i/\partialn' '(nT/km)'} {'\partialB_i/\partiall' '(nT/km)'} {'\partialB_i/\partialm' '(nT/km)'} };
      end
    elseif( iSystem==11 )
      set(gcf,'Position',[50,50,600,400]);
      nrow = 3;
      iv = (1:9)';
      if( iNormD==1 )
        sYLab = { {'B_{i,0}' '(nT)'} {'\partialB_i/\partialn' '(nT/L_{sc})'} {'\partialB_i/\partiall' '(nT/L_{sc})'} };
      else
        sYLab = { {'B_{i,0}' '(nT)'} {'\partialB_i/\partialn' '(nT/km)'} {'\partialB_i/\partiall' '(nT/km)'} };
      end
    end % iSystem
    xsc1 = 0.18; xsc2 = 0.98; ysc1 = 0.08; ysc2 = .95; blue = [0.4,.4,1]; wid1 = 1; wid2 = 1.5; wid3 = 3; ticklen = [0.08 0.04];
    ms = 10;
    vgap = 0.05;
    ncol = 3
    fxlab = .15; fylab = .8;
    sXLab = ['t(s) after ' sTime ' UT'];
    sTitle = { 'B_l' 'B_m' 'B_n' };
    
    for icol = 1:ncol
      irow = 0;
      for irow9 = 1:nrow
        iva = (icol-1)*nrow+irow9;
        irow = irow + 1;
        subplotrc(nrow,ncol, irow, icol );
        if( iv(iva)==0 )
          if(  icol==1 ), ylabel(sYLab{irow},'FontSize',11); end
          continue;
        end
        plot(t(iselne),X(iselne,iv(iva)),'LineWidth',wid2);
        if( icol==1 )
          ylabel(sYLab{irow},'FontSize',11);
        end
        set(gca,'TickLength',ticklen);
        set(gca,'XMinorTick','on');
        set(gca,'YMinorTick','on');
        %     ylim([xav1-xranged2 xav1+xranged2])
        if( irow==nrow )
          xlabel(sXLab,'FontSize',12);
        else
          %         set(gca,'XTickLabel','')
          if( irow==1 ); title(sTitle{icol},'FontSize',11); end
        end
        if( itscreen==1 ); xlim([tlo thi]); end
        textNormFig( gca, fxlab, fylab, ['('  sLabRow{irow} sLabCol{icol} ')'], 11 );
      end % irow9
    end % icol
  else % <iSystem<3, > iSystem>=3
    figure(34)
    clf;
    set(gcf,'Color','w');
    if( iQuadSys==-1 || iSystem==9 || iSystem==28 )
      set(gcf,'Position',[50,50,600,900]);
      nrow = 10;
    elseif( iQuadSys==0 )
      set(gcf,'Position',[50,50,600,900]);
      nrow = 9;
    elseif( iQuadSys==1 )
      set(gcf,'Position',[50,50,600,830]);
      nrow = 8;
    elseif( iQuadSys==2 )
      set(gcf,'Position',[50,50,600,760]);
      nrow = 7;
    elseif( iQuadSys==3 )
      set(gcf,'Position',[50,50,600,690]);
      nrow = 6;
    end
    xsc1 = 0.18; xsc2 = 0.98; ysc1 = 0.08; ysc2 = .95; blue = [0.4,.4,1]; wid1 = 1; wid2 = 1.5; wid3 = 3; ticklen = [0.02 0.01];
    ms = 10;
    vgap = 0.05;
    ncol = 3;
    fxlab = .15; fylab = .8;
    if( iSystem==9 )
      if( iNormD==1 )
        if( i28term==1 )
          sYLab = { {'B_{i,0}' '(nT)'} {'\partialB_i/\partialn' '(nT/L_{sc})'} {'\partialB_i/\partiall' '(nT/L_{sc})'} {'\partialB_i/\partialm' '(nT/L_{sc})'} ...
           {'\partial^2B_i/\partialn^2' '(nT/L_{sc}^2)'} {'\partial^2B_i/\partiall^2' '(nT/L_{sc}^2)'} {'\partial^2B_i/\partialn\partiall' '(nT/L_{sc}^2)'}   ...
            {'\partial^2B_i/\partialn\partialm' '(nT/L_{sc}^2)'} {'\partial^2B_i/\partiall\partialm' '(nT/L_{sc}^2)'} {'\partial^2B_i/\partialn^3' '(nT/L_{sc}^3)'} };
          i28col = 1;
        elseif( i28term==2 )
                   sYLab = { {'B_{i,0}' '(nT)'} {'\partialB_i/\partialn' '(nT/L_{sc})'} {'\partialB_i/\partiall' '(nT/L_{sc})'} {'\partialB_i/\partialm' '(nT/L_{sc})'} ...
           {'\partial^2B_i/\partialn^2' '(nT/L_{sc}^2)'} {'\partial^2B_i/\partiall^2' '(nT/L_{sc}^2)'} {'\partial^2B_i/\partialn\partiall' '(nT/L_{sc}^2)'}   ...
            {'\partial^2B_i/\partialn\partialm' '(nT/L_{sc}^2)'} {'\partial^2B_i/\partiall\partialm' '(nT/L_{sc}^2)'} {'\partial^2B_i/\partialn^2\partiall' '(nT/L_{sc}^3)'} };
          i28col = 2;
        elseif( i28term==3 )
           sYLab = { {'B_{i,0}' '(nT)'} {'\partialB_i/\partialn' '(nT/L_{sc})'} {'\partialB_i/\partiall' '(nT/L_{sc})'} {'\partialB_i/\partialm' '(nT/L_{sc})'} ...
           {'\partial^2B_i/\partialn^2' '(nT/L_{sc}^2)'} {'\partial^2B_i/\partiall^2' '(nT/L_{sc}^2)'} {'\partial^2B_i/\partialn\partiall' '(nT/L_{sc}^2)'}   ...
            {'\partial^2B_i/\partialn\partialm' '(nT/L_{sc}^2)'} {'\partial^2B_i/\partiall\partialm' '(nT/L_{sc}^2)'} {'\partial^2B_i/\partiall^2\partialm' '(nT/L_{sc}^3)'} };
          i28col = 3;
        elseif( i28term==4 )
          sYLab = { {'B_{i,0}' '(nT)'} {'\partialB_i/\partialn' '(nT/L_{sc})'} {'\partialB_i/\partiall' '(nT/L_{sc})'} {'\partialB_i/\partialm' '(nT/L_{sc})'} ...
           {'\partial^2B_i/\partialn^2' '(nT/L_{sc}^2)'} {'\partial^2B_i/\partiall^2' '(nT/L_{sc}^2)'} {'\partial^2B_i/\partialn\partiall' '(nT/L_{sc}^2)'}   ...
            {'\partial^2B_i/\partialn\partialm' '(nT/L_{sc}^2)'} {'\partial^2B_i/\partiall\partialm' '(nT/L_{sc}^2)'} {'\partial^2B_i/\partialn^2\partialm' '(nT/L_{sc}^3)'} };
          i28col = 1;
        elseif( i28term==5 )
          sYLab = { {'B_{i,0}' '(nT)'} {'\partialB_i/\partialn' '(nT/L_{sc})'} {'\partialB_i/\partiall' '(nT/L_{sc})'} {'\partialB_i/\partialm' '(nT/L_{sc})'} ...
           {'\partial^2B_i/\partialn^2' '(nT/L_{sc}^2)'} {'\partial^2B_i/\partiall^2' '(nT/L_{sc}^2)'} {'\partial^2B_i/\partialn\partiall' '(nT/L_{sc}^2)'}   ...
            {'\partial^2B_i/\partialn\partialm' '(nT/L_{sc}^2)'} {'\partial^2B_i/\partiall\partialm' '(nT/L_{sc}^2)'} {'Mixed cubic' '(nT/L_{sc}^3)'} };
          i28col = 1;
        end
      else
        if( i28term==1 )
          sYLab = { {'B_{i,0}' '(nT)'} {'\partialB_i/\partialn' '(nT/km)'} {'\partialB_i/\partiall' '(nT/km)'} {'\partialB_i/\partialm' '(nT/km)'} ...
           {'\partial^2B_i/\partialn^2' '(nT/km^2)'} {'\partial^2B_i/\partiall^2' '(nT/km^2)'} {'\partial^2B_i/\partialn\partiall' '(nT/km^2)'}   ...
            {'\partial^2B_i/\partialn\partialm' '(nT/km^2)'} {'\partial^2B_i/\partiall\partialm' '(nT/km^2)'} {'\partial^2B_i/\partialn^3' '(nT/km^3)'} };
          i28col = 1;
        elseif( i28term==2 )
                   sYLab = { {'B_{i,0}' '(nT)'} {'\partialB_i/\partialn' '(nT/km)'} {'\partialB_i/\partiall' '(nT/km)'} {'\partialB_i/\partialm' '(nT/km)'} ...
           {'\partial^2B_i/\partialn^2' '(nT/km^2)'} {'\partial^2B_i/\partiall^2' '(nT/km^2)'} {'\partial^2B_i/\partialn\partiall' '(nT/km^2)'}   ...
            {'\partial^2B_i/\partialn\partialm' '(nT/km^2)'} {'\partial^2B_i/\partiall\partialm' '(nT/km^2)'} {'\partial^2B_i/\partialn^2\partiall' '(nT/km^3)'} };
          i28col = 2;
        elseif( i28term==3 )
           sYLab = { {'B_{i,0}' '(nT)'} {'\partialB_i/\partialn' '(nT/km)'} {'\partialB_i/\partiall' '(nT/km)'} {'\partialB_i/\partialm' '(nT/km)'} ...
           {'\partial^2B_i/\partialn^2' '(nT/km^2)'} {'\partial^2B_i/\partiall^2' '(nT/km^2)'} {'\partial^2B_i/\partialn\partiall' '(nT/km^2)'}   ...
            {'\partial^2B_i/\partialn\partialm' '(nT/km^2)'} {'\partial^2B_i/\partiall\partialm' '(nT/km^2)'} {'\partial^2B_i/\partiall^2\partialm' '(nT/km^3)'} };
          i28col = 3;
        elseif( i28term==4 )
          sYLab = { {'B_{i,0}' '(nT)'} {'\partialB_i/\partialn' '(nT/km)'} {'\partialB_i/\partiall' '(nT/km)'} {'\partialB_i/\partialm' '(nT/km)'} ...
           {'\partial^2B_i/\partialn^2' '(nT/km^2)'} {'\partial^2B_i/\partiall^2' '(nT/km^2)'} {'\partial^2B_i/\partialn\partiall' '(nT/km^2)'}   ...
            {'\partial^2B_i/\partialn\partialm' '(nT/km^2)'} {'\partial^2B_i/\partiall\partialm' '(nT/km^2)'} {'\partial^2B_i/\partialn^2\partialm' '(nT/km^3)'} };
          i28col = 1;
        end
      end
    elseif( iSystem==28 )
      if( iNormD==1 )
        sYLab = { {'B_{i,0}' '(nT)'} {'\partialB_i/\partialn' '(nT/L_{sc})'} {'\partialB_i/\partiall' '(nT/L_{sc})'} {'\partialB_i/\partialm' '(nT/L_{sc})'} ...
           {'\partial^2B_i/\partialn^2' '(nT/L_{sc}^2)'} {'\partial^2B_i/\partiall^2' '(nT/L_{sc}^2)'} {'\partial^2B_i/\partialn\partiall' '(nT/L_{sc}^2)'}   ...
            {'\partial^2B_i/\partialn\partialm' '(nT/L_{sc}^2)'} {'\partial^2B_i/\partiall\partialm' '(nT/L_{sc}^2)'} {'sum(X28)' '(nT/L_{sc}^3)'} };
      else
         sYLab = { {'B_{i,0}' '(nT)'} {'\partialB_i/\partialn' '(nT/km)'} {'\partialB_i/\partiall' '(nT/km)'} {'\partialB_i/\partialm' '(nT/km)'} ...
           {'\partial^2B_i/\partialn^2' '(nT/km^2)'} {'\partial^2B_i/\partiall^2' '(nT/km^2)'} {'\partial^2B_i/\partialn\partiall' '(nT/km^2)'}   ...
            {'\partial^2B_i/\partialn\partialm' '(nT/km^2)'} {'\partial^2B_i/\partiall\partialm' '(nT/km^2)'} {'sum(X28)' '(nT/km^3)'} };
     end
    else
      if( iNormD==1 )
        sYLab = { {'B_{i,0}' '(nT)'} {'\partialB_i/\partialn' '(nT/L_{sc})'} {'\partialB_i/\partiall' '(nT/L_{sc})'} ...
          {'\partial^2B_i/\partialn^2' '(nT/L_{sc}^2)'} {'\partial^2B_i/\partialn\partiall' '(nT/L_{sc}^2)'}  {'\partial^2B_i/\partiall^2' '(nT/L_{sc}^2)'} ...
          {'\partialB_i/\partialm' '(nT/L_{sc})'} {'\partial^2B_i/\partialn\partialm' '(nT/L_{sc}^2)'} {'\partial^2B_i/\partiall\partialm' '(nT/L_{sc}^2)'} {'\partial^2B_i/\partialn^3' '(nT/L_{sc}^3)'}  };
      else
        sYLab = { {'B_{i,0}' '(nT)'} {'\partialB_i/\partialn' '(nT/km)'} {'\partialB_i/\partiall' '(nT/km)'} ...
          {'\partial^2B_i/\partialn^2' '(nT/km^2)'} {'\partial^2B_i/\partialn\partiall' '(nT/km^2)'}  {'\partial^2B_i/\partiall^2' '(nT/km^2)'} ...
          {'\partialB_i/\partialm' '(nT/km)'} {'\partial^2B_i/\partialn\partialm' '(nT/km^2)'} {'\partial^2B_i/\partiall\partialm' '(nT/km^2)'} {'\partial^2B_i/\partialn^3' '(nT/L_{sc}^3)'} };
      end
    end
    sXLab = ['t(s) after ' sTime ' UT'];
    sTitle = { 'Bl' 'Bm' 'Bn' };
    
    % xrange = 0;
    % for iva = 1:nvar
    %   xrange1 = max(X(:,iva))-min(X(:,iva));
    %   if( xrange1>xrange )
    %     xrange = xrange1;
    %   end
    % end
    % xranged2 = xrange/2;
    
    for icol = 1:ncol
      for irow = 1:nrow
        if( irow==10 )
          if( ( iSystem==9 && icol==i28col ) || ( iSystem==28 && icol==1 ) )
            iva = 28;
          else
            break; end
        else
          iva = (icol-1)*9+irow;
          if( iv(iva)==0 ) break; end
        end
        %     xav1 = mean(X(:,iva));
        subplotrc(nrow,ncol, irow, icol );
        if( iva==28 && iSystem==28 )
          plot(t(iselne),sum(abs(X(iselne,28:nvart)),2),'LineWidth',wid2);
          hold on
          plot(t(iselne),max(abs(X(iselne,28:nvart)),[],2),'r','LineWidth',wid2);
          hold off
        else
          plot(t(iselne),X(iselne,iv(iva)),'LineWidth',wid2);
        end
        %     ylim([xav1-xranged2 xav1+xranged2])
        set(gca,'TickLength',ticklen);
        set(gca,'XMinorTick','on');
        set(gca,'YMinorTick','on');
        if( icol==1 )
          ylabel(sYLab{irow},'FontSize',11);
        else
          %         set(gca,'YTickLabel','')
        end
        if( irow==nrow || ( iQuadSys==-1 && irow==9 && icol>1 ) || ( iSystem==9 && icol==9 && ico~=i28col ) || ( iSystem==28 && icol==9 && ico>1 ) )
          xlabel(sXLab,'FontSize',12);
        else
          %         set(gca,'XTickLabel','')
          if( irow==1 ); title(sTitle{icol}); end
        end
        if( itscreen==1 ); xlim([tlo thi]); end
        textNormFig( gca, fxlab, fylab, ['(' sLabRow{irow} sLabCol{icol} ')'], 11 );
      end % ic
    end % icol
    if( iQuadSys==-1 )
      subplotrc(10,3, 10, 1 );
        plot(t(iselne),X(iselne,28),'LineWidth',wid2);
        %     ylim([xav1-xranged2 xav1+xranged2])
        set(gca,'TickLength',ticklen);
        set(gca,'XMinorTick','on');
        set(gca,'YMinorTick','on');
        if( icol==1 )
          ylabel(sYLab{irow},'FontSize',11);
        else
          %         set(gca,'YTickLabel','')
        end
        xlabel(sXLab,'FontSize',12);
        if( itscreen==1 ); xlim([tlo thi]); end
        textNormFig( gca, fxlab, fylab, ['(' sLabRow{irow} sLabCol{icol} ')'], 11 );
    end
    
  end % iSystem>=3
  if( iPlot34==2 )
    sFile = [sDirPlots 'Poly_X_BscOut' num2str(iScOutIn) '_Brs' num2str(iBurst) '_Smo' num2str(nsmoothspan) '_Sub' num2str(iSubAvB) '_Rot' num2str(iRotate) '_noXRot' num2str(iNoXRotation) '_iSys' num2str(iSystem) '_iIncmprs' num2str(iIncmprs) '_iexctB' num2str(iExactB) '_iNF' num2str(iNormFlds) '_' num2str(wFlds(1)) '-' num2str(wFlds(2)) '-' num2str(wFlds(3)) '-' num2str(wFlds(4)) '-' num2str(wFlds(5)) '-' num2str(wFlds(6)) '_wB' num2str(wMag) '_iAltNe' num2str(iAltNe) '_t' num2str(tlo,3) '-' num2str(thi,3)]; 
    export_fig(sFile,'-pdf'); 
    save([sFile '.mat'],'t','X','iselne','nrow','iv','sYLab');
  end
end % iPlot34

%%
if( iPlot35>0 )
  figure(35)
  clf;
  set(gcf,'Color','w');
  set(gcf,'Position',[50,50,900,800]);
  xsc1 = 0.14; xsc2 = 0.98; ysc1 = 0.08; ysc2 = .95; blue = [0.4,.4,1]; wid1 = 1; wid2 = 1.5; wid3 = 3; ticklen = [0.02 0.01];
  ms = 10;
  vgap = 0.05;
  fxlab = .15; fylab = .8;
  sXLab = 'L/L_{sc}';
  sYLab = 'N/L_{sc}';
  iskip = ceil((nt-1)/15);
  nrow = 4;
  ncol = 4;
  npanels = nrow*ncol;
  nL = 31; nLcut = 7;
  La = linspace(-Lmax,Lmax,nL); dL = La(2) - La(1);
  Lacut = linspace(-Lmax,Lmax,nLcut);
  [L2D,N2D] = meshgrid(La);
  [L2Dcut,N2Dcut] = meshgrid(Lacut);
  %   M2D = zeros(size(L2D));
  casc = [ gray ; 1 0 0 ; 0 .8 0 ; .3 .3 1 ];
  fwh = .65;
  
  ipl = 0;
  %   maxAbsValx = 0;
  maxAbsValx = 3.3043;
  l2D = zeros(nL); m2D = zeros(nL); n2D = zeros(nL);
  BL2D = zeros(nL); BM2D = zeros(nL); BN2D = zeros(nL);
  for i = 1:iskip:nt % nt
    ipl = ipl + 1;
    
    mv1 = squeeze(mv(i,:,:));
    for i1 = 1:nL
      for j1 = 1:nL
        Pos1 = [ L2D(j1,i1) 0 N2D(j1,i1) ];
        pos1 = Pos1 * mv1;
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
    
    maxAbsVal = maxAll( abs( BM2D ) )
    maxAbsValx = max( maxAbsValx,maxAbsVal );
    zcolorM = [ -maxAbsVal ; 0 ; maxAbsVal ];
    colorsM = [ fwh fwh 1 ; 1 1 1 ;  1 fwh fwh ];
    colorM = colormap_colors(zcolorM,colorsM);
    
    subplot(nrow,ncol,ipl);
    imagesc(La,La',BM2D);
    caxis([-maxAbsVal maxAbsVal])
    colormap(colorM)
    shading interp;
    hcb = colorbar;
    cblab = ylabel(hcb,'B_M');
    set(cblab,'FontSize',9,'Rotation',0);
    hold on
    hst = streamline(L2D,N2D,BL2D,BN2D,L2Dcut,N2Dcut);
    set(hst,'Color','k')
    hst = streamline(L2D,N2D,-BL2D,-BN2D,L2Dcut,N2Dcut);
    set(hst,'Color','k')
    %     contour(La,La',A2,25,'k');
    for k = 1:4
      plot(xv(i,1,k),xv(i,3,k),'o','MarkerSize',3,'Linewidth',2,'Color',casc(k,:));
    end
    hold off
    axis xy;
    axis square;
    set(gca,'TickLength',ticklen);
    set(gca,'XMinorTick','on')
    set(gca,'YMinorTick','on')
    xlabel(sXLab,'FontSize',12);
    ylabel(sYLab,'FontSize',12);
    title({['t = ' num2str(t(i)) ' s after ' sTime ' UT'] , ...
      sprintf(['\x3BB=%0.2g/%0.2g/%0.2g, \x3B8_M=%0.2g, \x3C3' ...
      '=%0.2g'],lambda(i,:),angMM0(i),dev(i))} ,'Fontsize',7);
    %       textNormFig( gca, fxlab, fylab, ['(' sLabCol{icol} sLabRow{irow} ')'], 11 )
    drawnow;
  end % i
  if( iPlot35==2 ), export_fig([sDirPlots 'Poly_BLN_BscOut' num2str(iScOutIn) '_Brs' num2str(iBurst) '_Smo' num2str(nsmoothspan) '_Sub' num2str(iSubAvB) '_Rot' num2str(iRotate) '_noXRot' num2str(iNoXRotation) '_iSys' num2str(iSystem) '_iIncmprs' num2str(iIncmprs) '_iexctB' num2str(iExactB) '_iNF' num2str(iNormFlds) '_' num2str(wFlds(1)) '-' num2str(wFlds(2)) '-' num2str(wFlds(3)) '-' num2str(wFlds(4)) '-' num2str(wFlds(5)) '-' num2str(wFlds(6)) '_wB' num2str(wMag) '_iAltNe' num2str(iAltNe) '_t' num2str(tlo,3) '-' num2str(thi,3)  '.pdf '],'-pdf'); end
end % iPlot35

%%
if( iPlot51>0 )
  figure(51)
  clf;
  clear i41;
  set(gcf,'Color','w');
  set(gcf,'Position',[500,50,810,530]);
  
  % For bottom part
  xsc1 = 0.25; xsc2 = 0.75; ysc1 = 0.79; ysc2 = .96;
  ticklen = [0.04 0.02];
  fxlab = .94; fylab = .8;
  casc = [ gray ; 1 0 0 ; 0 .8 0 ; .3 .3 1 ];
  nrow = 2;
  ncol = 4;
  npanels = nrow*ncol;
  n41 = nrow*ncol;
  if( exist('i41','var')==0 )
      di41 = ( nt - 1 )/(n41-1);
      i41 = round( (1:di41:nt) );
  end
  if( numel(i41)~=n41 ), error(['numel(i41) = ' numel(i41) ' <> ' num2str(n41)]); end

  
    wid1 = 1.5; wid2 = 2; wid3 = 2; fs1 = 9; fs2 = 11;
  
    hax = my_subplotrc3(1,1, 1, 1, xsc1,xsc2,ysc1,ysc2);
    h1 = plot(t,bavv(:,1),'Color',casc(4,:),'Linewidth',wid1);
    xlim([t(1) t(end)]);
    hold on
    h2 = plot(t,bavv(:,2),'Color',casc(3,:),'Linewidth',wid1);
    h3 = plot(t,bavv(:,3),'Color',casc(2,:),'Linewidth',wid1);
    plot([t(1),t(end)],[0 0],'k:','Linewidth',wid2);
    ylim1 = get(gca,'YLim');
    ylab = ylim1(1) + (ylim1(2)-ylim1(1))*1.15;
    for ipl = 1:n41
        plot([t(i41(ipl)) t(i41(ipl))],ylim1,':','Color',[.2,.2,.2],'LineWidth',1);
        text(t(i41(ipl)),ylab,[char('c'+ipl-1)]);
    end
    hold off
    set(gca,'Fontsize',11);
    set(gca,'TickLength',ticklen);
    set(gca,'XMinorTick','on');
    set(gca,'YMinorTick','on');
    if( iRotate>0 )
      ylabel({'{\bfB}_{av} LMN' '(nT)'},'Fontsize',fs2);
    else
      ylabel({'{\bfB}_{av} GSE' '(nT)'},'Fontsize',fs2);
    end
    htn = textNormFig( gca, fxlab, fylab, ['(a)'], 10 );
    htn = textNormFig( gca, -.03, -.16,'t(s)', fs2 );
%     hxl = xlabel(['t(s) after ' sTime ' UT']);

    
  xsc1 = 0.07; xsc2 = 0.91; ysc1 = 0.11; ysc2 = .7; blue = [0.4,.4,1]; wid1 = 1; wid2 = 1.5; wid3 = 3; ticklen = [0.04 0.02];
  hgap=0.015; vgap=0.04;
  ms = 10;
  fxlab = .05; fylab = .9;
  sXLab = 'L/L_{sc}';
  sYLab = 'N/L_{sc}';
  iskip = ceil((nt-1)/15);
  nL = 31; nLcut = 7;
  La = linspace(-Lmax,Lmax,nL); dL = La(2) - La(1);
  Lacut = linspace(-Lmax,Lmax,nLcut);
  [L2D,N2D] = meshgrid(La);
  [L2Dcut,N2Dcut] = meshgrid(Lacut);
  %   M2D = zeros(size(L2D));
  casc = [ gray ; 1 0 0 ; 0 .8 0 ; .2 .2 1 ];
  fwh = .65;
  
  maxAbsValx = 0;
  l2D = zeros(nL); m2D = zeros(nL); n2D = zeros(nL);
  BL2D = zeros(nL); BM2D = zeros(nL); BN2D = zeros(nL);
  BL2Da = zeros(nL,nL,n41);   BM2Da = zeros(nL,nL,n41);   BN2Da = zeros(nL,nL,n41); 
  for ipl = 1:n41 % nt
    i = i41(ipl);
    
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
    
  end % ipl
  
   zcolorM = [ -maxAbsValx ; 0 ; maxAbsValx ];
   colorsM = [ fwh fwh 1 ; 1 1 1 ;  1 fwh fwh ];
   colorM = colormap_colors(zcolorM,colorsM);
   
  for ipl = 1:n41 % nt
    i = i41(ipl);
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
    for isl = 1:nsl
      ri = 1 + rand*(nL-1);
      ii = floor(ri);
      ip = 1 + ii;
      fip = ri - ii;
      fii = 1 - fip;
      Lsl(isl) = fii*La(ii) + fip*La(ip);
      csN1 = 0.5*( fii*csN(:,ii) + fip*csN(:,ip) );
      rj = 1 + rand*(nL-1);
      jj = floor(rj);
      jp = 1 + jj;
      fjp = rj - jj;
      fjj = 1 - fjp;
      Nsl(isl) = fjj*La(jj) + fjp*La(jp);
    end
        
    my_subplotrc4(nrow, ncol, irow, icol, xsc1, xsc2, ysc1, ysc2, hgap, vgap );
    imagesc(La,La',Bvar3);
    caxis([-maxAbsValx maxAbsValx]);
    colormap(colorM);
    shading interp;
    if( ipl==n41) 
      hcb = colorbar;
      set(hcb,'Position',[xsc2 + .015,ysc1,.015,ysc2-ysc1]);
      if( iRotate>0 )
        cblab = ylabel(hcb,{'B_{M}' '(nT)'});
      else
        cblab = ylabel(hcb,{'B_{Y}' '(nT)'});
      end
      set(cblab,'FontSize',9,'Rotation',0,'Units', 'Normalized'); %, 'Position', [3, .8, 0]);
    end
    hold on
%     hst = streamline(L2D,N2D,BL2D,BN2D,L2Dcut,N2Dcut);
    hst = streamline(L2D,N2D,BL2D,BN2D,Lsl,Nsl);
    set(hst,'Color',gray)
    hst = streamline(L2D,N2D,-BL2D,-BN2D,Lsl,Nsl);
    set(hst,'Color',gray)
    %     contour(La,La',A2,25,'k');
    if( iLocalGradCoord==1 )
      for k = 1:4
        plot(xvn(i,1,k),xvn(i,3,k),'o','MarkerSize',6,'Color','w','MarkerFaceColor',casc(k,:));
      end
    else
      for k = 1:4
        plot(xv(i,1,k),xv(i,3,k),'o','MarkerSize',6,'Color','w','MarkerFaceColor',casc(k,:));
      end
    end
    hold off
    axis xy;
    axis square;
    set(gca,'TickLength',ticklen);
    set(gca,'TickDir','out');
    set(gca,'XMinorTick','on');
    set(gca,'YMinorTick','on');
    set(gca,'FontSize',10);
    if( irow==nrow ), xlabel(sXLab,'FontSize',12); else, set(gca,'XTickLabel',''); end
    if( icol==1    ), ylabel(sYLab,'FontSize',12); else, set(gca,'YTickLabel',''); end
%     title({['t = ' num2str(t(i)) ' s after ' sTime ' UT'] , ...
%       sprintf(['\x3BB=%0.2g/%0.2g/%0.2g, \x3B8_M=%0.2g, \x3C3' ...
%       '=%0.2g'],lambda(i,:),angMM0(i),dev(i))} ,'Fontsize',7);
%     htn = textNormFig( gca, fxlab, fylab, ['(' char('a'+ipl-1) ') t = ' num2str(t(i),4)], 11 )
    title(['(' char('c'+ipl-1) ') t = ' num2str(t(i),4)],'FontSize',10);
%     set(htn,'Color',[1,.55,0],'HorizontalAlignment','left','FontWeight','bold');
%     set(htn,'Color','w','HorizontalAlignment','left','FontWeight','bold');
    drawnow;
  end % i
  if( iPlot51==2 ), export_fig([sDirPlots 'Poly_BLNspec_BscOut' num2str(iScOutIn) '_Brs' num2str(iBurst) '_Smo' num2str(nsmoothspan) '_Sub' num2str(iSubAvB) '_Rot' num2str(iRotate) '_noXRot' num2str(iNoXRotation) '_iSys' num2str(iSystem) '_iIncmprs' num2str(iIncmprs) '_iexctB' num2str(iExactB) '_iNF' num2str(iNormFlds) '_' num2str(wFlds(1)) '-' num2str(wFlds(2)) '-' num2str(wFlds(3)) '-' num2str(wFlds(4)) '-' num2str(wFlds(5)) '-' num2str(wFlds(6)) '_wB' num2str(wMag) '_iAltNe' num2str(iAltNe) '_iBMloc' num2str(iLocalBM) '_t' num2str(tlo,3) '-' num2str(thi,3)  '.pdf '],'-pdf'); end
end % iPlot51

%%
if( iPlot511>0 )
  figure(511)
  clf;
  clear i41;
  set(gcf,'Color','w');
  set(gcf,'Position',[500,50,710,830]);
  
  % For bottom part
  xsc1 = 0.25; xsc2 = 0.75; ysc1 = 0.85; ysc2 = .96;
  ticklen = [0.04 0.02];
  fxlab = .94; fylab = .3;
  casc = [ gray ; 1 0 0 ; 0 .8 0 ; .3 .3 1 ];
  nrow = 4;
  ncol = 4;
  n41 = nrow*ncol;
  npanels = n41;
  if( ialtT511==1 )
    i41 = zeros(1,n41);
    for ipl = 1:npanels
      i41(ipl) = find( abs(t-altT511(ipl))==min(abs(t-altT511(ipl))) );
    end      
  else
    if( exist('i41','var')==0 )  % overridden below if ialtT511==1
      di41 = ( nt - 1 )/(n41-1);
      i41 = round( (1:di41:nt) );
    end
  end
  if( numel(i41)~=n41 ), error(['numel(i41) = ' numel(i41) ' <> ' num2str(n41)]); end
  
    wid1 = 1.5; wid2 = 2; wid3 = 2; fs9 = 9; fs10 = 10; fs11 = 11; fs12 = 12;
  
    hax = my_subplotrc3(1,1, 1, 1, xsc1,xsc2,ysc1,ysc2);
    h1 = plot(t,bavv(:,1),'Color',casc(4,:),'Linewidth',wid1);
    xlim([t(1) t(end)]);
    hold on
    h2 = plot(t,bavv(:,2),'Color',casc(3,:),'Linewidth',wid1);
    h3 = plot(t,bavv(:,3),'Color',casc(2,:),'Linewidth',wid1);
    plot([t(1),t(end)],[0 0],'k:','Linewidth',wid2);
    ylim1 = get(gca,'YLim');
    ylab = ylim1(1) + (ylim1(2)-ylim1(1))*1.15;
    for ipl = 1:n41
        plot([t(i41(ipl)) t(i41(ipl))],ylim1,':','Color',[.2,.2,.2],'LineWidth',1);
        text(t(i41(ipl)),ylab,[char('b'+ipl-1)],'FontSize',fs11);
    end
    hold off
    set(gca,'Fontsize',fs11);
    set(gca,'TickLength',ticklen);
    set(gca,'XMinorTick','on');
    set(gca,'YMinorTick','on');
    if( iRotate>0 )
      ylabel({'{\bfB}_{av} {\color[rgb]{.3,.3,1}L}{\color[rgb]{0,.8,0}M}{\color[rgb]{.9,0,0}N}' '(nT)'},'Fontsize',fs11);
    else
      ylabel({'{\bfB}_{av} GSE' '(nT)'},'Fontsize',fs11);
    end
    htn = textNormFig( gca, fxlab, fylab, ['(a)'], 12 );
    htn = textNormFig( gca, -.08, -.15,'t(s)', fs12 );
%     hxl = xlabel(['t(s) after ' sTime ' UT']);

    
  xsc1 = 0.07; xsc2 = 0.91; ysc1 = 0.08; ysc2 = .78; blue = [0.4,.4,1]; wid1 = 1; wid2 = 1.5; wid3 = 3; ticklen = [0.04 0.02];
  hgap=0.01; vgap=0.03;
  ms = 10;
  fxlab = .05; fylab = .9;
  sXLab = 'L/L_{sc}';
  sYLab = 'N/L_{sc}';
  iskip = ceil((nt-1)/15);
  nL = 31; nLcut = 7;
  La = linspace(-Lmax,Lmax,nL); dL = La(2) - La(1);
  Lacut = linspace(-Lmax,Lmax,nLcut);
  [L2D,N2D] = meshgrid(La);
  [L2Dcut,N2Dcut] = meshgrid(Lacut);
  %   M2D = zeros(size(L2D));
  casc = [ gray ; 1 0 0 ; 0 .8 0 ; .2 .2 1 ];
  fwh = .65;
  
  maxAbsValx = 0;
  l2D = zeros(nL); m2D = zeros(nL); n2D = zeros(nL);
  BL2D = zeros(nL); BM2D = zeros(nL); BN2D = zeros(nL);
  BL2Da = zeros(nL,nL,n41);   BM2Da = zeros(nL,nL,n41);   BN2Da = zeros(nL,nL,n41); 
  for ipl = 1:n41 % nt
    
    i = i41(ipl);
    
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
    
  end % ipl
  
   zcolorM = [ -maxAbsValx ; 0 ; maxAbsValx ];
   colorsM = [ fwh fwh 1 ; 1 1 1 ;  1 fwh fwh ];
   colorM = colormap_colors(zcolorM,colorsM);
   
  for ipl = 1:n41 % nt
    i = i41(ipl);
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
        
    my_subplotrc4(nrow, ncol, irow, icol, xsc1, xsc2, ysc1, ysc2, hgap, vgap );
    imagesc(La,La',Bvar3);
    caxis([-maxAbsValx maxAbsValx]);
    colormap(colorM);
    shading interp;
    if( ipl==n41) 
      hcb = colorbar;
      set(hcb,'Position',[xsc2 + .015,ysc1,.015,ysc2-ysc1],'FontSize',fs10);
      if( iRotate>0 )
        cblab = ylabel(hcb,{'B_{M}' '(nT)'});
      else
        cblab = ylabel(hcb,{'B_{Y}' '(nT)'});
      end
      set(cblab,'FontSize',fs11,'Rotation',0,'Units', 'Normalized','Position', [3.5, .6, 0]); %, 'Position', [3, .8, 0]);
    end
    hold on
%     hst = streamline(L2D,N2D,BL2D,BN2D,L2Dcut,N2Dcut);
    hst = streamline(L2D,N2D,BL2D,BN2D,Lsl,Nsl);
    set(hst,'Color',gray)
    hst = streamline(L2D,N2D,-BL2D,-BN2D,Lsl,Nsl);
    set(hst,'Color',gray)
    %     contour(La,La',A2,25,'k');
    if( iLocalGradCoord==1 )
      for k = 1:4
        plot(xvn(i,1,k),xvn(i,3,k),'o','MarkerSize',6,'Color','w','MarkerFaceColor',casc(k,:));
      end
    else
      for k = 1:4
        plot(xv(i,1,k),xv(i,3,k),'o','MarkerSize',6,'Color','w','MarkerFaceColor',casc(k,:));
      end
    end
    hold off
    axis xy;
    axis square;
    set(gca,'TickLength',ticklen);
    set(gca,'TickDir','out');
    set(gca,'XMinorTick','on');
    set(gca,'YMinorTick','on');
    set(gca,'FontSize',fs11);
    if( irow==nrow ), xlabel(sXLab,'FontSize',fs12); else, set(gca,'XTickLabel',''); end
    if( icol==1    ), ylabel(sYLab,'FontSize',fs12); else, set(gca,'YTickLabel',''); end
%     title({['t = ' num2str(t(i)) ' s after ' sTime ' UT'] , ...
%       sprintf(['\x3BB=%0.2g/%0.2g/%0.2g, \x3B8_M=%0.2g, \x3C3' ...
%       '=%0.2g'],lambda(i,:),angMM0(i),dev(i))} ,'Fontsize',7);
%     htn = textNormFig( gca, fxlab, fylab, ['(' char('a'+ipl-1) ') t = ' num2str(t(i),4)], 11 )
    title(['(' char('b'+ipl-1) ') t = ' num2str(t(i),4)],'FontSize',fs11);
%     set(htn,'Color',[1,.55,0],'HorizontalAlignment','left','FontWeight','bold');
%     set(htn,'Color','w','HorizontalAlignment','left','FontWeight','bold');
    drawnow;
  end % i
  if( iPlot511==2 ), export_fig([sDirPlots 'Poly_BLN43_BscOut' num2str(iScOutIn) '_Brs' num2str(iBurst) '_Smo' num2str(nsmoothspan) '_Sub' num2str(iSubAvB) '_Rot' num2str(iRotate) '_noXRot' num2str(iNoXRotation) '_iSys' num2str(iSystem) '_iIncmprs' num2str(iIncmprs) '_iexctB' num2str(iExactB) '_iNF' num2str(iNormFlds) '_' num2str(wFlds(1)) '-' num2str(wFlds(2)) '-' num2str(wFlds(3)) '-' num2str(wFlds(4)) '-' num2str(wFlds(5)) '-' num2str(wFlds(6)) '_wB' num2str(wMag) '_iAltNe' num2str(iAltNe) '_iBMloc' num2str(iLocalBM) '_t' num2str(tlo,3) '-' num2str(thi,3)],'-pdf'); end
end % iPlot511

%%
if( iPlot512>0 )
  figure(512)
  clf;
  clear i41;
  set(gcf,'Color','w');
  set(gcf,'Position',[900,50,270,1000]);
  
  % For bottom part
  nrow = 6;
  ncol = 1;
  npanels = nrow*ncol;
  n41 = nrow*ncol;
  if( exist('i41','var')==0 )
      di41 = ( nt - 1 )/(n41-1);
      i41 = round( (1:di41:nt) );
  end
  if( numel(i41)~=n41 ), error(['numel(i41) = ' numel(i41) ' <> ' num2str(n41)]); end

  
  wid1 = 1.5; wid2 = 2; wid3 = 2; fs9 = 9; fs10 = 10; fs11 = 11; fs12 = 12;
  
  
  xsc1 = 0.085; xsc2 = 0.85; ysc1 = 0.06; ysc2 = .98; blue = [0.4,.4,1]; wid1 = 1; wid2 = 1.5; wid3 = 3; ticklen = [0.04 0.02];
  hgap=0.0; vgap=0.03;
  ms = 10;
  fxlab = .05; fylab = .9;
  sXLab = 'L/L_{sc}';
  sYLab = 'N/L_{sc}';
  iskip = ceil((nt-1)/15);
  nL = 31; nLcut = 7;
  La = linspace(-Lmax,Lmax,nL); dL = La(2) - La(1);
  Lacut = linspace(-Lmax,Lmax,nLcut);
  [L2D,N2D] = meshgrid(La);
  [L2Dcut,N2Dcut] = meshgrid(Lacut);
  %   M2D = zeros(size(L2D));
  casc = [ gray ; 1 0 0 ; 0 .8 0 ; .2 .2 1 ];
  fwh = .65;
  
  maxAbsValx = 0;
  l2D = zeros(nL); m2D = zeros(nL); n2D = zeros(nL);
  BL2D = zeros(nL); BM2D = zeros(nL); BN2D = zeros(nL);
  BL2Da = zeros(nL,nL,n41);   BM2Da = zeros(nL,nL,n41);   BN2Da = zeros(nL,nL,n41); 
  for ipl = 1:n41 % nt
    
%     ialtT512 = 1; % use specified times
%     altT512 = [ 31.33, 32.15, 32.52, 32.88, 33, 33.2 ]; % alternate times

    if( ialtT512==1 )
      i = find( abs(t-altT512(ipl))==min(abs(t-altT512(ipl))) );
    else
      i = i41(ipl);
    end
    
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
    elseif( iSystem==10 )
        % B_s,L
        j0 = 0;
        Bl2D = X1(j0+1) + X1(j0+2)*n2D + X1(j0+3)*l2D + X1(j0+4)*m2D;
        % B_s,M
        j0 = 4;
        Bm2D = X1(j0+1) + X1(j0+2)*n2D + X1(j0+3)*l2D + X1(j0+4)*m2D;
        % B_s,N
        j0 = 8;
        Bn2D = X1(j0+1) + X1(j0+2)*n2D + X1(j0+3)*l2D + X1(j0+4)*m2D;
    elseif( iSystem==11 )
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
    if( ialtBM512==1 ), maxAbsValx = altBM512; end
    
    BL2Da(:,:,ipl) = BL2D; BM2Da(:,:,ipl) = BM2D; BN2Da(:,:,ipl) = BN2D; 
    
  end % ipl
  
   zcolorM = [ -maxAbsValx ; 0 ; maxAbsValx ];
   colorsM = [ fwh fwh 1 ; 1 1 1 ;  1 fwh fwh ];
   colorM = colormap_colors(zcolorM,colorsM);
   
  for ipl = 1:n41 % nt
    if( ialtT512==1 )
      i = find( abs(t-altT512(ipl))==min(abs(t-altT512(ipl))) );
    else
      i = i41(ipl);
    end
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
    for isl = 1:nsl
      ri = 1 + rand*(nL-1);
      ii = floor(ri);
      ip = 1 + ii;
      fip = ri - ii;
      fii = 1 - fip;
      Lsl(isl) = fii*La(ii) + fip*La(ip);
      csN1 = 0.5*( fii*csN(:,ii) + fip*csN(:,ip) );
      rj = 1 + rand*(nL-1);
      jj = floor(rj);
      jp = 1 + jj;
      fjp = rj - jj;
      fjj = 1 - fjp;
      Nsl(isl) = fjj*La(jj) + fjp*La(jp);
    end
        
    my_subplotrc4(nrow, ncol, irow, icol, xsc1, xsc2, ysc1, ysc2, hgap, vgap );
    imagesc(La,La',Bvar3);
    caxis([-maxAbsValx maxAbsValx]);
    colormap(colorM);
    shading interp;
    if( ipl==n41) 
      hcb = colorbar;
      set(hcb,'Position',[xsc2 - .035,ysc1,.04,ysc2-ysc1],'FontSize',fs10);
      if( iRotate>0 )
        cblab = ylabel(hcb,{'B_{M}' '(nT)'});
      else
        cblab = ylabel(hcb,{'B_{Y}' '(nT)'});
      end
      set(cblab,'FontSize',fs11,'Rotation',0,'Units', 'Normalized','Position', [3., ycblab512, 0]); %, 'Position', [3, .8, 0]);
    end
    hold on
%     hst = streamline(L2D,N2D,BL2D,BN2D,L2Dcut,N2Dcut);
    hst = streamline(L2D,N2D,BL2D,BN2D,Lsl,Nsl);
    set(hst,'Color',gray)
    hst = streamline(L2D,N2D,-BL2D,-BN2D,Lsl,Nsl);
    set(hst,'Color',gray)
    %     contour(La,La',A2,25,'k');
    if( iLocalGradCoord==1 )
      for k = 1:4
        plot(xvn(i,1,k),xvn(i,3,k),'o','MarkerSize',6,'Color','w','MarkerFaceColor',casc(k,:));
      end
    else
      for k = 1:4
        plot(xv(i,1,k),xv(i,3,k),'o','MarkerSize',6,'Color','w','MarkerFaceColor',casc(k,:));
      end
    end
    hold off
    axis xy;
    axis square;
    set(gca,'TickLength',ticklen);
    set(gca,'TickDir','out');
    set(gca,'XMinorTick','on');
    set(gca,'YMinorTick','on');
    set(gca,'FontSize',fs11);
    if( irow==nrow ), xlabel(sXLab,'FontSize',fs12); else, set(gca,'XTickLabel',''); end
    if( icol==1 && i512ylab==1   ), ylabel(sYLab,'FontSize',fs12); else, set(gca,'YTickLabel',''); end
%     title({['t = ' num2str(t(i)) ' s after ' sTime ' UT'] , ...
%       sprintf(['\x3BB=%0.2g/%0.2g/%0.2g, \x3B8_M=%0.2g, \x3C3' ...
%       '=%0.2g'],lambda(i,:),angMM0(i),dev(i))} ,'Fontsize',7);
%     htn = textNormFig( gca, fxlab, fylab, ['(' char('a'+ipl-1) ') t = ' num2str(t(i),4)], 11 )
    title(['(' char(s512let+ipl-1) ') t = ' num2str(t(i),4)],'FontSize',fs11);
%     set(htn,'Color',[1,.55,0],'HorizontalAlignment','left','FontWeight','bold');
%     set(htn,'Color','w','HorizontalAlignment','left','FontWeight','bold');
    drawnow;
  end % i
  if( iPlot512==2 ), export_fig([sDirPlots 'Poly_BLN61_BscOut' num2str(iScOutIn) '_Brs' num2str(iBurst) '_Smo' num2str(nsmoothspan) '_Sub' num2str(iSubAvB) '_Rot' num2str(iRotate) '_noXRot' num2str(iNoXRotation) '_iSys' num2str(iSystem) '_iIncmprs' num2str(iIncmprs) '_iexctB' num2str(iExactB) '_iNF' num2str(iNormFlds) '_' num2str(wFlds(1)) '-' num2str(wFlds(2)) '-' num2str(wFlds(3)) '-' num2str(wFlds(4)) '-' num2str(wFlds(5)) '-' num2str(wFlds(6)) '_wB' num2str(wMag) '_iAltNe' num2str(iAltNe) '_iBMloc' num2str(iLocalBM) '_t' num2str(tlo,3) '-' num2str(thi,3)  '.pdf '],'-pdf'); end
%   if( iPlot512==2 ), export_fig([sDirPlots 'Poly_BLN61_BscOut' num2str(iScOutIn) '_Brs' num2str(iBurst) '_Smo' num2str(nsmoothspan) '_Sub' num2str(iSubAvB) '_Rot' num2str(iRotate) '_noXRot' num2str(iNoXRotation) '_iSys' num2str(iSystem) '_iIncmprs' num2str(iIncmprs) '_iexctB' num2str(iExactB) '_iNF' num2str(iNormFlds) '_' num2str(wFlds(1)) '-' num2str(wFlds(2)) '-' num2str(wFlds(3)) '-' num2str(wFlds(4)) '-' num2str(wFlds(5)) '-' num2str(wFlds(6)) '_wB' num2str(wMag) '_iAltNe' num2str(iAltNe) '_iBMloc' num2str(iLocalBM) '_t' num2str(tlo,3) '-' num2str(thi,3)  '.eps '],'-eps'); end
end % iPlot512

%%
if( iPlot510>0 )
  figure(510)
  clf;
  clear i41;
  set(gcf,'Color','w');
  set(gcf,'Position',[300,50,810,550]);
  
  % For top part
  if( i510lr==1 )
    xsc1 = 0.11; xsc2 = 0.45; 
  else
    xsc1 = 0.61; xsc2 = 0.95;
  end
  ysc1 = 0.79; ysc2 = .96;
  ticklen = [0.04 0.02];
  fxlab = .94; fylab = .8;
  casc = [ 0 0 0 ; 1 0 0 ; 0 .8 0 ; .3 .3 1 ];
  nrow = 2;
  ncol = 4;
  npanels = 1*ncol;
  n41 = 1*ncol;
  if( ialtT510==1 )
    i41 = zeros(1,n41);
    for ipl = 1:npanels
      i41(ipl) = find( abs(t-altT510(ipl))==min(abs(t-altT510(ipl))) );
    end      
  else
    if( exist('i41','var')==0 )  % overridden below if ialtT511==1
      di41 = ( nt - 1 )/(n41-1);
      i41 = round( (1:di41:nt) );
    end
  end
  if( numel(i41)~=n41 ), error(['numel(i41) = ' numel(i41) ' <> ' num2str(n41)]); end

  
    wid1 = 1.5; wid2 = 2; wid3 = 2; fs1 = 9; fs2 = 14;
  
    hax = my_subplotrc3(1,1, 1, 1, xsc1,xsc2,ysc1,ysc2);
    h1 = plot(t,bavv(:,1),'Color',casc(4,:),'Linewidth',wid1);
    xlim([t(1) t(end)])
    hold on
    h2 = plot(t,bavv(:,2),'Color',casc(3,:),'Linewidth',wid1);
    h3 = plot(t,bavv(:,3),'Color',casc(2,:),'Linewidth',wid1);
    plot([t(1),t(end)],[0 0],'k:','Linewidth',wid2);
    ylim1 = get(gca,'YLim');
    ylab = ylim1(1) + (ylim1(2)-ylim1(1))*1.15;
    for ipl = 1:n41
        plot([t(i41(ipl)) t(i41(ipl))],ylim1,':','Color',[.2,.2,.2],'LineWidth',1);
        if( i510lr==1 )
          text(t(i41(ipl)),ylab,[char('c'+ipl-1)]);
        else
          text(t(i41(ipl)),ylab,[char('g'+ipl-1)]);
        end
    end
    hold off
    set(gca,'Fontsize',11);
    set(gca,'TickLength',ticklen);
    set(gca,'XMinorTick','on');
    set(gca,'YMinorTick','on');
    if( iRotate>0 )
      ylabel({'{\bfB}_{av} LMN' '(nT)'},'Fontsize',fs2);
    else
      ylabel({'{\bfB}_{av} GSE' '(nT)'},'Fontsize',fs2);
    end
    if( i510lr==1 )
      htn = textNormFig( gca, fxlab, fylab, ['(a)'], 10 );
    else
      htn = textNormFig( gca, fxlab, fylab, ['(b)'], 10 );
    end
    htn = textNormFig( gca, -.11, -.15,'t(s)', fs2 );
%     hxl = xlabel(['t(s) after ' sTime ' UT']);

    
  xsc1 = 0.07; xsc2 = 0.91; ysc1 = 0.12; ysc2 = .68; blue = [0.4,.4,1]; wid1 = 1; wid2 = 1.5; wid3 = 3; ticklen = [0.04 0.02];
  hgap=0.015; vgap=0.04;
  ms = 10;
  fxlab = .05; fylab = .9; 
  sXLab = 'L/L_{sc}';
  sYLab = 'N/L_{sc}';
  iskip = ceil((nt-1)/15);
  nL = 31; nLcut = 7;
  La = linspace(-Lmax,Lmax,nL); dL = La(2) - La(1);
  Lacut = linspace(-Lmax,Lmax,nLcut);
  [L2D,N2D] = meshgrid(La);
  [L2Dcut,N2Dcut] = meshgrid(Lacut);
  %   M2D = zeros(size(L2D));
  casc = [ 0 0 0 ; 1 0 0 ; 0 .8 0 ; .2 .2 1 ];
  fwh = .65; fsa = 13; fsxy = 15; fscby = 13; fscba = 12;
  
  if( i510sim==1 )
     % ************ IMPORTANT *************** only works for x/y/z = L/M/N without rotation
    load('LiuY3D_251_41_192_3_2_2.mat');
    % save(smat,'fl3D','ny','nx','nz','nc','nfl','ntdat','ny0','nx0','iy1','iy2','ix1','ix2','sfl','sc','st','x0','x','y','z');
    % fl3D = zeros(ny,nx,nz,3,2,2); % x/y/z, comp, B/J, time 1/2
    load('LiuYCut3D_pos.mat');     % save('LiuYCut3D_pos.mat','tt','ntt','ft1','ft2','xsc');    
    [Xg,Yg,Zg] = meshgrid(x,y,z);  
  end
  
  maxAbsValx = 0;
  l2D = zeros(nL); m2D = zeros(nL); n2D = zeros(nL);
  BL2D = zeros(nL); BM2D = zeros(nL); BN2D = zeros(nL);
  BL2Da = zeros(nL,nL,n41);   BM2Da = zeros(nL,nL,n41);   BN2Da = zeros(nL,nL,n41); 
  for ipl = 1:n41 % nt
    i = i41(ipl);
    
    if( i510sim==1 )
      
      fii = interp1(tt,ft1,t(i)); fip = 1 - fii;
      fl3Dt = squeeze( fii*fl3D(:,:,:,:,:,1) + fip*fl3D(:,:,:,:,:,2) );
      xsct = squeeze( interp1(tt,xsc,t(i)) );
      
      if( iAltOrigin>=11 && iAltOrigin<=14 )
        isc0 = iAltOrigin - 10;
        add0 = dsc;
      elseif( iAltOrigin>=1 && iAltOrigin<=4 )
        isc0 = iAltOrigin;
        add0 = 0;
      else
        isc0 = 5; % Centroid
        add0 = 0;
      end
      L2Dg = L2D*dsc + xsct(1,isc0) + add0;  % ***************** IMPORTANT with units, not normalized
      M2Dg = repmat( 0       + xsct(2,isc0) + add0 , size(L2Dg) );
      N2Dg = N2D*dsc + xsct(3,isc0) + add0;
      
      flgt = zeros(nL*nL,3,2);
      for ifl = 1:2
        for ic = 1:3
          flgt(:,ic,ifl) = interp3(Xg,Yg,Zg,squeeze(fl3Dt(:,:,:,ic,ifl)),L2Dg(:),M2Dg(:),N2Dg(:));
        end
      end
      flgt = reshape(flgt,[nL,nL,3,2]);
      BL2D = squeeze(flgt(:,:,1,1));
      BM2D = squeeze(flgt(:,:,2,1));
      BN2D = squeeze(flgt(:,:,3,1));
      
    else
      
      mv1 = squeeze(mv(i,:,:));
      for i1 = 1:nL
        for j1 = 1:nL
          Pos1 = [ L2D(j1,i1) 0 N2D(j1,i1) ];
          pos1 = Pos1 * mv1;
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
        BL2D = X1(j0+1) + X1(j0+2)*n2D + X1(j0+3)*l2D + X1(j0+4)*m2D ...
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
      
    end % i510sim
    
    if( iLocalBM==1 )
      maxAbsVal = maxAll( abs( BM2D(:)-B0fit(i,2) ) );
    else
      maxAbsVal = maxAll( abs( BM2D(:) ) );
    end
    maxAbsValx = max( maxAbsValx,maxAbsVal );
    
    BL2Da(:,:,ipl) = BL2D; BM2Da(:,:,ipl) = BM2D; BN2Da(:,:,ipl) = BN2D; 
    
  end % ipl
  
   zcolorM = [ -maxAbsValx ; 0 ; maxAbsValx ];
   colorsM = [ fwh fwh 1 ; 1 1 1 ;  1 fwh fwh ];
   colorM = colormap_colors(zcolorM,colorsM);
  
  for ipl = 1:n41 % nt
    i = i41(ipl);
    irow = i510lr;
    icol = ipl;
    
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
    for isl = 1:nsl
      ri = 1 + rand*(nL-1);
      ii = floor(ri);
      ip = 1 + ii;
      fip = ri - ii;
      fii = 1 - fip;
      Lsl(isl) = fii*La(ii) + fip*La(ip);
      csN1 = 0.5*( fii*csN(:,ii) + fip*csN(:,ip) );
      rj = 1 + rand*(nL-1);
      jj = floor(rj);
      jp = 1 + jj;
      fjp = rj - jj;
      fjj = 1 - fjp;
      Nsl(isl) = fjj*La(jj) + fjp*La(jp);
    end
        
    my_subplotrc4(nrow, ncol, irow, icol, xsc1, xsc2, ysc1, ysc2, hgap, vgap );
    imagesc(La,La',Bvar3);
    caxis([-maxAbsValx maxAbsValx])
    colormap(colorM);
    shading interp;
    if( ipl==n41) 
      hcb = colorbar;
      if( i510lr==1 )
        set(hcb,'Position',[xsc2 + .012,ysc1+(ysc2-ysc1)/2,.015,(ysc2-ysc1)/2]);
      else
        set(hcb,'Position',[xsc2 + .012,ysc1,.015,(ysc2-ysc1)/2]);
      end
      set(hcb,'FontSize',fscba);
      if( iRotate>0 )
        cblab = ylabel(hcb,{'B_{M}' '(nT)'});
      else
        cblab = ylabel(hcb,{'B_{Y}' '(nT)'});
      end
      set(cblab,'FontSize',fscby,'Rotation',0,'Units', 'Normalized'); %, 'Position', [3, .8, 0]);
      set(cblab,'Position',[3.8,.47,0]);
    end
    hold on
    hst = streamline(L2D,N2D,BL2D,BN2D,Lsl,Nsl);
    set(hst,'Color',gray)
    hst = streamline(L2D,N2D,-BL2D,-BN2D,Lsl,Nsl);
    set(hst,'Color',gray)
    %     contour(La,La',A2,25,'k');
    if( iLocalGradCoord==1 )
      for k = 1:4
        plot(xvn(i,1,k),xvn(i,3,k),'o','MarkerSize',6,'Color','w','MarkerFaceColor',casc(k,:));
      end
    else
      for k = 1:4
        plot(xv(i,1,k),xv(i,3,k),'o','MarkerSize',6,'Color','w','MarkerFaceColor',casc(k,:));
      end
    end
%     for k = 1:4
%       plot(xv(i,1,k),xv(i,3,k),'o','MarkerSize',4,'Linewidth',2,'Color',casc(k,:),'MarkerFaceColor',casc(k,:));
%     end
    hold off
    axis xy;
    axis square;
    set(gca,'TickLength',ticklen);
    set(gca,'TickDir','out');
    set(gca,'XMinorTick','on');
    set(gca,'YMinorTick','on');
    set(gca,'FontSize',fsa);
    if( irow==nrow ), xlabel(sXLab,'FontSize',fsxy); else, set(gca,'XTickLabel',''); end
    if( icol==1    ), ylabel(sYLab,'FontSize',fsxy); else, set(gca,'YTickLabel',''); end
%     title({['t = ' num2str(t(i)) ' s after ' sTime ' UT'] , ...
%       sprintf(['\x3BB=%0.2g/%0.2g/%0.2g, \x3B8_M=%0.2g, \x3C3' ...
%       '=%0.2g'],lambda(i,:),angMM0(i),dev(i))} ,'Fontsize',7);
%     htn = textNormFig( gca, fxlab, fylab, ['(' char('a'+ipl-1) ') t = ' num2str(t(i),4)], 11 )
    if( i510lr==1 )
      title(['(' char('c'+ipl-1) ') t = ' num2str(t(i),4)],'FontSize',10);
    else
      title(['(' char('g'+ipl-1) ') t = ' num2str(t(i),4)],'FontSize',10);
    end
%     set(htn,'Color',[1,.55,0],'HorizontalAlignment','left','FontWeight','bold');
%     set(htn,'Color','w','HorizontalAlignment','left','FontWeight','bold');
    drawnow;
  end % i
  if( iPlot510>=2 )
    sFile = [sDirPlots 'Poly_BLNspec510_BscOut' num2str(iScOutIn) '_Sim' num2str(i510sim) '_Brs' num2str(iBurst) '_Smo' num2str(nsmoothspan) '_Sub' num2str(iSubAvB) '_Rot' num2str(iRotate) '_noXRot' num2str(iNoXRotation) '_iSys' num2str(iSystem) '_iIncmprs' num2str(iIncmprs) '_iexctB' num2str(iExactB) '_iNF' num2str(iNormFlds) '_' num2str(wFlds(1)) '-' num2str(wFlds(2)) '-' num2str(wFlds(3)) '-' num2str(wFlds(4)) '-' num2str(wFlds(5)) '-' num2str(wFlds(6)) '_wB' num2str(wMag) '_iAltNe' num2str(iAltNe) '_iBMloc' num2str(iLocalBM) '_t' num2str(tlo,3) '-' num2str(thi,3) ];
    if( iPlot510==2 ), export_fig(sFile,'-pdf'); end
    save([sFile '.mat'],'iScOutIn','i510sim','iBurst','nsmoothspan','iSubAvB','iRotate','iNoXRotation',...
     'iSystem','iIncmprs','iExactB','iNormFlds','wFlds','iAltNe','iLocalBM','tlo','thi','t','nt','Lmax','X','iQuadSys','iv','mv','iLocalGradCoord','xv','xvn');
%     export_fig(sFile,'-pdf');
  %  export_fig(sFile,'-eps');
  end
end % iPlot510

%%
if( iPlot36>0 )
  figure(36)
  clf;
  set(gcf,'Color','w');
  set(gcf,'Position',[50,50,900,800]);
  xsc1 = 0.14; xsc2 = 0.98; ysc1 = 0.08; ysc2 = .95; blue = [0.4,.4,1]; wid1 = 1; wid2 = 1.5; wid3 = 3; ticklen = [0.02 0.01];
  ms = 10;
  vgap = 0.05;
  fxlab = .15; fylab = .8;
  sXLab = 'M/L_{sc}';
  sYLab = 'N/L_{sc}';
  iskip = ceil((nt-1)/15);
  nrow = 4;
  ncol = 4;
  npanels = nrow*ncol;
  nL = 31; nLcut = 7;
  La = linspace(-Lmax,Lmax,nL); dL = La(2) - La(1);
  Lacut = linspace(-Lmax,Lmax,nLcut);
  [L2D,N2D] = meshgrid(La);
  [L2Dcut,N2Dcut] = meshgrid(Lacut);
  %   M2D = zeros(size(L2D));
  casc = [ gray ; 1 0 0 ; 0 .8 0 ; .3 .3 1 ];
  fwh = .65;
  
  ipl = 0;
  %   maxAbsValx = 0;
  maxAbsValx = 3.3043;
  l2D = zeros(nL); m2D = zeros(nL); n2D = zeros(nL);
  BL2D = zeros(nL); BM2D = zeros(nL); BN2D = zeros(nL);
  for i = 1:iskip:nt % nt
    ipl = ipl + 1;
    
    mv1 = squeeze(mv(i,:,:));
    for i1 = 1:nL
      for j1 = 1:nL
        Pos1 = [ 0 L2D(j1,i1) N2D(j1,i1) ];
        pos1 = Pos1 * mv1;
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
    
    maxAbsVal = maxAll( abs( BM2D ) )
    maxAbsValx = max( maxAbsValx,maxAbsVal );
    zcolorM = [ -maxAbsVal ; 0 ; maxAbsVal ];
    colorsM = [ fwh fwh 1 ; 1 1 1 ;  1 fwh fwh ];
    colorM = colormap_colors(zcolorM,colorsM);
    
    subplot(nrow,ncol,ipl);
    imagesc(La,La',BM2D);
    caxis([-maxAbsVal maxAbsVal])
    colormap(colorM)
    shading interp;
    hcb = colorbar;
    cblab = ylabel(hcb,'B_M');
    set(cblab,'FontSize',9,'Rotation',0);
    hold on
    hst = streamline(L2D,N2D,BM2D,BN2D,L2Dcut,N2Dcut);
    set(hst,'Color','k')
    hst = streamline(L2D,N2D,-BM2D,-BN2D,L2Dcut,N2Dcut);
    set(hst,'Color','k')
    %     contour(La,La',A2,25,'k');
    for k = 1:4
      plot(xv(i,1,k),xv(i,3,k),'o','MarkerSize',3,'Linewidth',2,'Color',casc(k,:));
    end
    hold off
    axis xy;
    axis square;
    set(gca,'TickLength',ticklen);
    set(gca,'XMinorTick','on')
    set(gca,'YMinorTick','on')
    xlabel(sXLab,'FontSize',12);
    ylabel(sYLab,'FontSize',12);
    title({['t = ' num2str(t(i)) ' s after ' sTime ' UT'] , ...
      sprintf(['\x3BB=%0.2g/%0.2g/%0.2g, \x3B8_M=%0.2g, \x3C3' ...
      '=%0.2g'],lambda(i,:),angMM0(i),dev(i))} ,'Fontsize',7);
    %       textNormFig( gca, fxlab, fylab, ['(' sLabCol{icol} sLabRow{irow} ')'], 11 )
    drawnow;
  end % i
  if( iPlot36==2 ), export_fig([sDirPlots 'Poly_BMN_BscOut' num2str(iScOutIn) '_Brs' num2str(iBurst) '_Smo' num2str(nsmoothspan) '_Sub' num2str(iSubAvB) '_Rot' num2str(iRotate) '_noXRot' num2str(iNoXRotation) '_iSys' num2str(iSystem) '_iIncmprs' num2str(iIncmprs) '_iexctB' num2str(iExactB) '_iNF' num2str(iNormFlds) '_' num2str(wFlds(1)) '-' num2str(wFlds(2)) '-' num2str(wFlds(3)) '-' num2str(wFlds(4)) '-' num2str(wFlds(5)) '-' num2str(wFlds(6)) '_wB' num2str(wMag) '_iAltNe' num2str(iAltNe) '_t' num2str(tlo,3) '-' num2str(thi,3)  '.pdf '],'-pdf'); end
end % iPlot36


%%

if( iPlot52>0 )
  figure(52)
  clf;
  clear i41;
  set(gcf,'Color','w');
  set(gcf,'Position',[500,50,810,530]);
  
  % For bottom part
  xsc1 = 0.11; xsc2 = 0.45; ysc1 = 0.79; ysc2 = .96;
  ticklen = [0.04 0.02];
  fxlab = .94; fylab = .8;
  casc = [ gray ; 1 0 0 ; 0 .8 0 ; .3 .3 1 ];
  nrow = 2;
  ncol = 4;
  npanels = nrow*ncol;
  n41 = nrow*ncol;
  if( exist('i41','var')==0 )
      di41 = ( nt - 1 )/(n41-1);
      i41 = round( (1:di41:nt) );
  end
  if( numel(i41)~=n41 ), error(['numel(i41) = ' numel(i41) ' <> ' num2str(n41)]); end

  
    wid1 = 1.5; wid2 = 2; wid3 = 2; fs1 = 9; fs2 = 11;
  
    hax = my_subplotrc3(1,1, 1, 1, xsc1,xsc2,ysc1,ysc2);
    h1 = plot(t,bavv(:,1),'Color',casc(4,:),'Linewidth',wid1);
    xlim([t(1) t(end)])
    hold on
    h2 = plot(t,bavv(:,2),'Color',casc(3,:),'Linewidth',wid1);
    h3 = plot(t,bavv(:,3),'Color',casc(2,:),'Linewidth',wid1);
    plot([t(1),t(end)],[0 0],'k:','Linewidth',wid2);
    ylim1 = get(gca,'YLim');
    ylab = ylim1(1) + (ylim1(2)-ylim1(1))*1.15;
    for ipl = 1:n41
        plot([t(i41(ipl)) t(i41(ipl))],ylim1,':','Color',[.2,.2,.2],'LineWidth',1);
        text(t(i41(ipl)),ylab,[char('c'+ipl-1)]);
    end
    hold off
    set(gca,'Fontsize',11);
    set(gca,'TickLength',ticklen);
    set(gca,'XMinorTick','on');
    set(gca,'YMinorTick','on');
    if( iRotate>0 )
      ylabel({'{\bfB}_{av} LMN' '(nT)'},'Fontsize',fs2);
    else
      ylabel({'{\bfB}_{av} GSE' '(nT)'},'Fontsize',fs2);
    end
    htn = textNormFig( gca, fxlab, fylab, ['(a)'], 10 );
    htn = textNormFig( gca, -.03, -.16,'t(s)', fs2 );
%     hxl = xlabel(['t(s) after ' sTime ' UT']);

    
  xsc1 = 0.07; xsc2 = 0.91; ysc1 = 0.11; ysc2 = .7; blue = [0.4,.4,1]; wid1 = 1; wid2 = 1.5; wid3 = 3; ticklen = [0.04 0.02];
  hgap=0.015; vgap=0.04;
  ms = 10;
  fxlab = .05; fylab = .9;
  sXLab = 'M/L_{sc}';
  sYLab = 'N/L_{sc}';
  iskip = ceil((nt-1)/15);
  nL = 31; nLcut = 7;
  La = linspace(-Lmax,Lmax,nL); dL = La(2) - La(1);
  Lacut = linspace(-Lmax,Lmax,nLcut);
  [L2D,N2D] = meshgrid(La);
  [L2Dcut,N2Dcut] = meshgrid(Lacut);
  %   M2D = zeros(size(L2D));
  casc = [ gray ; 1 0 0 ; 0 .8 0 ; .2 .2 1 ];
  fwh = .55;
  
  maxAbsValx = 0;
  l2D = zeros(nL); m2D = zeros(nL); n2D = zeros(nL);
  BL2D = zeros(nL); BM2D = zeros(nL); BN2D = zeros(nL);
  BL2Da = zeros(nL,nL,n41);   BM2Da = zeros(nL,nL,n41);   BN2Da = zeros(nL,nL,n41); 
  for ipl = 1:n41 % nt
    i = i41(ipl);
    
    mv1 = squeeze(mv(i,:,:));
    for i1 = 1:nL
      for j1 = 1:nL
        Pos1 = [ 0 L2D(j1,i1) N2D(j1,i1) ];
        pos1 = Pos1 * mv1;
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
    elseif( iSystem==9 ) 
      % B_s,L
      j0 = 0;
      BL2D = X1(j0+1) + X1(j0+2)*n2D + X1(j0+3)*l2D + X1(j0+4)*m2D ...
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
    
    if( iLocalBM==1 )
      maxAbsVal = maxAll( abs( BM2D(:)-B0fit(i,2) ) );
    else
      maxAbsVal = maxAll( abs( BM2D(:) ) );
    end
    maxAbsValx = max( maxAbsValx,maxAbsVal );
    
    BL2Da(:,:,ipl) = BL2D; BM2Da(:,:,ipl) = BM2D; BN2Da(:,:,ipl) = BN2D; 
    
  end % ipl
  
   zcolorM = [ -maxAbsValx ; 0 ; maxAbsValx ];
   colorsM = [ fwh fwh 1 ; 1 1 1 ;  1 fwh fwh ];
   colorM = colormap_colors(zcolorM,colorsM);
  
  for ipl = 1:n41 % nt
    i = i41(ipl);
    irow = floor((ipl-1)/ncol) + 1;
    icol = ipl - (irow-1)*ncol;
    
    BL2D = squeeze(BL2Da(:,:,ipl)); BM2D = squeeze(BM2Da(:,:,ipl)); BN2D = squeeze(BN2Da(:,:,ipl)); 
    if( iLocalBM==1 )
      Bvar3 = BM2D-B0fit(i,2);
    else
      Bvar3 = BM2D;
    end
    
    BLN2D = sqrt( BM2D.^2 + BN2D.^2 );
    csN = cumsum( BLN2D , 1 );
    csL = cumsum( csN(end,:) );
    csL = csL/csL(end);
    for ii = 1:nL
      csN(:,ii) = csN(:,ii)/csN(end,ii);
    end
    nsl = 131;
    Lsl = zeros(nsl,1);
    Nsl = zeros(nsl,1);
    for isl = 1:nsl
      ri = 1 + rand*(nL-1);
      ii = floor(ri);
      ip = 1 + ii;
      fip = ri - ii;
      fii = 1 - fip;
      Lsl(isl) = fii*La(ii) + fip*La(ip);
      csN1 = 0.5*( fii*csN(:,ii) + fip*csN(:,ip) );
      rj = 1 + rand*(nL-1);
      jj = floor(rj);
      jp = 1 + jj;
      fjp = rj - jj;
      fjj = 1 - fjp;
      Nsl(isl) = fjj*La(jj) + fjp*La(jp);
    end
    
    my_subplotrc4(nrow, ncol, irow, icol, xsc1, xsc2, ysc1, ysc2, hgap, vgap );
    imagesc(La,La',Bvar3);
    caxis([-maxAbsVal maxAbsVal]);
    colormap(colorM);
    shading interp;
    if( ipl==n41) 
      hcb = colorbar;
      set(hcb,'Position',[xsc2 + .015,ysc1,.015,ysc2-ysc1]);
      if( iRotate>0 )
        cblab = ylabel(hcb,{'B_{M}' '(nT)'});
      else
        cblab = ylabel(hcb,{'B_{Y}' '(nT)'});
      end
      set(cblab,'FontSize',9,'Rotation',0,'Units', 'Normalized'); %, 'Position', [3, .8, 0]);
    end
    hold on
    hst = streamline(L2D,N2D,BM2D,BN2D,Lsl,Nsl);
    set(hst,'Color',gray)
    hst = streamline(L2D,N2D,-BM2D,-BN2D,Lsl,Nsl);
    set(hst,'Color',gray)
    %     contour(La,La',A2,25,'k');
    for k = 1:4
      plot(xv(i,1,k),xv(i,3,k),'o','MarkerSize',6,'Color','w','MarkerFaceColor',casc(k,:));
    end
    hold off
    axis xy;
    axis square;
    set(gca,'TickLength',ticklen);
    set(gca,'TickDir','out');
    set(gca,'XMinorTick','on');
    set(gca,'YMinorTick','on');
    set(gca,'FontSize',10);
    if( irow==nrow ), xlabel(sXLab,'FontSize',12); else, set(gca,'XTickLabel',''); end
    if( icol==1    ), ylabel(sYLab,'FontSize',12); else, set(gca,'YTickLabel',''); end
%     title({['t = ' num2str(t(i)) ' s after ' sTime ' UT'] , ...
%       sprintf(['\x3BB=%0.2g/%0.2g/%0.2g, \x3B8_M=%0.2g, \x3C3' ...
%       '=%0.2g'],lambda(i,:),angMM0(i),dev(i))} ,'Fontsize',7);
%     htn = textNormFig( gca, fxlab, fylab, ['(' char('a'+ipl-1) ') t = ' num2str(t(i),4)], 11 )
    title(['(' char('c'+ipl-1) ') t = ' num2str(t(i),4)],'FontSize',10);
%     set(htn,'Color',[1,.55,0],'HorizontalAlignment','left','FontWeight','bold');
%     set(htn,'Color','w','HorizontalAlignment','left','FontWeight','bold');
    drawnow;
  end % i
  if( iPlot52==2 ), export_fig([sDirPlots 'Poly_BMNspec_BscOut' num2str(iScOutIn) '_Brs' num2str(iBurst) '_Smo' num2str(nsmoothspan) '_Sub' num2str(iSubAvB) '_Rot' num2str(iRotate) '_noXRot' num2str(iNoXRotation) '_iSys' num2str(iSystem) '_iIncmprs' num2str(iIncmprs) '_iexctB' num2str(iExactB) '_iNF' num2str(iNormFlds) '_' num2str(wFlds(1)) '-' num2str(wFlds(2)) '-' num2str(wFlds(3)) '-' num2str(wFlds(4)) '-' num2str(wFlds(5)) '-' num2str(wFlds(6)) '_wB' num2str(wMag) '_iAltNe' num2str(iAltNe) '_iBMloc' num2str(iLocalBM) '_t' num2str(tlo,3) '-' num2str(thi,3)  '.pdf '],'-pdf'); end
end % iPlot52

%%

if( iPlot37>0 )
  figure(37)
  clf;
  if( iPlot37==2 ), vidfile = VideoWriter([sDirPlots 'Poly_movie_Brs' num2str(iBurst) '_Smo' num2str(nsmoothspan) '_Sub' num2str(iSubAvB) '_Rot' num2str(iRotate) '_noXRot' num2str(iNoXRotation) '_iSys' num2str(iSystem) '_iIncmprs' num2str(iIncmprs) '_iexctB' num2str(iExactB) '_iNF' num2str(iNormFlds) '_' num2str(wFlds(1)) '-' num2str(wFlds(2)) '-' num2str(wFlds(3)) '-' num2str(wFlds(4)) '-' num2str(wFlds(5)) '-' num2str(wFlds(6)) '_wB' num2str(wMag) '_iAltNe' num2str(iAltNe) '_t' num2str(tlo,3) '-' num2str(thi,3) '.mp4'],'MPEG-4'); end
  if( iPlot37==2 ), open(vidfile); end
  set(gcf,'Color','w');
  set(gcf,'Position',[700,200,650,750]);
  xsc11 = .2; xsc12 = .98;
  xsc1 = 0.13; xsc2 = 0.98; ysc1 = 0.09; ysc2 = .4; ysc3 = .51; ysc4 = .99; blue = [0.4,.4,1];
  ticklen = [0.04 0.02];
  ms = 10;
  vgap = 0.05;
  fxlab = .15; fylab = .8;
  if( iRotate>0 )
    sXLab = 'L/L_{sc}';
    sXLabm = 'M/L_{sc}';
    sYLab = 'N/L_{sc}';
  else
    sXLab = 'X/L_{sc}';
    sXLabm = 'Y/L_{sc}';
    sYLab = 'Z/L_{sc}';
  end
  nrow = 4;
  ncol = 4;
  nL = 31; nLcut = 11;  nLx = 201;
  La = linspace(-Lmax,Lmax,nL); dL = La(2) - La(1);
  Lacut = linspace(-Lmax,Lmax,nLcut);
  Lax = linspace(-Lmax,Lmax,nLx);
  [L2D,N2D] = meshgrid(La);
  [L2Dcut,N2Dcut] = meshgrid(Lacut);
  [L2Dx,N2Dx] = meshgrid(Lax);
  
  Lax = linspace(-Lmax,Lmax,nLx);
  casc = [ gray ; 1 0 0 ; 0 .8 0 ; .3 .3 1 ];
  fwh = .55;
  
  lambda23 = lambda(:,2)./lambda(:,3);
  fyrange = [ .8 .875 .95 ];
  cprob = [ 0 .8 0 ; 0 0 0 ; 1 0 1 ];
  wid0 = .5; wid1 = .75; wid2 = 1; wid3 = 2; fs1 = 9; fs2 = 12;
  
  ipl = 0;
  maxAbsValx1 = 0;
  maxAbsValx = 3;
  LNBmina = NaN(nt,5); % Lmin, Nmin, BLNmin
  if( iNormD == 1 )
    mingrads = (.1)^2/Bnorms;
  else
    mingrads = (.1/dsc)^2;
  end
  l2D = zeros(nL); m2D = zeros(nL); n2D = zeros(nL);
  l2Dm = zeros(nL); m2Dm = zeros(nL); n2Dm = zeros(nL);
  BL2D = zeros(nL); BM2D = zeros(nL); BN2D = zeros(nL);
  BL2Dm = zeros(nL); BM2Dm = zeros(nL); BN2Dm = zeros(nL);
  if( iPlot37==6 )
    iend = 1;
  else
    iend = nt;
  end
  for i = 1:iMovieStep:iend  % 1 % ***nt
    
    my_subplotrc3(5,1,1,1,xsc1,xsc2,ysc3,ysc4)
    semilogy(t,lambda(:,1),'Color',casc(4,:),'Linewidth',wid1)
    hold on
    semilogy(t,lambda(:,2),'Color',casc(3,:),'Linewidth',wid1)
    semilogy(t,lambda(:,3),'Color',casc(2,:),'Linewidth',wid1)
    semilogy([t(1),t(end)],[mingrads mingrads],'k:','Linewidth',wid2)
    if( iNormFlds==1 ), ylim([1.e-6 1.]); else, ylim([1.e-3 100.]); end 
    ylim1 = get(gca,'YLim');
    plot([t(i),t(i)],ylim1,'k','Linewidth',wid3)
    hold off
    xlim([t(1) t(end)])
    set(gca,'XTickLabel','')
    set(gca,'YTick',[1.e-8 1.e-7 1.e-6 1.e-5 1.e-4 1.e-3 .01 .1 1 10 100 1000 10000])
    if( iNormFlds==1 )
      ylabel({'\lambda_{MDDB}' '(B_0/L_{sc})^2'},'Fontsize',fs2)
    else
      ylabel({'\lambda_{MDDB}' '(nT/km)^2'},'Fontsize',fs2)
    end
    
    sYLaba = { '{\bfe}_{l}' '{\bfe}_{m}' '{\bfe}_{n}' };
    for ic = 1:3
      my_subplotrc3(5,1,ic+1,1,xsc1,xsc2,ysc3,ysc4)
      plot(t,mvcalc(:,1,ic,1),'Color',casc(4,:),'Linewidth',wid1)
      hold on
      plot(t,mvcalc(:,2,ic,1),'Color',casc(3,:),'Linewidth',wid1)
      plot(t,mvcalc(:,3,ic,1),'Color',casc(2,:),'Linewidth',wid1)
      plot([t(1),t(end)],[0 0],'k:','Linewidth',wid2)
      ylim([-1 1])
      ylim1 = get(gca,'YLim');
      plot([t(i),t(i)],ylim1,'k','Linewidth',wid3)
      hold off
      xlim([t(1) t(end)])
      if( iRotate>0 )
        ylabel({sYLaba{ic} 'LMN'},'Fontsize',fs2)
      else
        ylabel({sYLaba{ic} 'GSE'},'Fontsize',fs2)
      end
      set(gca,'XTickLabel','')
    end
    
    hax = my_subplotrc3(5,1, 5, 1, xsc1,xsc2,ysc3,ysc4);
    h1 = plot(t,bavv(:,1),'Color',casc(4,:),'Linewidth',wid1)
    xlim([t(1) t(end)])
    hold on
    h2 = plot(t,bavv(:,2),'Color',casc(3,:),'Linewidth',wid1)
    h3 = plot(t,bavv(:,3),'Color',casc(2,:),'Linewidth',wid1)
    plot([t(1),t(end)],[0 0],'k:','Linewidth',wid2)
    ylim1 = get(gca,'YLim');
    plot([t(i),t(i)],ylim1,'k','Linewidth',wid3)
    %     isel = find(angMM0>30);
    %     plot( t(isel),repmat(ylim1(1)+fyrange(1)*(ylim1(2)-ylim1(1)),[numel(isel),1]) ...
    %       ,'x','Color',cprob(1,:))
    %     isel = find(lambda23<7);
    %     plot( t(isel),repmat(ylim1(1)+fyrange(2)*(ylim1(2)-ylim1(1)),[numel(isel),1]) ...
    %       ,'x','Color',cprob(2,:))
    %     isel = find(dev>.07);
    %     plot( t(isel),repmat(ylim1(1)+fyrange(3)*(ylim1(2)-ylim1(1)),[numel(isel),1]) ...
    %       ,'x','Color',cprob(3,:))
    hold off
    set(gca,'Fontsize',11);
    set(gca,'TickLength',ticklen);
    set(gca,'XMinorTick','on')
    set(gca,'YMinorTick','on')
    if( iRotate>0 )
      ylabel({'{\bfB}_{av} LMN' '(nT)'},'Fontsize',fs2);
    else
      ylabel({'{\bfB}_{av} GSE' '(nT)'},'Fontsize',fs2);
    end
    hxl = xlabel(['t(s) after ' sTime ' UT']);
    set(hxl, 'Units', 'Normalized', 'Position', [0.5, -.33, 0])
    %       hlg = gridLegend([h1 h2 h3],3,{'L' 'M' 'N'},'Fontsize',8,'Box','off','Position',[xsc11,ysc4,xsc12-xsc11,1-ysc4]);
    %     set(hax,'Position',[xsc11,ysc3,xsc12-xsc11,ysc4-ysc3])
    %       set(hlg,'Position',[xsc11,ysc4,xsc12-xsc11,1-ysc4])
    %       pause(.2)
    
    mv1 = squeeze(mv(i,:,:));
    for i1 = 1:nL
      for j1 = 1:nL
        Pos1 = [ L2D(j1,i1) 0 N2D(j1,i1) ];
        pos1 = Pos1 * mv1;
        l2D(j1,i1) = pos1(1);
        m2D(j1,i1) = pos1(2);
        n2D(j1,i1) = pos1(3);
        
        Pos1 = [ 0  L2D(j1,i1) N2D(j1,i1) ];
        pos1 = Pos1 * mv1;
        l2Dm(j1,i1) = pos1(1);
        m2Dm(j1,i1) = pos1(2);
        n2Dm(j1,i1) = pos1(3);
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
      % B_s,L
      j0 = 0;
      Bl2Dm = X1(j0+1) + X1(j0+2)*n2Dm + X1(j0+3)*l2Dm + X1(j0+4)*n2Dm.^2/2;
      % B_s,M
      j0 = 4;
      Bm2Dm = X1(j0+1) + X1(j0+2)*n2Dm + X1(j0+3)*l2Dm +  ...
        + X1(j0+4)*n2Dm.^2/2 + X1(j0+5)*l2Dm.^2/2 + X1(j0+6)*n2Dm.*l2Dm;
      % B_s,N
      j0 = 10;
      Bn2Dm = X1(j0+1) + X1(j0+2)*n2Dm + X1(j0+3)*l2Dm + X1(j0+4)*l2Dm.^2/2;
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
      % B_s,L
      j0 = 0;
      Bl2Dm = X1(j0+1) + X1(j0+2)*n2Dm + X1(j0+3)*l2Dm + X1(j0+4)*m2Dm ...
        + X1(j0+5)*n2Dm.^2/2;
      % B_s,M
      j0 = 5;
      Bm2Dm = X1(j0+1) + X1(j0+2)*n2Dm + X1(j0+3)*l2Dm + X1(j0+4)*m2Dm ...
        + X1(j0+5)*n2Dm.^2/2 + X1(j0+6)*l2Dm.^2/2 ...
        + X1(j0+7)*n2Dm.*l2Dm;
      % B_s,N
      j0 = 12;
      Bn2Dm = X1(j0+1) + X1(j0+2)*n2Dm + X1(j0+3)*l2Dm + X1(j0+4)*m2Dm ...
        + X1(j0+5)*l2Dm.^2/2;
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
      % B_s,L
      j0 = 0;
      Bl2Dm = X1(j0+1) + X1(j0+2)*n2Dm + X1(j0+3)*m2Dm + X1(j0+4)*l2Dm ...
        + X1(j0+5)*n2Dm.^2/2 + X1(j0+6)*m2Dm.^2/2 + X1(j0+7)*n2Dm.*m2Dm;
      % B_s,M
      j0 = 7;
      Bm2Dm = X1(j0+1) + X1(j0+2)*n2Dm + X1(j0+3)*m2Dm + X1(j0+4)*l2Dm ...
        + X1(j0+5)*n2Dm.^2/2;
      % B_s,N
      j0 = 12;
      Bn2Dm = X1(j0+1) + X1(j0+2)*n2Dm + X1(j0+3)*m2Dm + X1(j0+4)*l2Dm ...
        + X1(j0+5)*m2Dm.^2/2;
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
      nnn2Dm = n2Dm.^3/6;
      lll2Dm = l2Dm.^3/6;
      nnl2Dm = n2Dm.^2.*l2Dm/2;
      nnm2Dm = n2Dm.^2.*m2Dm/2;
      lln2Dm = l2Dm.^2.*n2Dm/2;
      llm2Dm = l2Dm.^2.*m2Dm/2;
      nlm2Dm = n2Dm.*l2Dm.*m2Dm;
      % B_s,L
      j0 = 0;
      Bl2Dm = X1(j0+1) + X1(j0+2)*n2Dm + X1(j0+3)*l2Dm + X1(j0+4)*m2Dm ...
        + X1(j0+5)*n2Dm.^2/2 + X1(j0+6)*l2Dm.^2/2 ...
        + X1(j0+7)*n2Dm.*l2Dm + X1(j0+8)*n2Dm.*m2Dm + X1(j0+9)*l2Dm.*m2Dm ...
        + X1(28)*nnm2Dm + X1(32)*nnn2Dm + X1(36)*nnl2Dm + X1(37)*lln2Dm + X1(38)*lll2Dm + X1(39)*nlm2Dm + X1(40)*llm2Dm;
      % B_s,M
      j0 = 9;
      Bm2Dm = X1(j0+1) + X1(j0+2)*n2Dm + X1(j0+3)*l2Dm + X1(j0+4)*m2Dm ...
        + X1(j0+5)*n2Dm.^2/2 + X1(j0+6)*l2Dm.^2/2 ...
        + X1(j0+7)*n2Dm.*l2Dm + X1(j0+8)*n2Dm.*m2Dm + X1(j0+9)*l2Dm.*m2Dm ...
        + X1(29)*nnl2Dm + X1(30)*lln2Dm + X1(33)*nnn2Dm + X1(34)*lll2Dm;
      % B_s,N
      j0 = 18;
      Bn2Dm = X1(j0+1) + X1(j0+2)*n2Dm + X1(j0+3)*l2Dm + X1(j0+4)*m2Dm ...
        + X1(j0+5)*n2Dm.^2/2 + X1(j0+6)*l2Dm.^2/2 ...
        + X1(j0+7)*n2Dm.*l2Dm + X1(j0+8)*n2Dm.*m2Dm + X1(j0+9)*l2Dm.*m2Dm ...
        + X1(31)*llm2Dm + X1(35)*lll2Dm - X1(36)*nnn2Dm - X1(37)*nnl2Dm - X1(38)*lln2Dm - X1(39)*nnm2Dm - X1(40)*nlm2Dm;
    else
      % B_s,L
      j0 = 0;
      Bl2D = X1(iv(j0+1)) + X1(iv(j0+2))*n2D + X1(iv(j0+3))*l2D  ...
        + X1(iv(j0+4))*n2D.^2/2 + X1(iv(j0+5))*n2D.*l2D + X1(iv(j0+6))*l2D.^2/2;
      Bl2Dm = X1(iv(j0+1)) + X1(iv(j0+2))*n2Dm + X1(iv(j0+3))*l2Dm  ...
        + X1(iv(j0+4))*n2Dm.^2/2 + X1(iv(j0+5))*n2Dm.*l2Dm + X1(iv(j0+6))*l2Dm.^2/2;
      if( iQuadSys==-1 )
        Bl2D = Bl2D + X1(iv(j0+7))*m2D + X1(iv(j0+8))*n2D.*m2D + X1(iv(j0+9))*l2D.*m2D + X1(28)*n2D.^3/6;
        Bl2Dm = Bl2Dm + X1(iv(j0+7))*m2Dm + X1(iv(j0+8))*n2Dm.*m2Dm + X1(iv(j0+9))*l2Dm.*m2Dm + X1(28)*n2Dm.^3/6;
      elseif( iQuadSys==0 )
        Bl2D = Bl2D + X1(iv(j0+7))*m2D + X1(iv(j0+8))*n2D.*m2D + X1(iv(j0+9))*l2D.*m2D;
        Bl2Dm = Bl2Dm + X1(iv(j0+7))*m2Dm + X1(iv(j0+8))*n2Dm.*m2Dm + X1(iv(j0+9))*l2Dm.*m2Dm;
      elseif( iQuadSys==1 )
        Bl2D = Bl2D + X1(iv(j0+7))*m2D + X1(iv(j0+8))*n2D.*m2D;
        Bl2Dm = Bl2Dm + X1(iv(j0+7))*m2Dm + X1(iv(j0+8))*n2Dm.*m2Dm;
      elseif( iQuadSys==2 )
        Bl2D = Bl2D + X1(iv(j0+7))*m2D;
        Bl2Dm = Bl2Dm + X1(iv(j0+7))*m2Dm;
      end
      % B_s,M
      j0 = 9;
      Bm2D = X1(iv(j0+1)) + X1(iv(j0+2))*n2D + X1(iv(j0+3))*l2D  ...
        + X1(iv(j0+4))*n2D.^2/2 + X1(iv(j0+5))*n2D.*l2D + X1(iv(j0+6))*l2D.^2/2;
      Bm2Dm = X1(iv(j0+1)) + X1(iv(j0+2))*n2Dm + X1(iv(j0+3))*l2Dm  ...
        + X1(iv(j0+4))*n2Dm.^2/2 + X1(iv(j0+5))*n2Dm.*l2Dm + X1(iv(j0+6))*l2Dm.^2/2;
      if( iQuadSys<1 )
        Bm2D = Bm2D + X1(iv(j0+7))*m2D + X1(iv(j0+8))*n2D.*m2D + X1(iv(j0+9))*l2D.*m2D;
        Bm2Dm = Bm2Dm + X1(iv(j0+7))*m2Dm + X1(iv(j0+8))*n2Dm.*m2Dm + X1(iv(j0+9))*l2Dm.*m2Dm;
      elseif( iQuadSys==1 )
        Bm2D = Bm2D + X1(iv(j0+7))*m2D + X1(iv(j0+8))*n2D.*m2D;
        Bm2Dm = Bm2Dm + X1(iv(j0+7))*m2Dm + X1(iv(j0+8))*n2Dm.*m2Dm;
      elseif( iQuadSys==2 )
        Bm2D = Bm2D + X1(iv(j0+7))*m2D;
        Bm2Dm = Bm2Dm + X1(iv(j0+7))*m2Dm;
      end
      % B_s,N
      j0 = 18;
      Bn2D = X1(iv(j0+1)) + X1(iv(j0+2))*n2D + X1(iv(j0+3))*l2D  ...
        + X1(iv(j0+4))*n2D.^2/2 + X1(iv(j0+5))*n2D.*l2D + X1(iv(j0+6))*l2D.^2/2;
      Bn2Dm = X1(iv(j0+1)) + X1(iv(j0+2))*n2Dm + X1(iv(j0+3))*l2Dm  ...
        + X1(iv(j0+4))*n2Dm.^2/2 + X1(iv(j0+5))*n2Dm.*l2Dm + X1(iv(j0+6))*l2Dm.^2/2;
      if( iQuadSys<1 )
        Bn2D = Bn2D + X1(iv(j0+7))*m2D + X1(iv(j0+8))*n2D.*m2D + X1(iv(j0+9))*l2D.*m2D;
        Bn2Dm = Bn2Dm + X1(iv(j0+7))*m2Dm + X1(iv(j0+8))*n2Dm.*m2Dm + X1(iv(j0+9))*l2Dm.*m2Dm;
      elseif( iQuadSys<3 )
        Bn2D = Bn2D + X1(iv(j0+7))*m2D;
        Bn2Dm = Bn2Dm + X1(iv(j0+7))*m2Dm;
      end
    end % iSystem
    
    mv1p = mv1';
    for i1 = 1:nL
      for j1 = 1:nL
        mag1 = [ Bl2D(j1,i1) Bm2D(j1,i1) Bn2D(j1,i1) ];
        Mag1 = mag1 * mv1p;
        BL2D(j1,i1) = Mag1(1);
        BM2D(j1,i1) = Mag1(2);
        BN2D(j1,i1) = Mag1(3);
        
        mag1 = [ Bl2Dm(j1,i1) Bm2Dm(j1,i1) Bn2Dm(j1,i1) ];
        Mag1 = mag1 * mv1p;
        BL2Dm(j1,i1) = Mag1(1);
        BM2Dm(j1,i1) = Mag1(2);
        BN2Dm(j1,i1) = Mag1(3);
      end
    end
    
    % Find X points
    %     Lmin = NaN; Nmin = NaN; BLNmin = NaN; BLrat = NaN; BNrat = NaN;
    BL2Dx = interp2(L2D,N2D,BL2D,L2Dx,N2Dx);
    BN2Dx = interp2(L2D,N2D,BN2D,L2Dx,N2Dx);
    BLNx = sqrt( BL2Dx.^2 + BN2Dx.^2 );
    [jx,ix,BLNmin] = find( BLNx==min(BLNx(:)) , 1 );
    if( jx>1 && jx<nLx && ix>1 && ix<nLx )
      Lmin = Lax(ix); Nmin = Lax(jx); BLNmin = BLNx(jx,ix);
      BLrat = BL2Dx(jx+1,ix)/BL2Dx(jx-1,ix); BNrat = BN2Dx(jx,ix+1)/BN2Dx(jx,ix-1);
      if( BLrat<0 )
        LNBmina(i,:) = [Lmin Nmin BLNmin BLrat BNrat];
        
        if( iPlot40>0 )
          figure(40)
          set(gcf,'Position',[100,700,300,300]);
          imagesc(Lax,Lax,BLNx)
          axis xy
          hold on
          %         plot(Lmin,Nmin,'x','MarkerSize',4,'Linewidth',3,'Color','m');
          hold off
          figure(37)
        end
      end
    end
    
    % Find X points
    %     BLN = sqrt( BL2D.^2 + BN2D.^2 );
    %     Lmin = []; Nmin = [];
    %     LNrev = zeros(nL,nL);
    %     for i1 = nL-1:-1:2
    %       for j1 = nL-1:-1:2
    %         if( BL2D(j1+1,i1)/BL2D(j1-1,i1)<0 )
    %           LNrev(j1,i1) = 10;
    %         end
    %         if( BN2D(j1,i1+1)/BN2D(j1,i1-1)<0 )
    %           LNrev(j1,i1) = LNrev(j1,i1) + 1;
    %         end
    %       end
    %     end
    
    %     for i1 = nL-1:-1:2
    %       for j1 = nL-1:-1:2
    %         if( BL2D(j1+1,i1)/BL2D(j1-1,i1)<0 && BN2D(j1,i1+1)/BN2D(j1,i1-1)<0 )
    %           LNBmina(i,:) = [La(i1) La(j1) 0];
    % %           fNp = abs(BL2D(j1,i1))/(abs(BL2D(j1,i1))+abs(BL2D(j1+1,i1)));
    % %           fLp = abs(BN2D(j1,i1))/(abs(BN2D(j1,i1))+abs(BN2D(j1,i1+1)));
    % %           Nmin = La(j1)+fNp*dL;
    % %           Lmin = La(i1)+fLp*dL;
    % %           fNm = 1 - fNp;
    % %           fLm = 1 - fLp;
    % %           BLNmin = fNm*( fLm*BLN(j1,i1) + fLp*BLN(j1,i1+1) ) + fNp*( fLm*BLN(j1+1,i1) + fLp*BLN(j1+1,i1+1) )
    % %           LNBmina(i,:) = [Lmin Nmin BLNmin];
    %           continue;
    %         end
    %       end
    %      end
    
    %     BLN = sqrt( BL2D.^2 + BN2D.^2 );
    %     % Find minimum
    %     BLNi = zeros(1,nL); Nmini = zeros(1,nL);
    %     for i1 = 1:nL
    %       jj = find(BLN(:,i1)==min(BLN(:,i1)),1);
    %       if( jj==1 || jj==nL )
    %         BLNi(i1) = BLN(jj,i1);
    %         Nmini(i1) = La(jj);
    %       else
    %         [ BLNi(i1),djj,djp,fjj,fjp ] = extremum3( BLN(jj-1:jj+1,i1) );
    %         Nmini(i1) = fjj*La(jj+(djj-2)) + fjp*La(jj+(djp-2));
    %       end
    %     end
    %     ii = find(BLNi==min(BLNi),1);
    %     if( ii==1 || ii==nL )
    %       BLNmin = BLNi(ii);
    %       Lmin = La(ii);
    %       Nmin = Nmini(ii);
    %     else
    %       [ BLNmin,dii,dip,fii,fip ] = extremum3( BLNi(ii-1:ii+1) );
    %       Lmin = fii*La(ii+(dii-2)) + fip*La(ii+(dip-2));
    %       Nmin = fii*Nmini(ii+(dii-2)) + fip*Nmini(ii+(dip-2))
    %     end
    %     LNBmina(i,:) = [Lmin Nmin BLNmin];
    
    if( iLocalBM==1 )
      maxAbsVal = maxAll( abs( [ BM2D(:)-B0fit(i,2) ; BM2Dm(:)-B0fit(i,2) ] ) );
    else
      maxAbsVal = maxAll( abs( [ BM2D(:) ; BM2Dm(:) ] ) );
    end
    maxAbsValx1 = max( maxAbsValx1,maxAbsVal );
    zcolorM = [ -maxAbsVal ; 0 ; maxAbsVal ];
    colorsM = [ fwh fwh 1 ; 1 1 1 ;  1 fwh fwh ];
    colorM = colormap_colors(zcolorM,colorsM);
    
    for i12 = 1:2
      if( i12==1 )
        Bvar1 = BL2D;
        Bvar2 = BN2D;
        if( iLocalBM==1 )
          Bvar3 = BM2D-B0fit(i,2);
        else
          Bvar3 = BM2D;
        end
      else
        Bvar1 = BM2Dm;
        Bvar2 = BN2Dm;
        if( iLocalBM==1 )
          Bvar3 = BM2Dm-B0fit(i,2);
        else
          Bvar3 = BM2Dm;
        end
      end
      my_subplotrc4(1,2, 1, i12, .11,.87,ysc1,ysc2,.06,0);
      imagesc(La,La',Bvar3);
      caxis([-maxAbsVal maxAbsVal])
      colormap(colorM)
      shading interp;
      if( i12==2 )
        hcb = colorbar;
        set(hcb,'Position',[.9,ysc1,.025,ysc2-ysc1])
        if( iRotate>0 )
          cblab = ylabel(hcb,{'B_{M}' '(nT)'});
        else
          cblab = ylabel(hcb,{'B_{Y}' '(nT)'});
        end
        set(cblab,'FontSize',9,'Rotation',0,'Units', 'Normalized', 'Position', [3, .85, 0]);
      end
      hold on
      hst = streamline(L2D,N2D,Bvar1,Bvar2,L2Dcut,N2Dcut);
      set(hst,'Color','k')
      hst = streamline(L2D,N2D,-Bvar1,-Bvar2,L2Dcut,N2Dcut);
      set(hst,'Color','k')
      for k = 1:4
        if( i12==1 )
          plot(xv(i,1,k),xv(i,3,k),'o','MarkerSize',4,'Linewidth',3,'Color',casc(k,:));
        else
          plot(xv(i,2,k),xv(i,3,k),'o','MarkerSize',4,'Linewidth',3,'Color',casc(k,:));
        end
      end
      %       if( i12==1 ), plot(LNBmina(i,1),LNBmina(i,2),'x','MarkerSize',4,'Linewidth',3,'Color','m'); end
      hold off
      axis xy;
      axis square;
      set(gca,'TickDir','out')
      set(gca,'TickLength',ticklen);
      set(gca,'XMinorTick','on')
      set(gca,'YMinorTick','on')
      set(gca,'Fontsize',11);
      if( i12==1 )
        hxl = xlabel(sXLab,'Fontsize',fs2);
      else
        hxl = xlabel(sXLabm,'Fontsize',fs2);
      end
      set(hxl, 'Units', 'Normalized', 'Position', [.65, -.12, 0]);
      if( i12==2 )
        set(gca,'YTickLabel','');
      else
        hyl = ylabel(sYLab,'Fontsize',fs2,'Rotation',0);
        set(hyl, 'Units', 'Normalized', 'Position', [-.2, .57, 0]);
        title(sprintf(['           i=%4d, t=%0.4g, \x3BB=%0.2g/%0.2g/%0.2g, \x3B8_M=%0.2g, \x3C3' ...
          '=%0.2g'],i,t(i),lambda(i,:),angMM0(i),dev(i)),'Fontsize',fs1);
      end
    end % i12
    
    LNBmina(i,:)
    
    pause(.1)
    drawnow;
    if( iPlot37==2 ), Frame(i) = getframe(gcf); end
    if( iPlot37==2 ), writeVideo(vidfile,Frame(i)); end
  end % i
  if( iPlot37==2 ), close(vidfile); end
end % iPlot37

%%

if( iPlot57>0 )
  figure(57)
  clf;
  if( exist('vidfile','var')==1 ), close(vidfile); end
  if( iPlot57==2 ), vidfile = VideoWriter([sDirPlots 'Poly_movie_Brs' num2str(iBurst) '_Smo' num2str(nsmoothspan) '_Sub' num2str(iSubAvB) '_Rot' num2str(iRotate) '_noXRot' num2str(iNoXRotation) '_iSys' num2str(iSystem) '_iIncmprs' num2str(iIncmprs) '_iexctB' num2str(iExactB) '_iNF' num2str(iNormFlds) '_' num2str(wFlds(1)) '-' num2str(wFlds(2)) '-' num2str(wFlds(3)) '-' num2str(wFlds(4)) '-' num2str(wFlds(5)) '-' num2str(wFlds(6)) '_wB' num2str(wMag) '_iAltNe' num2str(iAltNe) '_iBMloc' num2str(iLocalBM) '_t' num2str(tlo,3) '-' num2str(thi,3) '.mp4'],'MPEG-4'); end
  if( iPlot57==2 ), open(vidfile); end
  set(gcf,'Color','w');
  set(gcf,'Position',[700,200,650,430]);
  xsc11 = .2; xsc12 = .98;
  xsc1 = 0.13; xsc2 = 0.98; ysc1 = 0.09; ysc2 = .75; ysc3 = .83; ysc4 = .99; blue = [0.4,.4,1];
  ticklen = [0.04 0.02];
  ms = 10;
  vgap = 0.05;
  fxlab = .15; fylab = .8;
  if( iRotate>0 )
    sXLab = 'L/L_{sc}';
    sXLabm = 'M/L_{sc}';
    sYLab = 'N/L_{sc}';
  else
    sXLab = 'X/L_{sc}';
    sXLabm = 'Y/L_{sc}';
    sYLab = 'Z/L_{sc}';
  end
  nrow = 4;
  ncol = 4;
  nL = 41; nLcut = 11;  nLx = 201;
  La = linspace(-Lmax,Lmax,nL); dL = La(2) - La(1);
  Lacut = linspace(-Lmax,Lmax,nLcut);
  Lax = linspace(-Lmax,Lmax,nLx);
  [L2D,N2D] = meshgrid(La);
  [L2Dcut,N2Dcut] = meshgrid(Lacut);
  [L2Dx,N2Dx] = meshgrid(Lax);
  nsl = 131;
  Lsl = zeros(nsl,1);
  Nsl = zeros(nsl,1);
  Llen = 2*Lmax;
  dLlen = Llen/nsl;
  for isl = 1:nsl
    Lsl(isl) = -Lmax + dLlen/2 + (isl-1)*dLlen;
    Nsl(isl) = -Lmax + nrev(isl,2)*Llen;
  end
  
  Lax = linspace(-Lmax,Lmax,nLx);
  casc = [ gray ; 1 0 0 ; 0 .8 0 ; .3 .3 1 ];
  fwh = .75;
  
  lambda23 = lambda(:,2)./lambda(:,3);
  fyrange = [ .8 .875 .95 ];
  cprob = [ 0 .8 0 ; 0 0 0 ; 1 0 1 ];
  wid0 = .5; wid1 = .75; wid2 = 1; wid3 = 2; fs1 = 9; fs2 = 12;
  
  ipl = 0;
  maxAbsValx1 = 0;
  maxAbsValx = 3;
  LNBmina = NaN(nt,5); % Lmin, Nmin, BLNmin
  if( iNormD == 1 )
    mingrads = (.1)^2/Bnorms;
  else
    mingrads = (.1/dsc)^2;
  end
  l2D = zeros(nL); m2D = zeros(nL); n2D = zeros(nL);
  l2Dm = zeros(nL); m2Dm = zeros(nL); n2Dm = zeros(nL);
  BL2D = zeros(nL); BM2D = zeros(nL); BN2D = zeros(nL);
  BL2Dm = zeros(nL); BM2Dm = zeros(nL); BN2Dm = zeros(nL);
  if( iPlot57==6 )
    iend = 1;
  else
    iend = nt;
  end
  for i = 1:iMovieStep:iend  % 1 % ***nt
    
    hax = my_subplotrc3(1,1, 1, 1, xsc1,xsc2,ysc3,ysc4);
    h1 = plot(t,bavv(:,1),'Color',casc(4,:),'Linewidth',wid1);
    xlim([t(1) t(end)]);
    hold on
    h2 = plot(t,bavv(:,2),'Color',casc(3,:),'Linewidth',wid1);
    h3 = plot(t,bavv(:,3),'Color',casc(2,:),'Linewidth',wid1);
    plot([t(1),t(end)],[0 0],'k:','Linewidth',wid2);
    ylim1 = get(gca,'YLim');
    plot([t(i),t(i)],ylim1,'k','Linewidth',wid3);
    %     isel = find(angMM0>30);
    %     plot( t(isel),repmat(ylim1(1)+fyrange(1)*(ylim1(2)-ylim1(1)),[numel(isel),1]) ...
    %       ,'x','Color',cprob(1,:))
    %     isel = find(lambda23<7);
    %     plot( t(isel),repmat(ylim1(1)+fyrange(2)*(ylim1(2)-ylim1(1)),[numel(isel),1]) ...
    %       ,'x','Color',cprob(2,:))
    %     isel = find(dev>.07);
    %     plot( t(isel),repmat(ylim1(1)+fyrange(3)*(ylim1(2)-ylim1(1)),[numel(isel),1]) ...
    %       ,'x','Color',cprob(3,:))
    hold off
    set(gca,'Fontsize',11);
    set(gca,'TickLength',ticklen);
    set(gca,'XMinorTick','on');
    set(gca,'YMinorTick','on');
    if( iRotate>0 )
      ylabel({'{\bfB}_{av} {\color[rgb]{.3,.3,1}L}{\color[rgb]{0,.8,0}M}{\color[rgb]{.9,0,0}N}' '(nT)'},'Fontsize',fs2);
    else
      ylabel({'{\bfB}_{av} GSE' '(nT)'},'Fontsize',fs2);
    end
    htn = textNormFig( gca, -.06, -.19,'t(s)', fs2 );
%     hxl = xlabel(['t(s) after ' sTime ' UT']);
%     set(hxl, 'Units', 'Normalized', 'Position', [0.5, -.33, 0])
    
    mv1 = squeeze(mv(i,:,:));
    for i1 = 1:nL
      for j1 = 1:nL
        Pos1 = [ L2D(j1,i1) 0 N2D(j1,i1) ];
        pos1 = Pos1 * mv1;
        l2D(j1,i1) = pos1(1);
        m2D(j1,i1) = pos1(2);
        n2D(j1,i1) = pos1(3);
        
        Pos1 = [ 0  L2D(j1,i1) N2D(j1,i1) ];
        pos1 = Pos1 * mv1;
        l2Dm(j1,i1) = pos1(1);
        m2Dm(j1,i1) = pos1(2);
        n2Dm(j1,i1) = pos1(3);
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
      % B_s,L
      j0 = 0;
      Bl2Dm = X1(j0+1) + X1(j0+2)*n2Dm + X1(j0+3)*l2Dm + X1(j0+4)*n2Dm.^2/2;
      % B_s,M
      j0 = 4;
      Bm2Dm = X1(j0+1) + X1(j0+2)*n2Dm + X1(j0+3)*l2Dm +  ...
        + X1(j0+4)*n2Dm.^2/2 + X1(j0+5)*l2Dm.^2/2 + X1(j0+6)*n2Dm.*l2Dm;
      % B_s,N
      j0 = 10;
      Bn2Dm = X1(j0+1) + X1(j0+2)*n2Dm + X1(j0+3)*l2Dm + X1(j0+4)*l2Dm.^2/2;
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
      % B_s,L
      j0 = 0;
      Bl2Dm = X1(j0+1) + X1(j0+2)*n2Dm + X1(j0+3)*l2Dm + X1(j0+4)*m2Dm ...
        + X1(j0+5)*n2Dm.^2/2;
      % B_s,M
      j0 = 5;
      Bm2Dm = X1(j0+1) + X1(j0+2)*n2Dm + X1(j0+3)*l2Dm + X1(j0+4)*m2Dm ...
        + X1(j0+5)*n2Dm.^2/2 + X1(j0+6)*l2Dm.^2/2 ...
        + X1(j0+7)*n2Dm.*l2Dm;
      % B_s,N
      j0 = 12;
      Bn2Dm = X1(j0+1) + X1(j0+2)*n2Dm + X1(j0+3)*l2Dm + X1(j0+4)*m2Dm ...
        + X1(j0+5)*l2Dm.^2/2;
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
      % B_s,L
      j0 = 0;
      Bl2Dm = X1(j0+1) + X1(j0+2)*n2Dm + X1(j0+3)*m2Dm + X1(j0+4)*l2Dm ...
        + X1(j0+5)*n2Dm.^2/2 + X1(j0+6)*m2Dm.^2/2 + X1(j0+7)*n2Dm.*m2Dm;
      % B_s,M
      j0 = 7;
      Bm2Dm = X1(j0+1) + X1(j0+2)*n2Dm + X1(j0+3)*m2Dm + X1(j0+4)*l2Dm ...
        + X1(j0+5)*n2Dm.^2/2;
      % B_s,N
      j0 = 12;
      Bn2Dm = X1(j0+1) + X1(j0+2)*n2Dm + X1(j0+3)*m2Dm + X1(j0+4)*l2Dm ...
        + X1(j0+5)*m2Dm.^2/2;
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
        % B_s,L
        j0 = 0;
        Bl2Dm = X1(j0+1) + X1(j0+2)*n2Dm + X1(j0+3)*l2Dm + X1(j0+4)*m2Dm;
        % B_s,M
        j0 = 4;
        Bm2Dm = X1(j0+1) + X1(j0+2)*n2Dm + X1(j0+3)*l2Dm + X1(j0+4)*m2Dm;
        % B_s,N
        j0 = 8;
        Bn2Dm = X1(j0+1) + X1(j0+2)*n2Dm + X1(j0+3)*l2Dm + X1(j0+4)*m2Dm;
    elseif( iSystem==9 )       % B_s,L
      j0 = 0;
      BL2D = X1(j0+1) + X1(j0+2)*n2D + X1(j0+3)*l2D + X1(j0+4)*m2D ...
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
      % B_s,L
      j0 = 0;
      BL2Dm = X1(j0+1) + X1(j0+2)*n2Dm + X1(j0+3)*l2Dm + X1(j0+4)*m2Dm ...
        + X1(j0+5)*n2Dm.^2/2 + X1(j0+6)*l2Dm.^2/2 ...
        + X1(j0+7)*n2Dm.*l2Dm + X1(j0+8)*n2Dm.*m2Dm + X1(j0+9)*l2Dm.*m2Dm;
      if( i28term==1 )
        Bl2Dm = Bl2Dm + X1(  28)*n2Dm.^3/6;
      elseif( i28term==4 || i28term==5 )
        Bl2Dm = Bl2Dm + X1(  28)*n2Dm.^2/2 .*m2Dm;
      end
      % B_s,M
      j0 = 9;
      Bm2Dm = X1(j0+1) + X1(j0+2)*n2Dm + X1(j0+3)*l2Dm + X1(j0+4)*m2Dm ...
        + X1(j0+5)*n2Dm.^2/2 + X1(j0+6)*l2Dm.^2/2 ...
        + X1(j0+7)*n2Dm.*l2Dm + X1(j0+8)*n2Dm.*m2Dm + X1(j0+9)*l2Dm.*m2Dm;
      if( i28term==2 || i28term==5 )
        Bm2Dm = Bm2Dm + X1(  28)*n2Dm.^2/2 .*l2Dm;
      end
      % B_s,N
      j0 = 18;
      Bn2Dm = X1(j0+1) + X1(j0+2)*n2Dm + X1(j0+3)*l2Dm + X1(j0+4)*m2Dm ...
        + X1(j0+5)*n2Dm.^2/2 + X1(j0+6)*l2Dm.^2/2 ...
        + X1(j0+7)*n2Dm.*l2Dm + X1(j0+8)*n2Dm.*m2Dm + X1(j0+9)*l2Dm.*m2Dm;
      if( i28term==3 || i28term==5 )
        Bn2Dm = Bn2Dm + X1(  28)*l2Dm.^2/2 .*m2Dm;
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
      % MN arrays
      nnn2Dm = n2Dm.^3/6;
      lll2Dm = l2Dm.^3/6;
      nnl2Dm = n2Dm.^2.*l2Dm/2;
      nnm2Dm = n2Dm.^2.*m2Dm/2;
      lln2Dm = l2Dm.^2.*n2Dm/2;
      llm2Dm = l2Dm.^2.*m2Dm/2;
      nlm2Dm = n2Dm.*l2Dm.*m2Dm;
      % B_s,L
      j0 = 0;
      Bl2Dm = X1(j0+1) + X1(j0+2)*n2Dm + X1(j0+3)*l2Dm + X1(j0+4)*m2Dm ...
        + X1(j0+5)*n2Dm.^2/2 + X1(j0+6)*l2Dm.^2/2 ...
        + X1(j0+7)*n2Dm.*l2Dm + X1(j0+8)*n2Dm.*m2Dm + X1(j0+9)*l2Dm.*m2Dm ...
        + X1(28)*nnm2Dm + X1(32)*nnn2Dm + X1(36)*nnl2Dm + X1(37)*lln2Dm + X1(38)*lll2Dm + X1(39)*nlm2Dm + X1(40)*llm2Dm;
      % B_s,M
      j0 = 9;
      Bm2Dm = X1(j0+1) + X1(j0+2)*n2Dm + X1(j0+3)*l2Dm + X1(j0+4)*m2Dm ...
        + X1(j0+5)*n2Dm.^2/2 + X1(j0+6)*l2Dm.^2/2 ...
        + X1(j0+7)*n2Dm.*l2Dm + X1(j0+8)*n2Dm.*m2Dm + X1(j0+9)*l2Dm.*m2Dm ...
        + X1(29)*nnl2Dm + X1(30)*lln2Dm + X1(33)*nnn2Dm + X1(34)*lll2Dm;
      % B_s,N
      j0 = 18;
      Bn2Dm = X1(j0+1) + X1(j0+2)*n2Dm + X1(j0+3)*l2Dm + X1(j0+4)*m2Dm ...
        + X1(j0+5)*n2Dm.^2/2 + X1(j0+6)*l2Dm.^2/2 ...
        + X1(j0+7)*n2Dm.*l2Dm + X1(j0+8)*n2Dm.*m2Dm + X1(j0+9)*l2Dm.*m2Dm ...
        + X1(31)*llm2Dm + X1(35)*lll2Dm - X1(36)*nnn2Dm - X1(37)*nnl2Dm - X1(38)*lln2Dm - X1(39)*nnm2Dm - X1(40)*nlm2Dm;
    else
      % B_s,L
      j0 = 0;
      Bl2D = X1(iv(j0+1)) + X1(iv(j0+2))*n2D + X1(iv(j0+3))*l2D  ...
        + X1(iv(j0+4))*n2D.^2/2 + X1(iv(j0+5))*n2D.*l2D + X1(iv(j0+6))*l2D.^2/2;
      Bl2Dm = X1(iv(j0+1)) + X1(iv(j0+2))*n2Dm + X1(iv(j0+3))*l2Dm  ...
        + X1(iv(j0+4))*n2Dm.^2/2 + X1(iv(j0+5))*n2Dm.*l2Dm + X1(iv(j0+6))*l2Dm.^2/2;
      if( iQuadSys==-1 )
        Bl2D = Bl2D + X1(iv(j0+7))*m2D + X1(iv(j0+8))*n2D.*m2D + X1(iv(j0+9))*l2D.*m2D + X1(28)*n2D.^3/6;
        Bl2Dm = Bl2Dm + X1(iv(j0+7))*m2Dm + X1(iv(j0+8))*n2Dm.*m2Dm + X1(iv(j0+9))*l2Dm.*m2Dm + X1(28)*n2Dm.^3/6;
      elseif( iQuadSys==0 )
        Bl2D = Bl2D + X1(iv(j0+7))*m2D + X1(iv(j0+8))*n2D.*m2D + X1(iv(j0+9))*l2D.*m2D;
        Bl2Dm = Bl2Dm + X1(iv(j0+7))*m2Dm + X1(iv(j0+8))*n2Dm.*m2Dm + X1(iv(j0+9))*l2Dm.*m2Dm;
      elseif( iQuadSys==1 )
        Bl2D = Bl2D + X1(iv(j0+7))*m2D + X1(iv(j0+8))*n2D.*m2D;
        Bl2Dm = Bl2Dm + X1(iv(j0+7))*m2Dm + X1(iv(j0+8))*n2Dm.*m2Dm;
      elseif( iQuadSys==2 )
        Bl2D = Bl2D + X1(iv(j0+7))*m2D;
        Bl2Dm = Bl2Dm + X1(iv(j0+7))*m2Dm;
      end
      % B_s,M
      j0 = 9;
      Bm2D = X1(iv(j0+1)) + X1(iv(j0+2))*n2D + X1(iv(j0+3))*l2D  ...
        + X1(iv(j0+4))*n2D.^2/2 + X1(iv(j0+5))*n2D.*l2D + X1(iv(j0+6))*l2D.^2/2;
      Bm2Dm = X1(iv(j0+1)) + X1(iv(j0+2))*n2Dm + X1(iv(j0+3))*l2Dm  ...
        + X1(iv(j0+4))*n2Dm.^2/2 + X1(iv(j0+5))*n2Dm.*l2Dm + X1(iv(j0+6))*l2Dm.^2/2;
      if( iQuadSys<1 )
        Bm2D = Bm2D + X1(iv(j0+7))*m2D + X1(iv(j0+8))*n2D.*m2D + X1(iv(j0+9))*l2D.*m2D;
        Bm2Dm = Bm2Dm + X1(iv(j0+7))*m2Dm + X1(iv(j0+8))*n2Dm.*m2Dm + X1(iv(j0+9))*l2Dm.*m2Dm;
      elseif( iQuadSys==1 )
        Bm2D = Bm2D + X1(iv(j0+7))*m2D + X1(iv(j0+8))*n2D.*m2D;
        Bm2Dm = Bm2Dm + X1(iv(j0+7))*m2Dm + X1(iv(j0+8))*n2Dm.*m2Dm;
      elseif( iQuadSys==2 )
        Bm2D = Bm2D + X1(iv(j0+7))*m2D;
        Bm2Dm = Bm2Dm + X1(iv(j0+7))*m2Dm;
      end
      % B_s,N
      j0 = 18;
      Bn2D = X1(iv(j0+1)) + X1(iv(j0+2))*n2D + X1(iv(j0+3))*l2D  ...
        + X1(iv(j0+4))*n2D.^2/2 + X1(iv(j0+5))*n2D.*l2D + X1(iv(j0+6))*l2D.^2/2;
      Bn2Dm = X1(iv(j0+1)) + X1(iv(j0+2))*n2Dm + X1(iv(j0+3))*l2Dm  ...
        + X1(iv(j0+4))*n2Dm.^2/2 + X1(iv(j0+5))*n2Dm.*l2Dm + X1(iv(j0+6))*l2Dm.^2/2;
      if( iQuadSys<1 )
        Bn2D = Bn2D + X1(iv(j0+7))*m2D + X1(iv(j0+8))*n2D.*m2D + X1(iv(j0+9))*l2D.*m2D;
        Bn2Dm = Bn2Dm + X1(iv(j0+7))*m2Dm + X1(iv(j0+8))*n2Dm.*m2Dm + X1(iv(j0+9))*l2Dm.*m2Dm;
      elseif( iQuadSys<3 )
        Bn2D = Bn2D + X1(iv(j0+7))*m2D;
        Bn2Dm = Bn2Dm + X1(iv(j0+7))*m2Dm;
      end
    end % iSystem
    
    mv1p = mv1';
    for i1 = 1:nL
      for j1 = 1:nL
        mag1 = [ Bl2D(j1,i1) Bm2D(j1,i1) Bn2D(j1,i1) ];
        Mag1 = mag1 * mv1p;
        BL2D(j1,i1) = Mag1(1);
        BM2D(j1,i1) = Mag1(2);
        BN2D(j1,i1) = Mag1(3);
        
        mag1 = [ Bl2Dm(j1,i1) Bm2Dm(j1,i1) Bn2Dm(j1,i1) ];
        Mag1 = mag1 * mv1p;
        BL2Dm(j1,i1) = Mag1(1);
        BM2Dm(j1,i1) = Mag1(2);
        BN2Dm(j1,i1) = Mag1(3);
      end
    end
    
    % Find X points
    %     Lmin = NaN; Nmin = NaN; BLNmin = NaN; BLrat = NaN; BNrat = NaN;
    BL2Dx = interp2(L2D,N2D,BL2D,L2Dx,N2Dx);
    BN2Dx = interp2(L2D,N2D,BN2D,L2Dx,N2Dx);
    BLNx = sqrt( BL2Dx.^2 + BN2Dx.^2 );
    [jx,ix,BLNmin] = find( BLNx==min(BLNx(:)) , 1 );
    if( jx>1 && jx<nLx && ix>1 && ix<nLx )
      Lmin = Lax(ix); Nmin = Lax(jx); BLNmin = BLNx(jx,ix);
      BLrat = BL2Dx(jx+1,ix)/BL2Dx(jx-1,ix); BNrat = BN2Dx(jx,ix+1)/BN2Dx(jx,ix-1);
      if( BLrat<0 )
        LNBmina(i,:) = [Lmin Nmin BLNmin BLrat BNrat];
        
        if( iPlot40>0 )
          figure(40)
          set(gcf,'Position',[100,700,300,300]);
          imagesc(Lax,Lax,BLNx)
          axis xy
          hold on
          %         plot(Lmin,Nmin,'x','MarkerSize',4,'Linewidth',3,'Color','m');
          hold off
          figure(57)
        end
      end
    end
    

    
    if( iLocalBM==1 )
      maxAbsVal = maxAll( abs( [ BM2D(:)-B0fit(i,2) ; BM2Dm(:)-B0fit(i,2) ] ) );
    else
      maxAbsVal = maxAll( abs( [ BM2D(:) ; BM2Dm(:) ] ) );
    end
    maxAbsValx1 = max( maxAbsValx1,maxAbsVal );
    zcolorM = [ -maxAbsVal ; 0 ; maxAbsVal ];
    colorsM = [ fwh fwh 1 ; 1 1 1 ;  1 fwh fwh ];
    colorM = colormap_colors(zcolorM,colorsM);
    
    for i12 = 1:2
      if( i12==1 )
        Bvar1 = BL2D;
        Bvar2 = BN2D;
        if( iLocalBM==1 )
          Bvar3 = BM2D-B0fit(i,2);
        else
          Bvar3 = BM2D;
        end
      else
        Bvar1 = BM2Dm;
        Bvar2 = BN2Dm;
        if( iLocalBM==1 )
          Bvar3 = BM2Dm-B0fit(i,2);
        else
          Bvar3 = BM2Dm;
        end
      end
      my_subplotrc4(1,2, 1, i12, .11,.87,ysc1,ysc2,.045,0);
      imagesc(La,La',Bvar3);
      caxis([-maxAbsVal maxAbsVal])
      colormap(colorM)
      shading interp;
      if( i12==2 )
        hcb = colorbar;
        set(hcb,'Position',[.9,ysc1,.025,ysc2-ysc1]);
        if( iRotate>0 )
          cblab = ylabel(hcb,{'B_{M}' '(nT)'});
        else
          cblab = ylabel(hcb,{'B_{Y}' '(nT)'});
        end
        set(cblab,'FontSize',9,'Rotation',0,'Units', 'Normalized', 'Position', [3, .85, 0]);
      end
      hold on
      hst = streamline(L2D,N2D,Bvar1,Bvar2,Lsl,Nsl);
      set(hst,'Color','k')
      hst = streamline(L2D,N2D,-Bvar1,-Bvar2,Lsl,Nsl);
      set(hst,'Color','k')
      for k = 1:4
        if( i12==1 )
          plot(xv(i,1,k),xv(i,3,k),'o','MarkerSize',8,'Linewidth',0.5,'Color','w','MarkerFaceColor',casc(k,:));
        else
          plot(xv(i,2,k),xv(i,3,k),'o','MarkerSize',8,'Linewidth',0.5,'Color','w','MarkerFaceColor',casc(k,:));
        end
      end
      %       if( i12==1 ), plot(LNBmina(i,1),LNBmina(i,2),'x','MarkerSize',4,'Linewidth',3,'Color','m'); end
      hold off
      axis xy;
      axis square;
      set(gca,'TickDir','out')
      set(gca,'TickLength',ticklen);
      set(gca,'XMinorTick','on');
      set(gca,'YMinorTick','on');
      set(gca,'Fontsize',11);
      if( i12==1 )
        hxl = xlabel(sXLab,'Fontsize',fs2);
      else
        hxl = xlabel(sXLabm,'Fontsize',fs2);
      end
      set(hxl, 'Units', 'Normalized', 'Position', [.65, -.12, 0]);
      if( i12==2 )
        set(gca,'YTickLabel','');
      else
        hyl = ylabel(sYLab,'Fontsize',fs2,'Rotation',0);
        set(hyl, 'Units', 'Normalized', 'Position', [-.2, .57, 0]);
        textNormFig( gca, 0, 1.1, ['t = ' num2str(t(i)) ' s'], 11 );
      %  title(sprintf(['                               t=%0.4g'],t(i),'Fontsize',fs1);
      end
    end % i12
    
    LNBmina(i,:)
    
    pause(.1)
    drawnow;
    if( iPlot57==2 ), Frame(i) = getframe(gcf); end
    if( iPlot57==2 ), writeVideo(vidfile,Frame(i)); end
  end % i
  if( iPlot57==2 ), close(vidfile); end
  dlmwrite([sDirPlots 'Poly_LNBmin_Brs' num2str(iBurst) '_Smo' num2str(nsmoothspan) '_Sub' num2str(iSubAvB) '_Rot' num2str(iRotate) '_noXRot' num2str(iNoXRotation) '_iSys' num2str(iSystem) '_iIncmprs' num2str(iIncmprs) '_iexctB' num2str(iExactB) '_iNF' num2str(iNormFlds) '_' num2str(wFlds(1)) '-' num2str(wFlds(2)) '-' num2str(wFlds(3)) '-' num2str(wFlds(4)) '-' num2str(wFlds(5)) '-' num2str(wFlds(6)) '_wB' num2str(wMag) '_iAltNe' num2str(iAltNe) '_iBMloc' num2str(iLocalBM) '_t' num2str(tlo,3) '-' num2str(thi,3) '.txt'],[t,LNBmina]);
  dlmwrite([sDirPlots 'dsc.txt'],dsc);
%   dlmwrite([sDirPlots 'sTime.txt'],sTime);
  
end % iPlot57

%% 3D Plot

if( iPlot58>0 )
  figure(58)
  clf;
  i = find( abs(t-t3D) == min(abs(t-t3D)) , 1 );
  set(gcf,'Color','w');
  if( i58small==1 )
    set(gcf,'Position',[400,500,500,500]);
  else
    set(gcf,'Position',[100,50,600,600]);
  end
  
  ticklen = [0.06 0.03];
  wid1 = 1.5; wid2 = 2; wid3 = 2; fs1 = 14; fs2 = 14; fs0 = 18; 
  casc = [ gray ; 1 0 0 ; 0 .8 0 ; .3 .3 1 ];
  
  nL = nLB; nLcut = 7;
  nLd2 = 1 + round((nL-1)/2);
  La = linspace(-Lmax,Lmax,nL); dL = La(2) - La(1);
  Lacut = linspace(-Lmax,Lmax,nLcut);
  [L3D,M3D,N3D] = meshgrid(La,La,La);
  if( i3DaltLN==1 )
    [M2Dcut,N2Dcut] = meshgrid(Lacut); L2Dcut = zeros(nLcut);
%     M2Dcut = [ M2Dcut(:) ; M2Dcut(:) ];
%     N2Dcut = [ N2Dcut(:) ; N2Dcut(:) ];
%     L2Dcut = [ L2Dcut(:) ; -L2Dcut(:) ];
  elseif( i3DaltLN==2 )
    [L2Dcut,M2Dcut] = meshgrid(Lacut); N2Dcut = zeros(nLcut);
  else
    [L2Dcut,N2Dcut] = meshgrid(Lacut); M2Dcut = zeros(nLcut);
  end
  
  l3D = zeros(nL,nL,nL); m3D = zeros(nL,nL,nL); n3D = zeros(nL,nL,nL);
  BL3D = zeros(nL,nL,nL); BM3D = zeros(nL,nL,nL); BN3D = zeros(nL,nL,nL);

  mv1 = squeeze(mv(i,:,:));
  for k1 = 1:nL
    for i1 = 1:nL
      for j1 = 1:nL
        Pos1 = [ L3D(j1,i1,k1) M3D(j1,i1,k1) N3D(j1,i1,k1) ];
        pos1 = Pos1 * mv1;
        l3D(j1,i1,k1) = pos1(1);
        m3D(j1,i1,k1) = pos1(2);
        n3D(j1,i1,k1) = pos1(3);
      end
    end
  end
    
    X1 = X(i,:);
    
    if( iSystem==1 )
      % B_s,L
      j0 = 0;
      Bl3D = X1(j0+1) + X1(j0+2)*n3D + X1(j0+3)*l3D + X1(j0+4)*n3D.^2/2;
      % B_s,M
      j0 = 4;
      Bm3D = X1(j0+1) + X1(j0+2)*n3D + X1(j0+3)*l3D +  ...
        + X1(j0+4)*n3D.^2/2 + X1(j0+5)*l3D.^2/2 + X1(j0+6)*n3D.*l3D;
      % B_s,N
      j0 = 10;
      Bn3D = X1(j0+1) + X1(j0+2)*n3D + X1(j0+3)*l3D + X1(j0+4)*l3D.^2/2;
    elseif( iSystem==2 )
       % B_s,L
      j0 = 0;
      Bl3D = X1(j0+1) + X1(j0+2)*n3D + X1(j0+3)*l3D + X1(j0+4)*m3D ...
        + X1(j0+5)*n3D.^2/2;
      % B_s,M
      j0 = 5;
      Bm3D = X1(j0+1) + X1(j0+2)*n3D + X1(j0+3)*l3D + X1(j0+4)*m3D ...
        + X1(j0+5)*n3D.^2/2 + X1(j0+6)*l3D.^2/2 ...
        + X1(j0+7)*n3D.*l3D;
      % B_s,N
      j0 = 12;
      Bn3D = X1(j0+1) + X1(j0+2)*n3D + X1(j0+3)*l3D + X1(j0+4)*m3D ...
        + X1(j0+5)*l3D.^2/2;
    elseif( iSystem==8 )
      % B_s,L
      j0 = 0;
      Bl3D = X1(j0+1) + X1(j0+2)*n3D + X1(j0+3)*m3D + X1(j0+4)*l3D ...
        + X1(j0+5)*n3D.^2/2 + X1(j0+6)*m3D.^2/2 + X1(j0+7)*n3D.*m3D;
      % B_s,M
      j0 = 7;
      Bm3D = X1(j0+1) + X1(j0+2)*n3D + X1(j0+3)*m3D + X1(j0+4)*l3D ...
        + X1(j0+5)*n3D.^2/2;
      % B_s,N
      j0 = 12;
      Bn3D = X1(j0+1) + X1(j0+2)*n3D + X1(j0+3)*m3D + X1(j0+4)*l3D ...
        + X1(j0+5)*m3D.^2/2;
    % B_s,L
      j0 = 0;
      BL3D = X1(j0+1) + X1(j0+2)*n3D + X1(j0+3)*l3D + X1(j0+4)*m3D ...
        + X1(j0+5)*n3D.^2/2 + X1(j0+6)*l3D.^2/2 ...
        + X1(j0+7)*n3D.*l3D + X1(j0+8)*n3D.*m3D + X1(j0+9)*l3D.*m3D;
      if( i28term==1 )
        Bl3D = Bl3D + X1(  28)*n3D.^3/6;
      elseif( i28term==4 || i28term==5 )
        Bl3D = Bl3D + X1(  28)*n3D.^2/2 .*m3D;
      end
      % B_s,M
      j0 = 9;
      Bm3D = X1(j0+1) + X1(j0+2)*n3D + X1(j0+3)*l3D + X1(j0+4)*m3D ...
        + X1(j0+5)*n3D.^2/2 + X1(j0+6)*l3D.^2/2 ...
        + X1(j0+7)*n3D.*l3D + X1(j0+8)*n3D.*m3D + X1(j0+9)*l3D.*m3D;
      if( i28term==2 || i28term==5 )
        Bm3D = Bm3D + X1(  28)*n3D.^2/2 .*l3D;
      end
      % B_s,N
      j0 = 18;
      Bn3D = X1(j0+1) + X1(j0+2)*n3D + X1(j0+3)*l3D + X1(j0+4)*m3D ...
        + X1(j0+5)*n3D.^2/2 + X1(j0+6)*l3D.^2/2 ...
        + X1(j0+7)*n3D.*l3D + X1(j0+8)*n3D.*m3D + X1(j0+9)*l3D.*m3D;
      if( i28term==3 || i28term==5 )
        Bn3D = Bn3D + X1(  28)*l3D.^2/2 .*m3D;
      end
    elseif( iSystem==10 )
        % B_s,L
        j0 = 0;
        Bl3D = X1(j0+1) + X1(j0+2)*n3D + X1(j0+3)*l3D + X1(j0+4)*m3D;
        % B_s,M
        j0 = 4;
        Bm3D = X1(j0+1) + X1(j0+2)*n3D + X1(j0+3)*l3D + X1(j0+4)*m3D;
        % B_s,N
        j0 = 8;
        Bn3D = X1(j0+1) + X1(j0+2)*n3D + X1(j0+3)*l3D + X1(j0+4)*m3D;
    elseif( iSystem==28 ) 
      nnn3D = n3D.^3/6;
      lll3D = l3D.^3/6;
      nnl3D = n3D.^2.*l3D/2;
      nnm3D = n3D.^2.*m3D/2;
      lln3D = l3D.^2.*n3D/2;
      llm3D = l3D.^2.*m3D/2;
      nlm3D = n3D.*l3D.*m3D;
      % B_s,L
      j0 = 0;
      Bl3D = X1(j0+1) + X1(j0+2)*n3D + X1(j0+3)*l3D + X1(j0+4)*m3D ...
        + X1(j0+5)*n3D.^2/2 + X1(j0+6)*l3D.^2/2 ...
        + X1(j0+7)*n3D.*l3D + X1(j0+8)*n3D.*m3D + X1(j0+9)*l3D.*m3D ...
        + X1(28)*nnm3D + X1(32)*nnn3D + X1(36)*nnl3D + X1(37)*lln3D + X1(38)*lll3D + X1(39)*nlm3D + X1(40)*llm3D;
      % B_s,M
      j0 = 9;
      Bm3D = X1(j0+1) + X1(j0+2)*n3D + X1(j0+3)*l3D + X1(j0+4)*m3D ...
        + X1(j0+5)*n3D.^2/2 + X1(j0+6)*l3D.^2/2 ...
        + X1(j0+7)*n3D.*l3D + X1(j0+8)*n3D.*m3D + X1(j0+9)*l3D.*m3D ...
        + X1(29)*nnl3D + X1(30)*lln3D + X1(33)*nnn3D + X1(34)*lll3D;
      % B_s,N
      j0 = 18;
      Bn3D = X1(j0+1) + X1(j0+2)*n3D + X1(j0+3)*l3D + X1(j0+4)*m3D ...
        + X1(j0+5)*n3D.^2/2 + X1(j0+6)*l3D.^2/2 ...
        + X1(j0+7)*n3D.*l3D + X1(j0+8)*n3D.*m3D + X1(j0+9)*l3D.*m3D ...
        + X1(31)*llm3D + X1(35)*lll3D - X1(36)*nnn3D - X1(37)*nnl3D - X1(38)*lln3D - X1(39)*nnm3D - X1(40)*nlm3D;
    else
      % B_s,L
      j0 = 0;
      Bl3D = X1(iv(j0+1)) + X1(iv(j0+2))*n3D + X1(iv(j0+3))*l3D  ...
        + X1(iv(j0+4))*n3D.^2/2 + X1(iv(j0+5))*n3D.*l3D + X1(iv(j0+6))*l3D.^2/2;
      if( iQuadSys==-1 )
        Bl3D = Bl3D + X1(iv(j0+7))*m3D + X1(iv(j0+8))*n3D.*m3D + X1(iv(j0+9))*l3D.*m3D + X1(28)*n3D.^3/6;
      elseif( iQuadSys==0 )
        Bl3D = Bl3D + X1(iv(j0+7))*m3D + X1(iv(j0+8))*n3D.*m3D + X1(iv(j0+9))*l3D.*m3D;
      elseif( iQuadSys==1 )
        Bl3D = Bl3D + X1(iv(j0+7))*m3D + X1(iv(j0+8))*n3D.*m3D;
      elseif( iQuadSys==2 )
        Bl3D = Bl3D + X1(iv(j0+7))*m3D;
      end
      % B_s,M
      j0 = 9;
      Bm3D = X1(iv(j0+1)) + X1(iv(j0+2))*n3D + X1(iv(j0+3))*l3D  ...
        + X1(iv(j0+4))*n3D.^2/2 + X1(iv(j0+5))*n3D.*l3D + X1(iv(j0+6))*l3D.^2/2;
      if( iQuadSys<1 )
        Bm3D = Bm3D + X1(iv(j0+7))*m3D + X1(iv(j0+8))*n3D.*m3D + X1(iv(j0+9))*l3D.*m3D;
      elseif( iQuadSys==1 )
        Bm3D = Bm3D + X1(iv(j0+7))*m3D + X1(iv(j0+8))*n3D.*m3D;
      elseif( iQuadSys==2 )
        Bm3D = Bm3D + X1(iv(j0+7))*m3D;
      end
      % B_s,N
      j0 = 18;
      Bn3D = X1(iv(j0+1)) + X1(iv(j0+2))*n3D + X1(iv(j0+3))*l3D  ...
        + X1(iv(j0+4))*n3D.^2/2 + X1(iv(j0+5))*n3D.*l3D + X1(iv(j0+6))*l3D.^2/2;
      if( iQuadSys<1 )
        Bn3D = Bn3D + X1(iv(j0+7))*m3D + X1(iv(j0+8))*n3D.*m3D + X1(iv(j0+9))*l3D.*m3D;
      elseif( iQuadSys<3 )
        Bn3D = Bn3D + X1(iv(j0+7))*m3D;
      end
    end % iSystem
    
    mv1p = mv1';
    for k1 = 1:nL
      for i1 = 1:nL
        for j1 = 1:nL
          mag1 = [ Bl3D(j1,i1,k1) Bm3D(j1,i1,k1) Bn3D(j1,i1,k1) ];
          Mag1 = mag1 * mv1p;
          BL3D(j1,i1,k1) = Mag1(1);
          BM3D(j1,i1,k1) = Mag1(2);
          BN3D(j1,i1,k1) = Mag1(3);
        end
      end
    end
    
    if( i58NoB0>=1 )
      if( iB0op==1 )
        BL0 = bavv(i,1); BM0 = bavv(i,2); BN0 = bavv(i,3); 
      else
        BL0 = BL3D(nLd2,nLd2,nLd2);
        BM0 = BM3D(nLd2,nLd2,nLd2);
        BN0 = BN3D(nLd2,nLd2,nLd2);
      end
      BL3D = BL3D - BL0;
      BM3D = BM3D - BM0;
      BN3D = BN3D - BN0;    
    end
    
%     BL2Dcut = interp3(L3D,M3D,N3D,BL3D,L2Dcut(:),M2Dcut(:),N2Dcut(:));
%     BM2Dcut = interp3(L3D,M3D,N3D,BM3D,L2Dcut(:),M2Dcut(:),N2Dcut(:));
%     BN2Dcut = interp3(L3D,M3D,N3D,BN3D,L2Dcut(:),M2Dcut(:),N2Dcut(:));

    Bmag = sqrt( BL3D.^2 + BM3D.^2 + BN3D.^2 );
    Bmax = max(Bmag(:));
    fscl = 1/Bmax;
    if( i58slran == 1 )
      Bmagc = Bmag(2:end-1,2:end-1,2:end-1);
      Bmagc1D = Bmagc(:);
      wsl = Bmagc1D/sum(Bmagc1D);
      nwsl = numel(wsl);
      fsl = zeros(size(wsl));
      fsl(2) = wsl(1) + 0.5*wsl(2);
      for ii = 3:nwsl-1
        fsl(ii) = fsl(ii-1) + 0.5*( wsl(ii-1) + wsl(ii) );
      end
      fsl(end) = 1;
      fslreg = linspace(0,1,nwsl)';
      infslreg = interp1(fsl,(1:nwsl)',fslreg);
      nsl = 70;
      fsl = rand(nsl,1);
      insl = round( interp1(fslreg,infslreg,fsl) );
      nLm2 = nL - 2;
      [inM,inL,inN] = ind2sub([nLm2,nLm2,nLm2],insl);
      M3Dsl = La(inM+1);
      L3Dsl = La(inL+1);
      N3Dsl = La(inN+1);
    elseif( i58slran == 2 )
      nsl = 60;
      Llen = 2*Lmax;
      dLlen = Llen/nsl;
      for isl = 1:nsl
        L3Dsl(isl) = -Lmax + dLlen/2 + (isl-1)*dLlen;
        N3Dsl(isl) = -Lmax + nrev(isl,2)*Llen;
        M3Dsl(isl) = -Lmax + nrev(isl,3)*Llen;
      end
    end
        
    lw1 = 1;
    lw2 = 4;
    cncol = [.99,.71,.08];
    lncol = [.72,.53,.04];
    iTubes = 0;
    if( i58slran >= 1 )
      if( iTubes==1 )
        hst1 = streamtube(L3D,M3D,N3D,BL3D,BM3D,BN3D,L3Dsl,M3Dsl,N3Dsl);
        set(hst1,'FaceColor',lncol,'EdgeColor',lncol,'LineWidth',lw1);
        hold on
        hst2 = streamtube(L3D,M3D,N3D,-BL3D,-BM3D,-BN3D,L3Dsl,M3Dsl,N3Dsl);
        set(hst2,'FaceColor',lncol,'EdgeColor',lncol,'LineWidth',lw1)
      else
        hst1 = streamline(L3D,M3D,N3D,BL3D,BM3D,BN3D,L3Dsl,M3Dsl,N3Dsl);
        set(hst1,'Color',lncol,'LineWidth',lw1);
        hold on
        hst2 = streamline(L3D,M3D,N3D,-BL3D,-BM3D,-BN3D,L3Dsl,M3Dsl,N3Dsl);
        set(hst2,'Color',lncol,'LineWidth',lw1)
      end
    else
      hst1 = streamline(L3D,M3D,N3D,BL3D,BM3D,BN3D,L2Dcut(:),M2Dcut(:),N2Dcut(:));
      set(hst1,'Color',lncol,'LineWidth',lw1);
      hold on
      hst2 = streamline(L3D,M3D,N3D,-BL3D,-BM3D,-BN3D,L2Dcut(:),M2Dcut(:),N2Dcut(:));
      set(hst2,'Color',lncol,'LineWidth',lw1)
    end
    if( ~isempty(view58) )
      view(view58);
    else
      view(3);
    end
    hcn  = coneplot(L3D,M3D,N3D,fscl*BL3D,fscl*BM3D,fscl*BN3D,L2Dcut(:),M2Dcut(:),N2Dcut(:),0);
    set(hcn,'FaceColor',cncol,'EdgeColor','none');
    [xsph,ysph,zsph] = sphere(8); fsph = .25;
    for k = 1:4
      surf(fsph*xsph+xv(i,1,k),fsph*ysph+xv(i,2,k),fsph*zsph+xv(i,3,k),'FaceColor',casc(k,:));
%       scatter3(xv(i,1,k),xv(i,2,k),xv(i,3,k),'o','filled','Color',casc(k,:));
      hst3 = streamline(L3D,M3D,N3D,BL3D,BM3D,BN3D,xv(i,1,k),xv(i,2,k),xv(i,3,k));
      set(hst3,'Color',casc(k,:),'LineWidth',lw2);
      hst4 = streamline(L3D,M3D,N3D,-BL3D,-BM3D,-BN3D,xv(i,1,k),xv(i,2,k),xv(i,3,k));
      set(hst4,'Color',casc(k,:),'LineWidth',lw2);
    end
    hold off
    axis square
    camlight; lighting gouraud;
    grid on; box on;
    xlim([-Lmax,Lmax]);
    ylim([-Lmax,Lmax]);
    zlim([-Lmax,Lmax]);
    xlabel('L / L_{sc}','FontSize',fs0);
    ylabel('M / L_{sc}','FontSize',fs0);
    zlabel('N / L_{sc}','FontSize',fs0);
    set(gca,'FontSize',fs1);
    if( i58NoB0>=1 )
      title(['t = ' num2str(t(i),4) ' s, Reconstruction dB'],'FontSize',fs0)
    else
      if (iReconstructionLabel==1 )
        title(['t = ' num2str(t(i),4) ' s, Reconstruction B'],'FontSize',fs0)
      else
        title(['(' sLabel58Letter ') ' 't = ' num2str(t(i),4) ' s'],'FontSize',fs0)
      end
    end

%     set(hst,'Color','k')
%     axis xy;
%     axis square;
%     set(gca,'TickLength',ticklen);
%     set(gca,'TickDir','out');
%     set(gca,'XMinorTick','on')
%     set(gca,'YMinorTick','on')
%     set(gca,'FontSize',10);
%     if( irow==nrow ), xlabel(sXLab,'FontSize',12); else, set(gca,'XTickLabel',''); end
%     if( icol==1    ), ylabel(sYLab,'FontSize',12); else, set(gca,'YTickLabel',''); end
%     title(['(' char('c'+ipl-1) ') t = ' num2str(t(i),4)],'FontSize',10);
%     drawnow;

  if( iPlot58==2 ) 
    sFilePrefix = [sDirPlots 'Poly_B3D_BscOut' num2str(iScOutIn) '_dB' num2str(i58NoB0) '_iBrst' num2str(iBurst) '_Smo' num2str(nsmoothspan) '_Sub' num2str(iSubAvB) '_Rot' num2str(iRotate) '_noXRot' num2str(iNoXRotation) '_iSys' num2str(iSystem) '_iIncmprs' num2str(iIncmprs) '_iexctB' num2str(iExactB) '_iNF' num2str(iNormFlds) '_' num2str(wFlds(1)) '-' num2str(wFlds(2)) '-' num2str(wFlds(3)) '-' num2str(wFlds(4)) '-' num2str(wFlds(5)) '-' num2str(wFlds(6)) '_wB' num2str(wMag) '_iAltNe' num2str(iAltNe) '_iBMloc' num2str(iLocalBM)  '_t' num2str(t3D,4) ];
    export_fig([sFilePrefix],'-pdf');
    savefig([sFilePrefix '.fig']);
    save([sFilePrefix '.mat'],'X','mv','t','xv','xvn','iv');
  end
  
  if( iPrintView58==1 )
    for iview = 1:3
      view(printView58a(iview,:));
      title(['(' char(sLabel58Letter+iview-1)  ') ' 't = ' num2str(t(i),4) ' s'],'FontSize',fs0)
      sFilePrefix = ['polyview/' 'poly3Dview_sys' num2str(iSystem) '_az' num2str(printView58a(iview,1)) '_el' num2str(printView58a(iview,2)) '_t' num2str(t3D,4) ];
      export_fig([sFilePrefix '.pdf'],'-pdf');
%       export_fig([sFilePrefix '.eps'],'-eps');
%       print([sFilePrefix '.pdf'],'-dpdf');
%       print([sFilePrefix '.eps'],'-depsc2');
    end
  end
   
  if( iPlot582>=1 ) % ************ IMPORTANT *************** only works for x/y/z = L/M/N without rotation
    load('LiuY3D_251_41_192_3_2_2.mat');
    % save(smat,'fl3D','ny','nx','nz','nc','nfl','ntdat','ny0','nx0','iy1','iy2','ix1','ix2','sfl','sc','st','x0','x','y','z');
    % fl3D = zeros(ny,nx,nz,3,2,2); % x/y/z, comp, B/J, time 1/2
    load('LiuYCut3D_pos.mat');     % save('LiuYCut3D_pos.mat','tt','ntt','ft1','ft2','xsc');
    
    fii = interp1(tt,ft1,t(i)); fip = 1 - fii;
    fl3Dt = squeeze( fii*fl3D(:,:,:,:,:,1) + fip*fl3D(:,:,:,:,:,2) );
    xsct = squeeze( interp1(tt,xsc,t(i)) );

    [Xg,Yg,Zg] = meshgrid(x,y,z);
    flsct = zeros(5,3,2); % sc, ic, B/J
    for ifl = 1:2
      for ic = 1:3
        flsct(:,ic,ifl) = interp3(Xg,Yg,Zg,squeeze(fl3Dt(:,:,:,ic,ifl)),xsct(1,:)',xsct(2,:)',xsct(3,:)');
      end
    end
    flsct = permute(flsct,[2,3,1]);
    flsct(:,2,:) = dsc*flsct(:,2,:);  % **************** IMPORTANT to compare to normalized J
    
    bvt = interp1(t,bv,t(i));
    Jpvt = interp1(t,Jpv3,t(i));
    flsct0 = zeros(3,2,5);
    flsct0(:,1,1:4) = permute(bvt,[2,1,3]);
    flsct0(:,2,1:4) = permute(Jpvt,[2,1,3]);
    flsct0(:,:,5) = mean(flsct0(:,:,1:4),3);
    for k = 1:5
      display( reshape(flsct0(:,:,k),[1,6]) )
      display( reshape( flsct(:,:,k),[1,6]) )
    end % k
 
    if( iAltOrigin>=11 && iAltOrigin<=14 )
      isc0 = iAltOrigin - 10;
      add0 = dsc;
    elseif( iAltOrigin>=1 && iAltOrigin<=4 )
      isc0 = iAltOrigin;
      add0 = 0;
    else
      isc0 = 5; % Centroid
      add0 = 0;
    end
    L3Dg = L3D*dsc + xsct(1,isc0) + add0;  % ***************** IMPORTANT with units, not normalized
    M3Dg = M3D*dsc + xsct(2,isc0) + add0;
    N3Dg = N3D*dsc + xsct(3,isc0) + add0;
    
    flgt = zeros(nL*nL*nL,3,2);
    for ifl = 1:2
      for ic = 1:3
        flgt(:,ic,ifl) = interp3(Xg,Yg,Zg,squeeze(fl3Dt(:,:,:,ic,ifl)),L3Dg(:),M3Dg(:),N3Dg(:));
      end
    end
    flgt = reshape(flgt,[nL,nL,nL,3,2]);
    BL3Dg = squeeze(flgt(:,:,:,1,1));
    BM3Dg = squeeze(flgt(:,:,:,2,1));
    BN3Dg = squeeze(flgt(:,:,:,3,1));
    
    if( i58NoB0==1 )
      BL3Dg = BL3Dg - BL0;
      BM3Dg = BM3Dg - BM0;
      BN3Dg = BN3Dg - BN0;
    elseif( i58NoB0==2 )
      BM3Dg = BM3Dg - BM0;
    end
    
    if( i583_2D == 1 )
      nM = size(BL3Dg,2); nMd2 = 1 + (nM-1)/2;
      BL3Dg = repmat( BL3Dg(:,nMd2,:) , [1,nM,1] );
      BM3Dg = repmat( BM3Dg(:,nMd2,:) , [1,nM,1] );
      BN3Dg = repmat( BN3Dg(:,nMd2,:) , [1,nM,1] );     
    end
    
    B3Dgmag = sqrt( BL3Dg.^2 + BM3Dg.^2 + BN3Dg.^2 );
    
    if( iBerrOp==1 )
      B3DmagMax = max(B3Dgmag(:));
      dBL3D = BL3D - BL3Dg;
      dBM3D = BM3D - BM3Dg;
      dBN3D = BN3D - BN3Dg;
      dB3D = sqrt( dBL3D.^2 + dBM3D.^2 + dBN3D.^2 )/B3DmagMax;
    else
      B3Dmag = sqrt( BL3D.^2 + BM3D.^2 + BN3D.^2 );
      dB3D = acosd( ( BL3Dg(:).*BL3D(:) + BM3Dg(:).*BM3D(:) + BN3Dg(:).*BN3D(:) )./( B3Dgmag(:).*B3Dmag(:) ) );
      dB3D = reshape( dB3D , [nL,nL,nL] );
    end
    
    figure(582)
    clf;
    set(gcf,'Color','w');
    set(gcf,'Position',[150,50,600,600]);
    hax = axis;
    daspect([1 1 1]);
    view(3);
%     hsl = slice(L3D,M3D,N3D,dB3D,[Lmax,xv(i,1,2)],[Lmax,xv(i,2,2)],[-Lmax,xv(i,3,2)]);
    if( iErrBPlane(1)~=9 ), Lslices = [ iErrBPlane(1)*Lmax Lmax ]; else, Lslices = Lmax; end
    if( iErrBPlane(2)~=9 ), Mslices = [ iErrBPlane(2)*Lmax Lmax ]; else, Mslices = Lmax; end
    if( iErrBPlane(3)~=9 ), Nslices = [ iErrBPlane(3)*Lmax -Lmax ]; else, Nslices = -Lmax; end
    hsl = slice(L3D,M3D,N3D,dB3D,Lslices,Mslices,Nslices);
    set(hsl,'Edgecolor',gray,'FaceColor','interp');
%     set(hsl,'FaceColor','interp');
    hcb = colorbar;
    if( iBerrOp==1 )
      ylabel(hcb,'({\bfB}_{rcstr} - {\bfB}_{sim})/B_{sim,max}','FontSize',14);    else
      ylabel(hcb,'\theta_{{\bfB}rcstr,{\bfB}sim} (\circ)','FontSize',14);
    end
    hold on
    fsph = fsphB;
    for k = 1:4
      surf(fsph*xsph+xv(i,1,k),fsph*ysph+xv(i,2,k),fsph*zsph+xv(i,3,k),'FaceColor',casc(k,:));
%       scatter3(xv(i,1,k),xv(i,2,k),xv(i,3,k),'o','filled','Color',casc(k,:));
      hst3 = streamline(L3D,M3D,N3D,BL3Dg,BM3Dg,BN3Dg,xv(i,1,k),xv(i,2,k),xv(i,3,k));
      set(hst3,'Color',casc(k,:),'LineWidth',lw2);
      hst4 = streamline(L3D,M3D,N3D,-BL3Dg,-BM3Dg,-BN3Dg,xv(i,1,k),xv(i,2,k),xv(i,3,k));
      set(hst4,'Color',casc(k,:),'LineWidth',lw2);
    end
    if( isoErrB>0 )
      isosurface(L3D,M3D,N3D,dB3D,isoErrB);
    end
    alpha(0.5);
    hold off
    xlim([-Lmax,Lmax]);
    ylim([-Lmax,Lmax]);
    zlim([-Lmax,Lmax]);
%     camlight
    xlabel('L / L_{sc}','FontSize',14);
    ylabel('M / L_{sc}','FontSize',14);
    zlabel('N / L_{sc}','FontSize',14);
    if( i58NoB0>=1 )
      title(['t = ' num2str(t(i),4) ' s, Reconstruction Error in dB'],'FontSize',fs0)
    else
      title(['t = ' num2str(t(i),4) ' s, Reconstruction Error in B'],'FontSize',fs0)
    end
    
    if( iPlot582==2 )
      sFilePrefix = [sDirPlots 'Poly_B3Derr_BscOut' num2str(iScOutIn) '_dB' num2str(i58NoB0) '_errOp' num2str(iBerrOp) '_iBrst' num2str(iBurst) '_Smo' num2str(nsmoothspan) '_Sub' num2str(iSubAvB) '_Rot' num2str(iRotate) '_noXRot' num2str(iNoXRotation) '_iSys' num2str(iSystem) '_iIncmprs' num2str(iIncmprs) '_iexctB' num2str(iExactB) '_iNF' num2str(iNormFlds) '_' num2str(wFlds(1)) '-' num2str(wFlds(2)) '-' num2str(wFlds(3)) '-' num2str(wFlds(4)) '-' num2str(wFlds(5)) '-' num2str(wFlds(6)) '_wB' num2str(wMag) '_iAltNe' num2str(iAltNe) '_iBMloc' num2str(iLocalBM)  '_t' num2str(t3D,4) ];
      export_fig([sFilePrefix '.png'],'-png');
      savefig([sFilePrefix '.fig']);
    end
    
% Histogram of errors
    n1D = nL^3;
    dR = zeros(n1D,4);
    for isc = 1:4
      dR(:,isc) = sqrt( (L3D(:)- xv(i,1,isc)).^2 + (M3D(:)- xv(i,2,isc)).^2 + (N3D(:)- xv(i,3,isc)).^2 );
    end
    dR = min(dR,[],2);
    dRh = dRhB;
    Rmax = 1.5*Lmax;
    nh = round(Rmax/dRh)+1;
    wh = zeros(nh,1); dBh = zeros(nh,1); Rh = (0:dRh:Rmax)';
    for j = 1:n1D
      rr = dR(j)/dRh + 1;
      jj = floor(rr);
      jp = jj + 1;
      fjp = rr - jj;
      fjj = 1 - fjp;
      if( jj>=1 && jj<=nh )
        wh(jj) = wh(jj) + fjj;
        dBh(jj) = dBh(jj) + fjj*dB3D(j);
      end
      if( jp>=1 && jp<=nh )
        wh(jp) = wh(jp) + fjp;
        dBh(jp) = dBh(jp) + fjp*dB3D(j);
      end
    end % j
    dBh = dBh ./ wh;
    % Get quartile values
    nhm = nh - 1;
    Rqh = (dRh:dRh:Rmax)' - dRh/2;
    qBh = zeros(nhm,3);
    for ih = 1:nhm
      jj = find(dR>=(ih-1)*dRh & dR<=ih*dRh );
      qBh(ih,:) = quantile(dB3D(jj),[.25,.5,.75]);
    end % ih  
    
    figure(584)
    set(gcf,'Position',[200,300,300,350])
    fs = 14; fslg = 10;  lw1 = 1; lw24 = 2;
    set(gcf,'Color','w');
    plot(Rh,dBh,'b','Linewidth',lw24)
    hold on
    plot(Rqh,qBh,'k')
    hold off
    if( imax584==1 )
      ylim([0 max584])
    end
    xlabel('R_{nearest} / L_{sc}','FontSize',fs);
    if( iBerrOp==1 )
      ylabel('|{\bfB}_{rcstr} - {\bfB}_{sim}|/B_{sim,max}','FontSize',fs);    
    else
      ylabel('\theta_{{\bfB}rcstr,{\bfB}sim} (\circ)','FontSize',12);
    end
    if( i58NoB0>=1 )
      title(['t = ' num2str(t(i),4) ' s, Error in dB'],'FontSize',fs0)
    else
      title(['t = ' num2str(t(i),4) ' s, Error in B'],'FontSize',fs0)
    end
    hlg = legend('Mean','1st Quartile','Median','3rd Quartile');
    set(hlg,'Location','NorthWest','FontSize',fslg)
    
    if( iPlot584==2 )
      if( iSystem==28 && i28termRaw==1 )
        sFilePrefix = [sDirPlots 'Poly_BhistErr_dB' num2str(i58NoB0) '_errOp' num2str(iBerrOp) '_iBrst' num2str(iBurst) '_Smo' num2str(nsmoothspan) '_Sub' num2str(iSubAvB) '_Rot' num2str(iRotate) '_noXRot' num2str(iNoXRotation) '_iSys28r_iIncmprs' num2str(iIncmprs) '_iexctB' num2str(iExactB) '_iNF' num2str(iNormFlds) '_' num2str(wFlds(1)) '-' num2str(wFlds(2)) '-' num2str(wFlds(3)) '-' num2str(wFlds(4)) '-' num2str(wFlds(5)) '-' num2str(wFlds(6)) '_wB' num2str(wMag) '_iAltNe' num2str(iAltNe) '_iBMloc' num2str(iLocalBM) '_t' num2str(t3D,4) ];
      else
        sFilePrefix = [sDirPlots 'Poly_BhistErr_BscOut' num2str(iScOutIn) '_dB' num2str(i58NoB0) '_errOp' num2str(iBerrOp) '_iBrst' num2str(iBurst) '_Smo' num2str(nsmoothspan) '_Sub' num2str(iSubAvB) '_Rot' num2str(iRotate) '_noXRot' num2str(iNoXRotation) '_iSys' num2str(iSystem) '_iIncmprs' num2str(iIncmprs) '_iexctB' num2str(iExactB) '_iNF' num2str(iNormFlds) '_' num2str(wFlds(1)) '-' num2str(wFlds(2)) '-' num2str(wFlds(3)) '-' num2str(wFlds(4)) '-' num2str(wFlds(5)) '-' num2str(wFlds(6)) '_wB' num2str(wMag) '_iAltNe' num2str(iAltNe) '_iBMloc' num2str(iLocalBM) '_t' num2str(t3D,4) ];      
      end
      export_fig([sFilePrefix '.pdf'],'-pdf');
%       savefig([sFilePrefix '.fig']);
    end
    
    Bmagg = sqrt( BL3Dg.^2 + BM3Dg.^2 + BN3Dg.^2 );
    Bmax = max(Bmagg(:));
    fscl = 1/Bmax;
    if( i58slran == 1 )
      Bmagc = Bmagg(2:end-1,2:end-1,2:end-1);
      Bmagc1D = Bmagc(:);
      wsl = Bmagc1D/sum(Bmagc1D);
      nwsl = numel(wsl);
      fsl = zeros(size(wsl));
      fsl(2) = wsl(1) + 0.5*wsl(2);
      for ii = 3:nwsl-1
        fsl(ii) = fsl(ii-1) + 0.5*( wsl(ii-1) + wsl(ii) );
      end
      fsl(end) = 1;
      fslreg = linspace(0,1,nwsl)';
      infslreg = interp1(fsl,(1:nwsl)',fslreg);
      nsl = 60;
      fsl = rand(nsl,1);
      insl = round( interp1(fslreg,infslreg,fsl) );
      nLm2 = nL - 2;
      [inM,inL,inN] = ind2sub([nLm2,nLm2,nLm2],insl);
      M3Dsl = La(inM+1);
      L3Dsl = La(inL+1);
      N3Dsl = La(inN+1);
    end    
    
    if( iPlot583>=1 )
      
      figure(583)
      clf;
      i = find( abs(t-t3D) == min(abs(t-t3D)) , 1 );
      set(gcf,'Color','w');
      set(gcf,'Position',[200,50,600,600]);
      if( i58slran >= 1 )
        if( iTubes==1 )
          hst1 = streamtube(L3D,M3D,N3D,BL3Dg,BM3Dg,BN3Dg,L3Dsl,M3Dsl,N3Dsl);
          set(hst1,'FaceColor',lncol,'EdgeColor',lncol,'LineWidth',lw1);
          view(3);
          hold on
          hst2 = streamtube(L3D,M3D,N3D,-BL3Dg,-BM3Dg,-BN3Dg,L3Dsl,M3Dsl,N3Dsl);
          set(hst2,'FaceColor',lncol,'EdgeColor',lncol,'LineWidth',lw1)
        else
          hst1 = streamline(L3D,M3D,N3D,BL3Dg,BM3Dg,BN3Dg,L3Dsl,M3Dsl,N3Dsl);
          set(hst1,'Color',lncol,'LineWidth',lw1);
          view(3);
          hold on
          hst2 = streamline(L3D,M3D,N3D,-BL3Dg,-BM3Dg,-BN3Dg,L3Dsl,M3Dsl,N3Dsl);
          set(hst2,'Color',lncol,'LineWidth',lw1)
        end
      else
        hst1 = streamline(L3D,M3D,N3D,BL3Dg,BM3Dg,BN3Dg,L2Dcut(:),M2Dcut(:),N2Dcut(:));
        set(hst1,'Color',lncol,'LineWidth',lw1);
        view(3);
        hold on
        hst2 = streamline(L3D,M3D,N3D,-BL3Dg,-BM3Dg,-BN3Dg,L2Dcut(:),M2Dcut(:),N2Dcut(:));
        set(hst2,'Color',lncol,'LineWidth',lw1)
      end
      hcn  = coneplot(L3D,M3D,N3D,fscl*BL3Dg,fscl*BM3Dg,fscl*BN3Dg,L2Dcut(:),M2Dcut(:),N2Dcut(:),0);
      set(hcn,'FaceColor',cncol,'EdgeColor','none');
      [xsph,ysph,zsph] = sphere(8); fsph = .125;
      for k = 1:4
        surf(fsph*xsph+xv(i,1,k),fsph*ysph+xv(i,2,k),fsph*zsph+xv(i,3,k),'FaceColor',casc(k,:));
        %       scatter3(xv(i,1,k),xv(i,2,k),xv(i,3,k),'o','filled','Color',casc(k,:));
        hst3 = streamline(L3D,M3D,N3D,BL3Dg,BM3Dg,BN3Dg,xv(i,1,k),xv(i,2,k),xv(i,3,k));
        set(hst3,'Color',casc(k,:),'LineWidth',lw2);
        hst4 = streamline(L3D,M3D,N3D,-BL3Dg,-BM3Dg,-BN3Dg,xv(i,1,k),xv(i,2,k),xv(i,3,k));
        set(hst4,'Color',casc(k,:),'LineWidth',lw2);
      end
      hold off
      axis square
      camlight; lighting gouraud;
      grid on; box on;
      xlim([-Lmax,Lmax]);
      ylim([-Lmax,Lmax]);
      zlim([-Lmax,Lmax]);
      xlabel('L / L_{sc}','FontSize',14);
      ylabel('M / L_{sc}','FontSize',14);
      zlabel('N / L_{sc}','FontSize',14);
      if( i58NoB0>=1 )
        title(['t = ' num2str(t(i),4) ' s, Simulation dB'],'FontSize',fs0)
      else
        title(['t = ' num2str(t(i),4) ' s, Simulation B'],'FontSize',fs0)
      end
      
      box on
      grid on
      
      if( iPlot583==2 )
        sFilePrefix = [sDirPlots 'Poly_B3Dsim_BscOut' num2str(iScOutIn) '_dB' num2str(i58NoB0) '_iBrst' num2str(iBurst) '_Smo' num2str(nsmoothspan) '_Sub' num2str(iSubAvB) '_Rot' num2str(iRotate) '_noXRot' num2str(iNoXRotation) '_iSys' num2str(iSystem) '_iIncmprs' num2str(iIncmprs) '_iexctB' num2str(iExactB) '_iNF' num2str(iNormFlds) '_' num2str(wFlds(1)) '-' num2str(wFlds(2)) '-' num2str(wFlds(3)) '-' num2str(wFlds(4)) '-' num2str(wFlds(5)) '-' num2str(wFlds(6)) '_wB' num2str(wMag) '_iAltNe' num2str(iAltNe) '_iBMloc' num2str(iLocalBM) '_t' num2str(t3D,4) ];
        export_fig([sFilePrefix '.pdf'],'-pdf');
        savefig([sFilePrefix '.fig']);
      end
      
    end % iPlot583
    

  end % iPlot582
    
end % iPlot58

%% 3D Plot of J

if( iPlot68>0 )
  figure(68)
  clf;
  i = find( abs(t-t3D) == min(abs(t-t3D)) , 1 );
  set(gcf,'Color','w');
  set(gcf,'Position',[100,50,600,600]);
  
  ticklen = [0.04 0.02];
  wid1 = 1.5; wid2 = 2; wid3 = 2; fs1 = 9; fs2 = 11; fs0 = 12; 
  casc = [ gray ; 1 0 0 ; 0 .8 0 ; .3 .3 1 ];
  
  nL = nLJ; nLcut = 7;
  nLd2 = 1 + round((nL-1)/2);
  La = linspace(-Lmax,Lmax,nL); dL = La(2) - La(1);
  Lacut = linspace(-Lmax,Lmax,nLcut);
  [L3D,M3D,N3D] = meshgrid(La,La,La);
  if( i3DaltLN==1 )
    [M2Dcut,N2Dcut] = meshgrid(Lacut); L2Dcut = zeros(nLcut);
%     M2Dcut = [ M2Dcut(:) ; M2Dcut(:) ];
%     N2Dcut = [ N2Dcut(:) ; N2Dcut(:) ];
%     L2Dcut = [ L2Dcut(:) ; -L2Dcut(:) ];
  elseif( i3DaltLN==2 )
    [L2Dcut,M2Dcut] = meshgrid(Lacut); N2Dcut = zeros(nLcut);
  else
    [L2Dcut,N2Dcut] = meshgrid(Lacut); M2Dcut = zeros(nLcut);
  end
  
  l3D = zeros(nL,nL,nL); m3D = zeros(nL,nL,nL); n3D = zeros(nL,nL,nL);
  BL3D = zeros(nL,nL,nL); BM3D = zeros(nL,nL,nL); BN3D = zeros(nL,nL,nL);

  mv1 = squeeze(mv(i,:,:));
  for k1 = 1:nL
    for i1 = 1:nL
      for j1 = 1:nL
        Pos1 = [ L3D(j1,i1,k1) M3D(j1,i1,k1) N3D(j1,i1,k1) ];
        pos1 = Pos1 * mv1;
        l3D(j1,i1,k1) = pos1(1);
        m3D(j1,i1,k1) = pos1(2);
        n3D(j1,i1,k1) = pos1(3);
      end
    end
  end
    
    X1 = X(i,:);
    
    % B = J here
    if( iSystem==1 )
      % J_s,L
      Bl3D = -X1(6) - X1(8)*n3D - X1(10)*l3D;
      % J_s,M
      Bm3D = X1(2) + X1(4)*n3D ...
        -X1(13) - X1(14)*l3D;
      % J_s,N
      Bn3D = X1(7) + X1(10)*n3D + X1(9)*l3D;
    elseif( iSystem==2 )
      % J_s,L
      Bl3D = X1(16) ...
        - X1( 7) - X1(10)*n3D - X1(12)*l3D;
      % J_s,M
      Bm3D = X1( 2) + X1( 5)*n3D ...
        -X1(15) - X1(17)*l3D;
      % J_s,N
      Bn3D = X1( 8) + X1(12)*n3D + X1(11)*l3D ...
        -X1( 4);
    elseif( iSystem==8 )
      % J_s,L
      Bl3D = X1(15) + X1(17)*m3D ...
        - X1( 9) - X1(12)*n3D;
      % J_s,M
      Bm3D = X1( 2) + X1( 5)*n3D + X1( 7)*m3D ...
        -X1(16);
      % J_s,N
      Bn3D = X1(11) ...
        -X1( 3) - X1( 7)*n3D - X1( 6)*m3D;
    elseif( iSystem==9 )
      % J_s,L
      Bl3D = X1(22) + X1(26)*n3D + X1(27)*l3D ...
        -X1(11) - X1(14)*n3D - X1(16)*l3D - X1(17)*m3D;
      if( i28term==2 )
        Bl3D = Bl3D + -X1(  28)*n3D.*l3D;
      elseif( i28term==3 )
        Bl3D = Bl3D + X1(  28)*l3D.^2/2 ;
      elseif( i28term==5 )
        Bl3D = Bl3D + X1(  28)*( -n3D.*l3D ...
          + l3D.^2/2 );
      end
      % J_s,M
      Bm3D = X1( 2) + X1( 5)*n3D + X1( 7)*l3D + X1( 8)*m3D ...
        -X1(21) - X1(25)*n3D - X1(24)*l3D - X1(27)*m3D;
      if( i28term==1 )
        Bm3D = Bm3D + X1(  28)*n3D.^2/2;
      elseif( i28term==3 )
        Bm3D = Bm3D + -X1(  28)*l3D.*m3D ;
      elseif( i28term==4 )
        Bm3D = Bm3D + X1(  28)*n3D.*m3D ;
      elseif( i28term==5 )
        Bm3D = Bm3D + X1(  28)*( -l3D.*m3D ...
          +n3D.*m3D );
      end
      % J_s,N
      Bn3D = X1(12) + X1(16)*n3D + X1(15)*l3D + X1(18)*m3D ...
        -X1( 4) - X1( 8)*n3D - X1( 9)*l3D;
      if( i28term==2 )
        Bn3D = Bn3D + X1(  28)*n3D.^2/2;
      elseif( i28term==4 )
        Bn3D = Bn3D + -X1(  28)*n3D.^2/2 ;
        %         elseif( i28term==5 )
        %           Bn3D = Bn3D + X1(  28)*( n3D.^2/2 ...
        %                                                        - n3D.^2/2 ) ;   % = 0
      end
    elseif( iSystem==28 )
      nn3D = n3D.^2/2;
      nl3D = n3D.*l3D;
      nm3D = n3D.*m3D;
      ll3D = l3D.^2/2;
      lm3D = l3D.*m3D;
      % J_s,L
      Bl3D = X1(22) + X1(26)*n3D + X1(27)*l3D ...
        -X1(11) - X1(14)*n3D - X1(16)*l3D - X1(17)*m3D;
      % J_s,M
      Bm3D = X1( 2) + X1( 5)*n3D + X1( 7)*l3D + X1( 8)*m3D ...
        -X1(21) - X1(25)*n3D - X1(24)*l3D - X1(27)*m3D;
      % J_s,N
      Bn3D = X1(12) + X1(16)*n3D + X1(15)*l3D + X1(18)*m3D ...
        -X1( 4) - X1( 8)*n3D - X1( 9)*l3D;
      for icX = 1:nvarx
        switch icX
          case 1
            Bm3D = Bm3D + X1(27+icX)*nm3D;
            Bn3D = Bn3D - X1(27+icX)*nn3D;
          case 2
            Bl3D = Bl3D - X1(27+icX)*nl3D;
            Bn3D = Bn3D + X1(27+icX)*nn3D;
          case 3
            Bl3D = Bl3D - X1(27+icX)*ll3D;
            Bn3D = Bn3D + X1(27+icX)*nl3D;
          case 4
            Bl3D = Bl3D + X1(27+icX)*ll3D;
            Bm3D = Bm3D - X1(27+icX)*lm3D;
          case 5
            Bm3D = Bm3D + X1(27+icX)*nn3D;
          case 6
            Bl3D = Bl3D - X1(27+icX)*nn3D;
          case 7
            Bn3D = Bn3D + X1(27+icX)*ll3D;
          case 8
            Bm3D = Bm3D - X1(27+icX)*ll3D;
          case 9
            Bm3D = Bm3D + X1(27+icX)*nl3D;
          case 10
            Bm3D = Bm3D + X1(27+icX)*( ll3D + nn3D );
          case 11
            Bm3D = Bm3D + X1(27+icX)*nl3D;
          case 12
            Bl3D = Bl3D - X1(27+icX)*nn3D;
            Bm3D = Bm3D + X1(27+icX)*lm3D;
            Bn3D = Bn3D - X1(27+icX)*nl3D;
          case 13
            Bl3D = Bl3D - X1(27+icX)*nl3D;
            Bm3D = Bm3D + X1(27+icX)*nm3D;
            Bn3D = Bn3D - X1(27+icX)*ll3D;
          case 14
            Bn3D = Bn3D - X1(27+icX)*m3D;
            % case 15
            % 0
          case 16
            Bl3D = Bl3D + X1(27+icX)*m3D;
        end
      end
    else
      % J_s,L
      iY1 = (13:16);
      Y1(iY1) = -X1(iv(11)) - X1(iv(13))*n3D - X1(iv(14))*l3D;
      if( iQuadSys<1 )
        Y1(iY1) = Y1(iY1) + X1(iv(25)) - X1(iv(17))*m3D + X1(iv(26))*n3D + X1(iv(27))*l3D;
      elseif( iQuadSys==1 )
        Y1(iY1) = Y1(iY1) + X1(iv(25)) - X1(iv(17))*m3D;
      elseif( iQuadSys==2 )
        Y1(iY1) = Y1(iY1) + X1(iv(25));
      end
      % J_s,M
      iY1 = (17:20);
      Y1(iY1) = X1(iv( 2)) - X1(iv(21)) + X1(iv( 4))*n3D + X1(iv( 5))*l3D - X1(iv(23))*n3D - X1(iv(24))*l3D;
      if( iQuadSys<1 )
        Y1(iY1) = Y1(iY1) + X1(iv( 8))*m3D - X1(iv(27))*m3D;
      elseif( iQuadSys==1 )
        Y1(iY1) = Y1(iY1) + X1(iv( 8))*m3D;
      end
      if( iQuadSys==-1 )
        Y1(iY1) = Y1(iY1) + X1(28)*n3D.^2/2;
      end
      % J_s,N
      iY1 = (21:24);
      Y1(iY1) = X1(iv(12)) + X1(iv(14))*n3D + X1(iv(15))*l3D;
      if( iQuadSys<1 )
        Y1(iY1) = Y1(iY1) + -X1(iv( 7)) - X1(iv( 8))*n3D + X1(iv(18))*m3D - X1(iv( 9))*l3D;
      elseif( iQuadSys==1 )
        Y1(iY1) = Y1(iY1) + -X1(iv( 7)) - X1(iv( 8))*n3D;
      elseif( iQuadSys==2 )
        Y1(iY1) = Y1(iY1) + -X1(iv( 7));
      end
    end % iSystem
    
    mv1p = mv1';
    for k1 = 1:nL
      for i1 = 1:nL
        for j1 = 1:nL
          mag1 = [ Bl3D(j1,i1,k1) Bm3D(j1,i1,k1) Bn3D(j1,i1,k1) ];
          Mag1 = mag1 * mv1p;
          BL3D(j1,i1,k1) = Mag1(1);
          BM3D(j1,i1,k1) = Mag1(2);
          BN3D(j1,i1,k1) = Mag1(3);
        end
      end
    end

    if( i68NoJ0==1 )
      if( iJ0op==1 )
        BL0 = Jpvav3(i,1); BM0 = Jpvav3(i,2); BN0 = Jpvav3(i,3);
      else
        BL0 = BL3D(nLd2,nLd2,nLd2);
        BM0 = BM3D(nLd2,nLd2,nLd2);
        BN0 = BN3D(nLd2,nLd2,nLd2);
      end
      BL3D = BL3D - BL0;
      BM3D = BM3D - BM0;
      BN3D = BN3D - BN0;
    end
    
%     BL2Dcut = interp3(L3D,M3D,N3D,BL3D,L2Dcut(:),M2Dcut(:),N2Dcut(:));
%     BM2Dcut = interp3(L3D,M3D,N3D,BM3D,L2Dcut(:),M2Dcut(:),N2Dcut(:));
%     BN2Dcut = interp3(L3D,M3D,N3D,BN3D,L2Dcut(:),M2Dcut(:),N2Dcut(:));

    Bmag = sqrt( BL3D.^2 + BM3D.^2 + BN3D.^2 );
    Bmax = max(Bmag(:));
    fscl = 1/Bmax;
    if( i68slran == 1 )
      Bmagc = Bmag(2:end-1,2:end-1,2:end-1);
      Bmagc1D = Bmagc(:);
      wsl = Bmagc1D/sum(Bmagc1D);
      nwsl = numel(wsl);
      fsl = zeros(size(wsl));
      fsl(2) = wsl(1) + 0.5*wsl(2);
      for ii = 3:nwsl-1
        fsl(ii) = fsl(ii-1) + 0.5*( wsl(ii-1) + wsl(ii) );
      end
      fsl(end) = 1;
      fslreg = linspace(0,1,nwsl)';
      infslreg = interp1(fsl,(1:nwsl)',fslreg);
      nsl = 60;
      fsl = rand(nsl,1);
      insl = round( interp1(fslreg,infslreg,fsl) );
      nLm2 = nL - 2;
      [inM,inL,inN] = ind2sub([nLm2,nLm2,nLm2],insl);
      M3Dsl = La(inM+1);
      L3Dsl = La(inL+1);
      N3Dsl = La(inN+1);
    end
        
    lw1 = 1;
    lw2 = 2;
    cncol = [.99,.71,.08];
    lncol = [.72,.53,.04];
    iTubes = 0;
    if( i68slran == 1 )
      if( iTubes==1 )
        hst1 = streamtube(L3D,M3D,N3D,BL3D,BM3D,BN3D,L3Dsl,M3Dsl,N3Dsl);
        set(hst1,'FaceColor',lncol,'EdgeColor',lncol,'LineWidth',lw1);
        view(3);
        hold on
        hst2 = streamtube(L3D,M3D,N3D,-BL3D,-BM3D,-BN3D,L3Dsl,M3Dsl,N3Dsl);
        set(hst2,'FaceColor',lncol,'EdgeColor',lncol,'LineWidth',lw1)
      else
        hst1 = streamline(L3D,M3D,N3D,BL3D,BM3D,BN3D,L3Dsl,M3Dsl,N3Dsl);
        set(hst1,'Color',lncol,'LineWidth',lw1);
        view(3);
        hold on
        hst2 = streamline(L3D,M3D,N3D,-BL3D,-BM3D,-BN3D,L3Dsl,M3Dsl,N3Dsl);
        set(hst2,'Color',lncol,'LineWidth',lw1)
      end
    else
      hst1 = streamline(L3D,M3D,N3D,BL3D,BM3D,BN3D,L2Dcut(:),M2Dcut(:),N2Dcut(:));
      set(hst1,'Color',lncol,'LineWidth',lw1);
      view(3);
      hold on
      hst2 = streamline(L3D,M3D,N3D,-BL3D,-BM3D,-BN3D,L2Dcut(:),M2Dcut(:),N2Dcut(:));
      set(hst2,'Color',lncol,'LineWidth',lw1)
    end
    hcn  = coneplot(L3D,M3D,N3D,fscl*BL3D,fscl*BM3D,fscl*BN3D,L2Dcut(:),M2Dcut(:),N2Dcut(:),0);
    set(hcn,'FaceColor',cncol,'EdgeColor','none');
    [xsph,ysph,zsph] = sphere(8); fsph = .125;
    for k = 1:4
      surf(fsph*xsph+xv(i,1,k),fsph*ysph+xv(i,2,k),fsph*zsph+xv(i,3,k),'FaceColor',casc(k,:));
%       scatter3(xv(i,1,k),xv(i,2,k),xv(i,3,k),'o','filled','Color',casc(k,:));
      hst3 = streamline(L3D,M3D,N3D,BL3D,BM3D,BN3D,xv(i,1,k),xv(i,2,k),xv(i,3,k));
      set(hst3,'Color',casc(k,:),'LineWidth',lw2);
      hst4 = streamline(L3D,M3D,N3D,-BL3D,-BM3D,-BN3D,xv(i,1,k),xv(i,2,k),xv(i,3,k));
      set(hst4,'Color',casc(k,:),'LineWidth',lw2);
    end
    hold off
    axis square
    camlight; lighting gouraud;
    grid on; box on;
    xlim([-Lmax,Lmax]);
    ylim([-Lmax,Lmax]);
    zlim([-Lmax,Lmax]);
    xlabel('L / L_{sc}','FontSize',14);
    ylabel('M / L_{sc}','FontSize',14);
    zlabel('N / L_{sc}','FontSize',14);
    if( i68NoJ0==1 )
      title(['t = ' num2str(t(i),4) ' s, Reconstruction dJ'],'FontSize',fs0)
    else
      title(['t = ' num2str(t(i),4) ' s, Reconstruction J'],'FontSize',fs0)
    end

%     set(hst,'Color','k')
%     axis xy;
%     axis square;
%     set(gca,'TickLength',ticklen);
%     set(gca,'TickDir','out');
%     set(gca,'XMinorTick','on')
%     set(gca,'YMinorTick','on')
%     set(gca,'FontSize',10);
%     if( irow==nrow ), xlabel(sXLab,'FontSize',12); else, set(gca,'XTickLabel',''); end
%     if( icol==1    ), ylabel(sYLab,'FontSize',12); else, set(gca,'YTickLabel',''); end
%     title(['(' char('c'+ipl-1) ') t = ' num2str(t(i),4)],'FontSize',10);
%     drawnow;

  if( iPlot68==2 ) 
    sFilePrefix = [sDirPlots 'Poly_J3D_BscOut' num2str(iScOutIn) '_dJ' num2str(i68NoJ0) '_iBrst' num2str(iBurst) '_Smo' num2str(nsmoothspan) '_Sub' num2str(iSubAvB) '_Rot' num2str(iRotate) '_noXRot' num2str(iNoXRotation) '_iSys' num2str(iSystem) '_iIncmprs' num2str(iIncmprs) '_iexctB' num2str(iExactB) '_iNF' num2str(iNormFlds) '_' num2str(wFlds(1)) '-' num2str(wFlds(2)) '-' num2str(wFlds(3)) '-' num2str(wFlds(4)) '-' num2str(wFlds(5)) '-' num2str(wFlds(6)) '_wB' num2str(wMag) '_iAltNe' num2str(iAltNe) '_iBMloc' num2str(iLocalBM) '_t' num2str(tlo,3) '-' num2str(thi,3) ];
    export_fig([sFilePrefix '.pdf'],'-pdf');
    savefig([sFilePrefix '.fig']);
  end
   
  if( iPlot682>=1 ) % ************ IMPORTANT *************** only works for x/y/z = L/M/N without rotation
    load('LiuY3D_251_41_192_3_2_2.mat');
    % save(smat,'fl3D','ny','nx','nz','nc','nfl','ntdat','ny0','nx0','iy1','iy2','ix1','ix2','sfl','sc','st','x0','x','y','z');
    % fl3D = zeros(ny,nx,nz,3,2,2); % x/y/z, comp, B/J, time 1/2
    load('LiuYCut3D_pos.mat');     % save('LiuYCut3D_pos.mat','tt','ntt','ft1','ft2','xsc');
    
    fii = interp1(tt,ft1,t(i)); fip = 1 - fii;
    fl3Dt = squeeze( fii*fl3D(:,:,:,:,:,1) + fip*fl3D(:,:,:,:,:,2) );
    xsct = squeeze( interp1(tt,xsc,t(i)) );

    [Xg,Yg,Zg] = meshgrid(x,y,z);
    flsct = zeros(5,3,2); % sc, ic, B/J
    for ifl = 1:2
      for ic = 1:3
        flsct(:,ic,ifl) = interp3(Xg,Yg,Zg,squeeze(fl3Dt(:,:,:,ic,ifl)),xsct(1,:)',xsct(2,:)',xsct(3,:)');
      end
    end
    flsct = permute(flsct,[2,3,1]);
    flsct(:,2,:) = dsc*flsct(:,2,:);  % **************** IMPORTANT to compare to normalized J
    
    bvt = interp1(t,bv,t(i));
    Jpvt = interp1(t,Jpv3,t(i));
    flsct0 = zeros(3,2,5);
    flsct0(:,1,1:4) = permute(bvt,[2,1,3]);
    flsct0(:,2,1:4) = permute(Jpvt,[2,1,3]);
    flsct0(:,:,5) = mean(flsct0(:,:,1:4),3);
    for k = 1:5
      display( reshape(flsct0(:,:,k),[1,6]) )
      display( reshape( flsct(:,:,k),[1,6]) )
    end % k
 
    if( iAltOrigin>=11 && iAltOrigin<=14 )
      isc0 = iAltOrigin - 10;
      add0 = dsc;
    elseif( iAltOrigin>=1 && iAltOrigin<=4 )
      isc0 = iAltOrigin;
      add0 = 0;
    else
      isc0 = 5; % Centroid
      add0 = 0;
    end
    L3Dg = L3D*dsc + xsct(1,isc0) + add0;  % ***************** IMPORTANT with units, not normalized
    M3Dg = M3D*dsc + xsct(2,isc0) + add0;
    N3Dg = N3D*dsc + xsct(3,isc0) + add0;
    
    flgt = zeros(nL*nL*nL,3,2);
    for ifl = 1:2
      for ic = 1:3
        flgt(:,ic,ifl) = interp3(Xg,Yg,Zg,squeeze(fl3Dt(:,:,:,ic,ifl)),L3Dg(:),M3Dg(:),N3Dg(:));
      end
    end
    flgt = reshape(flgt,[nL,nL,nL,3,2]);
    BL3Dg = squeeze(flgt(:,:,:,1,2))*dsc;  % ***** B = J here **** IMPORTANT with units, not normalized
    BM3Dg = squeeze(flgt(:,:,:,2,2))*dsc;
    BN3Dg = squeeze(flgt(:,:,:,3,2))*dsc;
    
    if( i68NoJ0==1 )
      BL3Dg = BL3Dg - BL0;
      BM3Dg = BM3Dg - BM0;
      BN3Dg = BN3Dg - BN0;
    end
    
    B3Dgmag = sqrt( BL3Dg.^2 + BM3Dg.^2 + BN3Dg.^2 );
    
    if( iJerrOp==1 )
      B3DmagMax = max(B3Dgmag(:));
      dBL3D = BL3D - BL3Dg;
      dBM3D = BM3D - BM3Dg;
      dBN3D = BN3D - BN3Dg;
      dB3D = sqrt( dBL3D.^2 + dBM3D.^2 + dBN3D.^2 )/B3DmagMax;
    else
      B3Dmag = sqrt( BL3D.^2 + BM3D.^2 + BN3D.^2 );
      dB3D = acosd( ( BL3Dg(:).*BL3D(:) + BM3Dg(:).*BM3D(:) + BN3Dg(:).*BN3D(:) )./( B3Dgmag(:).*B3Dmag(:) ) );
      dB3D = reshape( dB3D , [nL,nL,nL] );
    end
    
    figure(682)
    clf;
    set(gcf,'Color','w');
    set(gcf,'Position',[650,50,600,600]);
    hax = axis;
    daspect([1 1 1]);
    view(3);
    if( iErrJPlane(1)~=9 ), Lslices = [ iErrJPlane(1)*Lmax Lmax ]; else, Lslices = Lmax; end
    if( iErrJPlane(2)~=9 ), Mslices = [ iErrJPlane(2)*Lmax Lmax ]; else, Mslices = Lmax; end
    if( iErrJPlane(3)~=9 ), Nslices = [ iErrJPlane(3)*Lmax -Lmax ]; else, Nslices = -Lmax; end
    hsl = slice(L3D,M3D,N3D,dB3D,Lslices,Mslices,Nslices);
    set(hsl,'Edgecolor',gray,'FaceColor','interp');
%     set(hsl,'FaceColor','interp');
    hcb = colorbar;
    if( iJerrOp==1 )
      ylabel(hcb,'({\bfJ}_{rcstr} - {\bfJ}_{sim})/J_{sim,max}','FontSize',14);
    else
      ylabel(hcb,'\theta_{{\bfJ}rcstr,{\bfJ}sim} (\circ)','FontSize',14);
    end
    hold on
    fsph = fsphJ;
    for k = 1:4
      surf(fsph*xsph+xv(i,1,k),fsph*ysph+xv(i,2,k),fsph*zsph+xv(i,3,k),'FaceColor',casc(k,:));
%       scatter3(xv(i,1,k),xv(i,2,k),xv(i,3,k),'o','filled','Color',casc(k,:));
      hst3 = streamline(L3D,M3D,N3D,BL3Dg,BM3Dg,BN3Dg,xv(i,1,k),xv(i,2,k),xv(i,3,k));
      set(hst3,'Color',casc(k,:),'LineWidth',lw2);
      hst4 = streamline(L3D,M3D,N3D,-BL3Dg,-BM3Dg,-BN3Dg,xv(i,1,k),xv(i,2,k),xv(i,3,k));
      set(hst4,'Color',casc(k,:),'LineWidth',lw2);
    end
    if( isoErrJ>0 )
      isosurface(L3D,M3D,N3D,dB3D,isoErrJ);
    end
    alpha(0.5);
    hold off
%     camlight
    xlim([-Lmax,Lmax]);
    ylim([-Lmax,Lmax]);
    zlim([-Lmax,Lmax]);
    xlabel('L / L_{sc}','FontSize',14);
    ylabel('M / L_{sc}','FontSize',14);
    zlabel('N / L_{sc}','FontSize',14);
    if( i68NoJ0==1 )
      title(['t = ' num2str(t(i),4) ' s, Reconstruction Error in dJ'],'FontSize',fs0)
    else
      title(['t = ' num2str(t(i),4) ' s, Reconstruction Error in J'],'FontSize',fs0)
    end
    
    if( iPlot682==2 )
      sFilePrefix = [sDirPlots 'Poly_J3Derr_BscOut' num2str(iScOutIn) '_dJ' num2str(i68NoJ0) '_errOp' num2str(iJerrOp) '_iBrst' num2str(iBurst) '_Smo' num2str(nsmoothspan) '_Sub' num2str(iSubAvB) '_Rot' num2str(iRotate) '_noXRot' num2str(iNoXRotation) '_iSys' num2str(iSystem) '_iIncmprs' num2str(iIncmprs) '_iexctB' num2str(iExactB) '_iNF' num2str(iNormFlds) '_' num2str(wFlds(1)) '-' num2str(wFlds(2)) '-' num2str(wFlds(3)) '-' num2str(wFlds(4)) '-' num2str(wFlds(5)) '-' num2str(wFlds(6)) '_wB' num2str(wMag) '_iAltNe' num2str(iAltNe) '_iBMloc' num2str(iLocalBM) '_t' num2str(tlo,3) '-' num2str(thi,3) ];
      export_fig([sFilePrefix '.png'],'-png');
      savefig([sFilePrefix '.fig']);
    end
    
    % Histogram of errors
    n1D = nL^3;
    dR = zeros(n1D,4);
    for isc = 1:4
      dR(:,isc) = sqrt( (L3D(:)- xv(i,1,isc)).^2 + (M3D(:)- xv(i,2,isc)).^2 + (N3D(:)- xv(i,3,isc)).^2 );
    end
    dR = min(dR,[],2);
    dRh = dRhJ;
    Rmax = 1.5*Lmax;
    nh = round(Rmax/dRh)+1;
    wh = zeros(nh,1); dBh = zeros(nh,1); Rh = (0:dRh:Rmax)';
    for j = 1:n1D
      rr = dR(j)/dRh + 1;
      jj = floor(rr);
      jp = jj + 1;
      fjp = rr - jj;
      fjj = 1 - fjp;
      if( jj>=1 && jj<=nh )
        wh(jj) = wh(jj) + fjj;
        dBh(jj) = dBh(jj) + fjj*dB3D(j);
      end
      if( jp>=1 && jp<=nh )
        wh(jp) = wh(jp) + fjp;
        dBh(jp) = dBh(jp) + fjp*dB3D(j);
      end
    end % j
    dBh = dBh ./ wh;
    % Get quartile values
    nhm = nh - 1;
    Rqh = (dRh:dRh:Rmax)' - dRh/2;
    qBh = zeros(nhm,3);
    for ih = 1:nhm
      jj = find(dR>=(ih-1)*dRh & dR<=ih*dRh );
      qBh(ih,:) = quantile(dB3D(jj),[.25,.5,.75]);
    end % ih  
    
    figure(684)
    fs0 = 12; fs = 14; lw1 = 1; lw2 = 2;
    set(gcf,'Color','w');
    plot(Rh,dBh,'b','Linewidth',lw2)
    hold on
    plot(Rqh,qBh,'k')
    hold off
    xlabel('R_{nearest} / L_{sc}','FontSize',fs);
    if( iJerrOp==1 )
      ylabel('({\bfJ}_{rcstr} - {\bfJ}_{sim})/J_{sim,max}','FontSize',fs);    
    else
      ylabel('\theta_{{\bfJ}rcstr,{\bfJ}sim} (\circ)','FontSize',fs);
    end
    if( i68NoJ0==1 )
      title(['t = ' num2str(t(i),4) ' s, Reconstruction Error in  dJ'],'FontSize',fs0)
    else
      title(['t = ' num2str(t(i),4) ' s, Reconstruction Error in J'],'FontSize',fs0)
    end
    hlg = legend('Mean','1st Quartile','Median','3rd Quartile');
    set(hlg,'Location','NorthWest','FontSize',fs)
    
    if( iPlot684==2 )
      sFilePrefix = [sDirPlots 'Poly_JhistErr_BscOut' num2str(iScOutIn) '_dJ' num2str(i68NoJ0) '_errOp' num2str(iJerrOp) '_iBrst' num2str(iBurst) '_Smo' num2str(nsmoothspan) '_Sub' num2str(iSubAvB) '_Rot' num2str(iRotate) '_noXRot' num2str(iNoXRotation) '_iSys' num2str(iSystem) '_iIncmprs' num2str(iIncmprs) '_iexctB' num2str(iExactB) '_iNF' num2str(iNormFlds) '_' num2str(wFlds(1)) '-' num2str(wFlds(2)) '-' num2str(wFlds(3)) '-' num2str(wFlds(4)) '-' num2str(wFlds(5)) '-' num2str(wFlds(6)) '_wB' num2str(wMag) '_iAltNe' num2str(iAltNe) '_iBMloc' num2str(iLocalBM) '_t' num2str(tlo,3) '-' num2str(thi,3) ];
      export_fig([sFilePrefix '.pdf'],'-pdf');
      savefig([sFilePrefix '.fig']);
    end
    
    Bmagg = sqrt( BL3Dg.^2 + BM3Dg.^2 + BN3Dg.^2 );
    Bmax = max(Bmagg(:));
    fscl = 1/Bmax;
    if( i68slran == 1 )
      Bmagc = Bmagg(2:end-1,2:end-1,2:end-1);
      Bmagc1D = Bmagc(:);
      wsl = Bmagc1D/sum(Bmagc1D);
      nwsl = numel(wsl);
      fsl = zeros(size(wsl));
      fsl(2) = wsl(1) + 0.5*wsl(2);
      for ii = 3:nwsl-1
        fsl(ii) = fsl(ii-1) + 0.5*( wsl(ii-1) + wsl(ii) );
      end
      fsl(end) = 1;
      fslreg = linspace(0,1,nwsl)';
      infslreg = interp1(fsl,(1:nwsl)',fslreg);
      nsl = 60;
      fsl = rand(nsl,1);
      insl = round( interp1(fslreg,infslreg,fsl) );
      nLm2 = nL - 2;
      [inM,inL,inN] = ind2sub([nLm2,nLm2,nLm2],insl);
      M3Dsl = La(inM+1);
      L3Dsl = La(inL+1);
      N3Dsl = La(inN+1);
    end  
    
    figure(683)
    clf;
    i = find( abs(t-t3D) == min(abs(t-t3D)) , 1 );
    set(gcf,'Color','w');
    set(gcf,'Position',[1200,50,600,600]);
    if( i68slran == 1 )
      if( iTubes==1 )
        hst1 = streamtube(L3D,M3D,N3D,BL3Dg,BM3Dg,BN3Dg,L3Dsl,M3Dsl,N3Dsl);
        set(hst1,'FaceColor',lncol,'EdgeColor',lncol,'LineWidth',lw1);
        view(3);
        hold on
        hst2 = streamtube(L3D,M3D,N3D,-BL3Dg,-BM3Dg,-BN3Dg,L3Dsl,M3Dsl,N3Dsl);
        set(hst2,'FaceColor',lncol,'EdgeColor',lncol,'LineWidth',lw1)
      else
        hst1 = streamline(L3D,M3D,N3D,BL3Dg,BM3Dg,BN3Dg,L3Dsl,M3Dsl,N3Dsl);
        set(hst1,'Color',lncol,'LineWidth',lw1);
        view(3);
        hold on
        hst2 = streamline(L3D,M3D,N3D,-BL3Dg,-BM3Dg,-BN3Dg,L3Dsl,M3Dsl,N3Dsl);
        set(hst2,'Color',lncol,'LineWidth',lw1)
      end
    else
      hst1 = streamline(L3D,M3D,N3D,BL3Dg,BM3Dg,BN3Dg,L2Dcut(:),M2Dcut(:),N2Dcut(:));
      set(hst1,'Color',lncol,'LineWidth',lw1);
      view(3);
      hold on
      hst2 = streamline(L3D,M3D,N3D,-BL3Dg,-BM3Dg,-BN3Dg,L2Dcut(:),M2Dcut(:),N2Dcut(:));
      set(hst2,'Color',lncol,'LineWidth',lw1)
    end
    hcn  = coneplot(L3D,M3D,N3D,fscl*BL3Dg,fscl*BM3Dg,fscl*BN3Dg,L2Dcut(:),M2Dcut(:),N2Dcut(:),0);
    set(hcn,'FaceColor',cncol,'EdgeColor','none');
    [xsph,ysph,zsph] = sphere(8); fsph = .125;
    for k = 1:4
      surf(fsph*xsph+xv(i,1,k),fsph*ysph+xv(i,2,k),fsph*zsph+xv(i,3,k),'FaceColor',casc(k,:));
      %       scatter3(xv(i,1,k),xv(i,2,k),xv(i,3,k),'o','filled','Color',casc(k,:));
      hst3 = streamline(L3D,M3D,N3D,BL3Dg,BM3Dg,BN3Dg,xv(i,1,k),xv(i,2,k),xv(i,3,k));
      set(hst3,'Color',casc(k,:),'LineWidth',lw2);
      hst4 = streamline(L3D,M3D,N3D,-BL3Dg,-BM3Dg,-BN3Dg,xv(i,1,k),xv(i,2,k),xv(i,3,k));
      set(hst4,'Color',casc(k,:),'LineWidth',lw2);
    end
    hold off
    axis square
    camlight; lighting gouraud;
    grid on; box on;
    xlim([-Lmax,Lmax]);
    ylim([-Lmax,Lmax]);
    zlim([-Lmax,Lmax]);
    xlabel('L / L_{sc}','FontSize',14);
    ylabel('M / L_{sc}','FontSize',14);
    zlabel('N / L_{sc}','FontSize',14);
    if( i68NoJ0==1 )
      title(['t = ' num2str(t(i),4) ' s, Simulation dJ'],'FontSize',fs0)
    else
      title(['t = ' num2str(t(i),4) ' s, Simulation J'],'FontSize',fs0)
    end
    
    if( iPlot683==2 ) 
      sFilePrefix = [sDirPlots 'Poly_J3Dsim_BscOut' num2str(iScOutIn) '_dJ' num2str(i68NoJ0) '_iBrst' num2str(iBurst) '_Smo' num2str(nsmoothspan) '_Sub' num2str(iSubAvB) '_Rot' num2str(iRotate) '_noXRot' num2str(iNoXRotation) '_iSys' num2str(iSystem) '_iIncmprs' num2str(iIncmprs) '_iexctB' num2str(iExactB) '_iNF' num2str(iNormFlds) '_' num2str(wFlds(1)) '-' num2str(wFlds(2)) '-' num2str(wFlds(3)) '-' num2str(wFlds(4)) '-' num2str(wFlds(5)) '-' num2str(wFlds(6)) '_wB' num2str(wMag) '_iAltNe' num2str(iAltNe) '_iBMloc' num2str(iLocalBM) '_t' num2str(tlo,3) '-' num2str(thi,3) ];
      export_fig([sFilePrefix '.pdf'],'-pdf');
      savefig([sFilePrefix '.fig']);
    end
    

  end % iPlot682
    
end % iPlot68

%% 3D Movie

if( iPlot581>0 )
  figure(581)
  clf;
  if( exist('vidfile','var')==1 ), close(vidfile); end
  if( iPlot581==2 ), vidfile = VideoWriter([sDirPlots 'Poly_3Dmovie_Brs' num2str(iBurst) '_Smo' num2str(nsmoothspan) '_Sub' num2str(iSubAvB) '_Rot' num2str(iRotate) '_noXRot' num2str(iNoXRotation) '_iSys' num2str(iSystem) '_iIncmprs' num2str(iIncmprs) '_iexctB' num2str(iExactB) '_iNF' num2str(iNormFlds) '_' num2str(wFlds(1)) '-' num2str(wFlds(2)) '-' num2str(wFlds(3)) '-' num2str(wFlds(4)) '-' num2str(wFlds(5)) '-' num2str(wFlds(6)) '_wB' num2str(wMag) '_iAltNe' num2str(iAltNe) '_iBMloc' num2str(iLocalBM) '_t' num2str(tlo,3) '-' num2str(thi,3) '.mp4'],'MPEG-4'); end
  if( iPlot581==2 ), open(vidfile); end
  i = find( abs(t-t3D) == min(abs(t-t3D)) , 1 );
  set(gcf,'Color','w');
  set(gcf,'Position',[500,50,600,600]);
  
  ticklen = [0.04 0.02];
  wid1 = 1.5; wid2 = 2; wid3 = 2; fs1 = 9; fs2 = 11;
  casc = [ gray ; 1 0 0 ; 0 .8 0 ; .3 .3 1 ];
  
  nL = 31; nLcut = 7;
  La = linspace(-Lmax,Lmax,nL); dL = La(2) - La(1);
  Lacut = linspace(-Lmax,Lmax,nLcut);
  [L3D,M3D,N3D] = meshgrid(La,La,La);
  if( i3DaltLN==1 )
    [M2Dcut,N2Dcut] = meshgrid(Lacut); L2Dcut = zeros(nLcut);
    %     M2Dcut = [ M2Dcut(:) ; M2Dcut(:) ];
    %     N2Dcut = [ N2Dcut(:) ; N2Dcut(:) ];
    %     L2Dcut = [ L2Dcut(:) ; -L2Dcut(:) ];
  elseif( i3DaltLN==2 )
    [L2Dcut,M2Dcut] = meshgrid(Lacut); N2Dcut = zeros(nLcut);
  else
    [L2Dcut,N2Dcut] = meshgrid(Lacut); M2Dcut = zeros(nLcut);
  end
  
  l3D = zeros(nL,nL,nL); m3D = zeros(nL,nL,nL); n3D = zeros(nL,nL,nL);
  BL3D = zeros(nL,nL,nL); BM3D = zeros(nL,nL,nL); BN3D = zeros(nL,nL,nL);
  
  if( iPlot581==6 )
    iend = 1;
  else
    iend = nt;
  end
  for i = 1:iMovieStep:iend  % 1 % ***nt
    
    if( i>1 ), clf; end
    
    mv1 = squeeze(mv(i,:,:));
    for k1 = 1:nL
      for i1 = 1:nL
        for j1 = 1:nL
          Pos1 = [ L3D(j1,i1,k1) M3D(j1,i1,k1) N3D(j1,i1,k1) ];
          pos1 = Pos1 * mv1;
          l3D(j1,i1,k1) = pos1(1);
          m3D(j1,i1,k1) = pos1(2);
          n3D(j1,i1,k1) = pos1(3);
        end
      end
    end
    
    X1 = X(i,:);
    
    if( iSystem==1 )
      % B_s,L
      j0 = 0;
      Bl3D = X1(j0+1) + X1(j0+2)*n3D + X1(j0+3)*l3D + X1(j0+4)*n3D.^2/2;
      % B_s,M
      j0 = 4;
      Bm3D = X1(j0+1) + X1(j0+2)*n3D + X1(j0+3)*l3D +  ...
        + X1(j0+4)*n3D.^2/2 + X1(j0+5)*l3D.^2/2 + X1(j0+6)*n3D.*l3D;
      % B_s,N
      j0 = 10;
      Bn3D = X1(j0+1) + X1(j0+2)*n3D + X1(j0+3)*l3D + X1(j0+4)*l3D.^2/2;
    elseif( iSystem==2 )
      if( i58NoB0>=1 )
        j0 = 0;
        Bl3D = X1(j0+2)*n3D + X1(j0+3)*l3D + X1(j0+4)*m3D ...
          + X1(j0+5)*n3D.^2/2;
        % B_s,M
        j0 = 5;
        Bm3D = X1(j0+2)*n3D + X1(j0+3)*l3D + X1(j0+4)*m3D ...
          + X1(j0+5)*n3D.^2/2 + X1(j0+6)*l3D.^2/2 ...
          + X1(j0+7)*n3D.*l3D;
        % B_s,N
        j0 = 12;
        Bn3D = X1(j0+2)*n3D + X1(j0+3)*l3D + X1(j0+4)*m3D ...
          + X1(j0+5)*l3D.^2/2;
      else
        % B_s,L
        j0 = 0;
        Bl3D = X1(j0+1) + X1(j0+2)*n3D + X1(j0+3)*l3D + X1(j0+4)*m3D ...
          + X1(j0+5)*n3D.^2/2;
        % B_s,M
        j0 = 5;
        Bm3D = X1(j0+1) + X1(j0+2)*n3D + X1(j0+3)*l3D + X1(j0+4)*m3D ...
          + X1(j0+5)*n3D.^2/2 + X1(j0+6)*l3D.^2/2 ...
          + X1(j0+7)*n3D.*l3D;
        % B_s,N
        j0 = 12;
        Bn3D = X1(j0+1) + X1(j0+2)*n3D + X1(j0+3)*l3D + X1(j0+4)*m3D ...
          + X1(j0+5)*l3D.^2/2;
      end
    elseif( iSystem==8 )
      % B_s,L
      j0 = 0;
      Bl3D = X1(j0+1) + X1(j0+2)*n3D + X1(j0+3)*m3D + X1(j0+4)*l3D ...
        + X1(j0+5)*n3D.^2/2 + X1(j0+6)*m3D.^2/2 + X1(j0+7)*n3D.*m3D;
      % B_s,M
      j0 = 7;
      Bm3D = X1(j0+1) + X1(j0+2)*n3D + X1(j0+3)*m3D + X1(j0+4)*l3D ...
        + X1(j0+5)*n3D.^2/2;
      % B_s,N
      j0 = 12;
      Bn3D = X1(j0+1) + X1(j0+2)*n3D + X1(j0+3)*m3D + X1(j0+4)*l3D ...
        + X1(j0+5)*m3D.^2/2;
      % B_s,L
      j0 = 0;
      BL3D = X1(j0+1) + X1(j0+2)*n3D + X1(j0+3)*l3D + X1(j0+4)*m3D ...
        + X1(j0+5)*n3D.^2/2 + X1(j0+6)*l3D.^2/2 ...
        + X1(j0+7)*n3D.*l3D + X1(j0+8)*n3D.*m3D + X1(j0+9)*l3D.*m3D;
      if( i28term==1 )
        Bl3D = Bl3D + X1(  28)*n3D.^3/6;
      elseif( i28term==4 || i28term==5 )
        Bl3D = Bl3D + X1(  28)*n3D.^2/2 .*m3D;
      end
      % B_s,M
      j0 = 9;
      Bm3D = X1(j0+1) + X1(j0+2)*n3D + X1(j0+3)*l3D + X1(j0+4)*m3D ...
        + X1(j0+5)*n3D.^2/2 + X1(j0+6)*l3D.^2/2 ...
        + X1(j0+7)*n3D.*l3D + X1(j0+8)*n3D.*m3D + X1(j0+9)*l3D.*m3D;
      if( i28term==2 || i28term==5 )
        Bm3D = Bm3D + X1(  28)*n3D.^2/2 .*l3D;
      end
      % B_s,N
      j0 = 18;
      Bn3D = X1(j0+1) + X1(j0+2)*n3D + X1(j0+3)*l3D + X1(j0+4)*m3D ...
        + X1(j0+5)*n3D.^2/2 + X1(j0+6)*l3D.^2/2 ...
        + X1(j0+7)*n3D.*l3D + X1(j0+8)*n3D.*m3D + X1(j0+9)*l3D.*m3D;
      if( i28term==3 || i28term==5 )
        Bn3D = Bn3D + X1(  28)*l3D.^2/2 .*m3D;
      end
    elseif( iSystem==28 )
      nnn3D = n3D.^3/6;
      lll3D = l3D.^3/6;
      nnl3D = n3D.^2.*l3D/2;
      nnm3D = n3D.^2.*m3D/2;
      lln3D = l3D.^2.*n3D/2;
      llm3D = l3D.^2.*m3D/2;
      nlm3D = n3D.*l3D.*m3D;
      if( i58NoB0>=1 )
        % B_s,L
        j0 = 0;
        Bl3D = X1(j0+2)*n3D + X1(j0+3)*l3D + X1(j0+4)*m3D ...
          + X1(j0+5)*n3D.^2/2 + X1(j0+6)*l3D.^2/2 ...
          + X1(j0+7)*n3D.*l3D + X1(j0+8)*n3D.*m3D + X1(j0+9)*l3D.*m3D ...
          + X1(28)*nnm3D + X1(32)*nnn3D + X1(36)*nnl3D + X1(37)*lln3D + X1(38)*lll3D + X1(39)*nlm3D + X1(40)*llm3D;
        % B_s,M
        j0 = 9;
        Bm3D = X1(j0+2)*n3D + X1(j0+3)*l3D + X1(j0+4)*m3D ...
          + X1(j0+5)*n3D.^2/2 + X1(j0+6)*l3D.^2/2 ...
          + X1(j0+7)*n3D.*l3D + X1(j0+8)*n3D.*m3D + X1(j0+9)*l3D.*m3D ...
          + X1(29)*nnl3D + X1(30)*lln3D + X1(33)*nnn3D + X1(34)*lll3D;
        % B_s,N
        j0 = 18;
        Bn3D = X1(j0+2)*n3D + X1(j0+3)*l3D + X1(j0+4)*m3D ...
          + X1(j0+5)*n3D.^2/2 + X1(j0+6)*l3D.^2/2 ...
          + X1(j0+7)*n3D.*l3D + X1(j0+8)*n3D.*m3D + X1(j0+9)*l3D.*m3D ...
          + X1(31)*llm3D + X1(35)*lll3D - X1(36)*nnn3D - X1(37)*nnl3D - X1(38)*lln3D - X1(39)*nnm3D - X1(40)*nlm3D;
      else
        % B_s,L
        j0 = 0;
        Bl3D = X1(j0+1) + X1(j0+2)*n3D + X1(j0+3)*l3D + X1(j0+4)*m3D ...
          + X1(j0+5)*n3D.^2/2 + X1(j0+6)*l3D.^2/2 ...
          + X1(j0+7)*n3D.*l3D + X1(j0+8)*n3D.*m3D + X1(j0+9)*l3D.*m3D ...
          + X1(28)*nnm3D + X1(32)*nnn3D + X1(36)*nnl3D + X1(37)*lln3D + X1(38)*lll3D + X1(39)*nlm3D + X1(40)*llm3D;
        % B_s,M
        j0 = 9;
        Bm3D = X1(j0+1) + X1(j0+2)*n3D + X1(j0+3)*l3D + X1(j0+4)*m3D ...
          + X1(j0+5)*n3D.^2/2 + X1(j0+6)*l3D.^2/2 ...
          + X1(j0+7)*n3D.*l3D + X1(j0+8)*n3D.*m3D + X1(j0+9)*l3D.*m3D ...
          + X1(29)*nnl3D + X1(30)*lln3D + X1(33)*nnn3D + X1(34)*lll3D;
        % B_s,N
        j0 = 18;
        Bn3D = X1(j0+1) + X1(j0+2)*n3D + X1(j0+3)*l3D + X1(j0+4)*m3D ...
          + X1(j0+5)*n3D.^2/2 + X1(j0+6)*l3D.^2/2 ...
          + X1(j0+7)*n3D.*l3D + X1(j0+8)*n3D.*m3D + X1(j0+9)*l3D.*m3D ...
          + X1(31)*llm3D + X1(35)*lll3D - X1(36)*nnn3D - X1(37)*nnl3D - X1(38)*lln3D - X1(39)*nnm3D - X1(40)*nlm3D;
      end
    else
      % B_s,L
      j0 = 0;
      Bl3D = X1(iv(j0+1)) + X1(iv(j0+2))*n3D + X1(iv(j0+3))*l3D  ...
        + X1(iv(j0+4))*n3D.^2/2 + X1(iv(j0+5))*n3D.*l3D + X1(iv(j0+6))*l3D.^2/2;
      if( iQuadSys==-1 )
        Bl3D = Bl3D + X1(iv(j0+7))*m3D + X1(iv(j0+8))*n3D.*m3D + X1(iv(j0+9))*l3D.*m3D + X1(28)*n3D.^3/6;
      elseif( iQuadSys==0 )
        Bl3D = Bl3D + X1(iv(j0+7))*m3D + X1(iv(j0+8))*n3D.*m3D + X1(iv(j0+9))*l3D.*m3D;
      elseif( iQuadSys==1 )
        Bl3D = Bl3D + X1(iv(j0+7))*m3D + X1(iv(j0+8))*n3D.*m3D;
      elseif( iQuadSys==2 )
        Bl3D = Bl3D + X1(iv(j0+7))*m3D;
      end
      % B_s,M
      j0 = 9;
      Bm3D = X1(iv(j0+1)) + X1(iv(j0+2))*n3D + X1(iv(j0+3))*l3D  ...
        + X1(iv(j0+4))*n3D.^2/2 + X1(iv(j0+5))*n3D.*l3D + X1(iv(j0+6))*l3D.^2/2;
      if( iQuadSys<1 )
        Bm3D = Bm3D + X1(iv(j0+7))*m3D + X1(iv(j0+8))*n3D.*m3D + X1(iv(j0+9))*l3D.*m3D;
      elseif( iQuadSys==1 )
        Bm3D = Bm3D + X1(iv(j0+7))*m3D + X1(iv(j0+8))*n3D.*m3D;
      elseif( iQuadSys==2 )
        Bm3D = Bm3D + X1(iv(j0+7))*m3D;
      end
      % B_s,N
      j0 = 18;
      Bn3D = X1(iv(j0+1)) + X1(iv(j0+2))*n3D + X1(iv(j0+3))*l3D  ...
        + X1(iv(j0+4))*n3D.^2/2 + X1(iv(j0+5))*n3D.*l3D + X1(iv(j0+6))*l3D.^2/2;
      if( iQuadSys<1 )
        Bn3D = Bn3D + X1(iv(j0+7))*m3D + X1(iv(j0+8))*n3D.*m3D + X1(iv(j0+9))*l3D.*m3D;
      elseif( iQuadSys<3 )
        Bn3D = Bn3D + X1(iv(j0+7))*m3D;
      end
    end % iSystem
    
    mv1p = mv1';
    for k1 = 1:nL
      for i1 = 1:nL
        for j1 = 1:nL
          mag1 = [ Bl3D(j1,i1,k1) Bm3D(j1,i1,k1) Bn3D(j1,i1,k1) ];
          Mag1 = mag1 * mv1p;
          BL3D(j1,i1,k1) = Mag1(1);
          BM3D(j1,i1,k1) = Mag1(2);
          BN3D(j1,i1,k1) = Mag1(3);
        end
      end
    end
    
    %     BL2Dcut = interp3(L3D,M3D,N3D,BL3D,L2Dcut(:),M2Dcut(:),N2Dcut(:));
    %     BM2Dcut = interp3(L3D,M3D,N3D,BM3D,L2Dcut(:),M2Dcut(:),N2Dcut(:));
    %     BN2Dcut = interp3(L3D,M3D,N3D,BN3D,L2Dcut(:),M2Dcut(:),N2Dcut(:));
    
    Bmag = sqrt( BL3D.^2 + BM3D.^2 + BN3D.^2 );
    Bmax = max(Bmag(:));
    fscl = 1/Bmax;
    if( i58slran == 1 )
      Bmagc = Bmag(2:end-1,2:end-1,2:end-1);
      Bmagc1D = Bmagc(:);
      wsl = Bmagc1D/sum(Bmagc1D);
      nwsl = numel(wsl);
      fsl = zeros(size(wsl));
      fsl(2) = wsl(1) + 0.5*wsl(2);
      for ii = 3:nwsl-1
        fsl(ii) = fsl(ii-1) + 0.5*( wsl(ii-1) + wsl(ii) );
      end
      fsl(end) = 1;
      fslreg = linspace(0,1,nwsl)';
      infslreg = interp1(fsl,(1:nwsl)',fslreg);
      nsl = 60;
      fsl = rand(nsl,1);
      insl = round( interp1(fslreg,infslreg,fsl) );
      nLm2 = nL - 2;
      [inM,inL,inN] = ind2sub([nLm2,nLm2,nLm2],insl);
      M3Dsl = La(inM+1);
      L3Dsl = La(inL+1);
      N3Dsl = La(inN+1);
    end
    
    lw1 = 1;
    lw2 = 2;
    cncol = [.99,.71,.08];
    lncol = [.72,.53,.04];
    iTubes = 0;
    if( i58slran >= 1 )
      if( iTubes==1 )
        hst1 = streamtube(L3D,M3D,N3D,BL3D,BM3D,BN3D,L3Dsl,M3Dsl,N3Dsl);
        set(hst1,'FaceColor',lncol,'EdgeColor',lncol,'LineWidth',lw1);
        view(3);
        hold on
        hst2 = streamtube(L3D,M3D,N3D,-BL3D,-BM3D,-BN3D,L3Dsl,M3Dsl,N3Dsl);
        set(hst2,'FaceColor',lncol,'EdgeColor',lncol,'LineWidth',lw1)
      else
        hst1 = streamline(L3D,M3D,N3D,BL3D,BM3D,BN3D,L3Dsl,M3Dsl,N3Dsl);
        set(hst1,'Color',lncol,'LineWidth',lw1);
        view(3);
        hold on
        hst2 = streamline(L3D,M3D,N3D,-BL3D,-BM3D,-BN3D,L3Dsl,M3Dsl,N3Dsl);
        set(hst2,'Color',lncol,'LineWidth',lw1)
      end
    else
      hst1 = streamline(L3D,M3D,N3D,BL3D,BM3D,BN3D,L2Dcut(:),M2Dcut(:),N2Dcut(:));
      set(hst1,'Color',lncol,'LineWidth',lw1);
      view(3);
      hold on
      hst2 = streamline(L3D,M3D,N3D,-BL3D,-BM3D,-BN3D,L2Dcut(:),M2Dcut(:),N2Dcut(:));
      set(hst2,'Color',lncol,'LineWidth',lw1)
    end
    hcn  = coneplot(L3D,M3D,N3D,fscl*BL3D,fscl*BM3D,fscl*BN3D,L2Dcut(:),M2Dcut(:),N2Dcut(:),0);
    set(hcn,'FaceColor',cncol,'EdgeColor','none');
    [xsph,ysph,zsph] = sphere(8); fsph = .125;
    for k = 1:4
      surf(fsph*xsph+xv(i,1,k),fsph*ysph+xv(i,2,k),fsph*zsph+xv(i,3,k),'FaceColor',casc(k,:));
      %       scatter3(xv(i,1,k),xv(i,2,k),xv(i,3,k),'o','filled','Color',casc(k,:));
      hst3 = streamline(L3D,M3D,N3D,BL3D,BM3D,BN3D,xv(i,1,k),xv(i,2,k),xv(i,3,k));
      set(hst3,'Color',casc(k,:),'LineWidth',lw2);
      hst4 = streamline(L3D,M3D,N3D,-BL3D,-BM3D,-BN3D,xv(i,1,k),xv(i,2,k),xv(i,3,k));
      set(hst4,'Color',casc(k,:),'LineWidth',lw2);
    end
    hold off
    axis square
    camlight; lighting gouraud;
    grid on; box on;
    xlabel('L / L_{sc}','FontSize',14);
    ylabel('M / L_{sc}','FontSize',14);
    zlabel('N / L_{sc}','FontSize',14);
    title(['t = ' num2str(t(i),4) ' s'],'FontSize',12);
    
    %     set(hst,'Color','k')
    %     axis xy;
    %     axis square;
    %     set(gca,'TickLength',ticklen);
    %     set(gca,'TickDir','out');
    %     set(gca,'XMinorTick','on')
    %     set(gca,'YMinorTick','on')
    %     set(gca,'FontSize',10);
    %     if( irow==nrow ), xlabel(sXLab,'FontSize',12); else, set(gca,'XTickLabel',''); end
    %     if( icol==1    ), ylabel(sYLab,'FontSize',12); else, set(gca,'YTickLabel',''); end
    %     title(['(' char('c'+ipl-1) ') t = ' num2str(t(i),4)],'FontSize',10);
    %     drawnow;
    
    pause(.1)
    drawnow;
    if( iPlot581==2 ), Frame(i) = getframe(gcf); end
    if( iPlot581==2 ), writeVideo(vidfile,Frame(i)); end
  end % i
  if( iPlot581==2 ), close(vidfile); end
end % iPlot581


%%

if( iPlot38>0 )
  figure(38)
  clf;
  set(gcf,'Color','w');
  set(gcf,'Position',[1200,300,300,400]);
  xsc1 = 0.185; xsc2 = 0.99; ysc1 = 0.12; ysc2 = .95; blue = [0.4,.4,1];
  wid1 = 1; wid2 = 1.5; wid3 = 3; ticklen = [0.04 0.02];
  ms = 10;
  vgap = 0.05;
  fxlab = .2; fylab = .25;
  sXLab = 'L_{loc}/L_{sc}';
  sYLab = 'N_{loc}/L_{sc}';
  nrow = 2;
  casc = [ gray ; 1 0 0 ; 0 .8 0 ; .3 .3 1 ];
  cprob = [ 0 .8 0 ; 0 0 0 ; 1 0 1 ];
  
  ilt2 = [];
  for it1 = 1:nt
    if( isfinite(LNBmina(it1,1)) && LNBmina(it1,1)<=1.75 )
      ilt2 = [ ilt2 ; it1 ];
    end
  end
  pL = polyfit(t(ilt2),LNBmina(ilt2,1),1);
  tYL = t(ilt2);
  yL = polyval(pL,tYL);
  
  hax = my_subplotrc3(nrow,1, 1, 1, xsc1,xsc2,ysc1,ysc2);
  h1 = plot(t,LNBmina(:,1),'*','Color',blue,'Linewidth',1.5)
  hold on
  h2 = plot(tYL,yL,'Color','g','Linewidth',1.5)
  hold off
  xlim([t(1) t(end)])
  set(gca,'Fontsize',11);
  set(gca,'TickLength',ticklen);
  set(gca,'XMinorTick','on')
  set(gca,'YMinorTick','on')
  set(gca,'XTickLabel','')
  ylabel('L_{str} (km)','FontSize',12);
  
  textNormFig( gca, fxlab, fylab, {['(b) V_{str,L} = '] [num2str(pL(1)*dsc,3) 'km/s']}, 11 )
  
  ilt2 = [];
  for it1 = 1:nt
    if( isfinite(LNBmina(it1,1)) ); %  && abs(LNBmina(it1,2))<=1.5 )
      ilt2 = [ ilt2 ; it1 ];
    end
  end
  pN = polyfit(t(ilt2),LNBmina(ilt2,2),1);
  tYN = t(ilt2);
  yN = polyval(pN,tYN);
  
  hax = my_subplotrc3(nrow,1, 2, 1, xsc1,xsc2,ysc1,ysc2);
  h1 = plot(t,LNBmina(:,2),'*','Color',blue,'Linewidth',1.5)
  hold on
  h2 = plot(tYN,yN,'Color','g','Linewidth',1.5)
  hold off
  xlim([t(1) t(end)])
  set(gca,'Fontsize',11);
  set(gca,'TickLength',ticklen);
  set(gca,'XMinorTick','on')
  set(gca,'YMinorTick','on')
  ylabel('N_{str} (km)','FontSize',12);
  hxl = xlabel(['t(s) after ' sTime ' UT']);
  
  textNormFig( gca, fxlab, fylab, {['(b) V_{str,N} = '] [num2str(pN(1)*dsc,3) 'km/s']}, 11 )
  
  if( iPlot38==2 ), export_fig([sDirPlots 'Poly_LN_BscOut' num2str(iScOutIn) '_Brs' num2str(iBurst) '_Smo' num2str(nsmoothspan) '_Sub' num2str(iSubAvB) '_Rot' num2str(iRotate) '_noXRot' num2str(iNoXRotation) '_iSys' num2str(iSystem) '_iIncmprs' num2str(iIncmprs) '_iexctB' num2str(iExactB) '_iNF' num2str(iNormFlds) '_' num2str(wFlds(1)) '-' num2str(wFlds(2)) '-' num2str(wFlds(3)) '-' num2str(wFlds(4)) '-' num2str(wFlds(5)) '-' num2str(wFlds(6)) '_wB' num2str(wMag) '_iAltNe' num2str(iAltNe) '_t' num2str(tlo,3) '-' num2str(thi,3)  '.pdf '],'-pdf'); end
  
end % iPlot38

%%

if( iPlot381>0 )
  figure(381)
  clf;
  set(gcf,'Color','w');
  set(gcf,'Position',[1200,300,600,325]);
  xsc1 = 0.185; xsc2 = 0.99; ysc1 = 0.12; ysc2 = .95; blue = [0.4,.4,1];
  wid1 = 1; wid2 = 1.5; wid3 = 3; ticklen = [0.04 0.02];
  ms = 10;
  vgap = 0.05;
  fxlab = .75; fylab = .625;
  sXLab = 'L_{loc}/L_{sc}';
  sYLab = 'N_{loc}/L_{sc}';
  nrow = 2;
  casc = [ gray ; 1 0 0 ; 0 .8 0 ; .3 .3 1 ];
  cprob = [ 0 .8 0 ; 0 0 0 ; 1 0 1 ];
  
  ilt2 = [];
  for it1 = 1:nt
    if( isfinite(LNBmina(it1,1)) && LNBmina(it1,1)<=1.75 )
      ilt2 = [ ilt2 ; it1 ];
    end
  end
  pL = polyfit(t(ilt2),LNBmina(ilt2,1),1);
  tYL = t(ilt2);
  yL = polyval(pL,tYL);
  
  subplotrc(1,2,1,1)
  h1 = plot(t,LNBmina(:,1),'*','Color',blue,'Linewidth',1.5)
  hold on
  h2 = plot(tYL,yL,'Color','g','Linewidth',1.5)
  hold off
  xlim([t(1) t(end)])
  set(gca,'Fontsize',11);
  set(gca,'TickLength',ticklen);
  set(gca,'XMinorTick','on')
  set(gca,'YMinorTick','on')
  ylabel('L_{str} (km)','FontSize',12);
  hxl = xlabel(['t(s) after ' sTime ' UT']);
  
  textNormFig( gca, fxlab, fylab, {['(a) V_{str,L} = '] [num2str(pL(1)*dsc,3) 'km/s']}, 11 )
  
  ilt2 = [];
  for it1 = 1:nt
    if( isfinite(LNBmina(it1,1)) ); %  && abs(LNBmina(it1,2))<=1.5 )
      ilt2 = [ ilt2 ; it1 ];
    end
  end
  pN = polyfit(t(ilt2),LNBmina(ilt2,2),1);
  tYN = t(ilt2);
  yN = polyval(pN,tYN);
  
  subplotrc(1,2,1,2)
  h1 = plot(t,LNBmina(:,2),'*','Color',blue,'Linewidth',1.5)
  hold on
  h2 = plot(tYN,yN,'Color','g','Linewidth',1.5)
  hold off
  xlim([t(1) t(end)])
  set(gca,'Fontsize',11);
  set(gca,'TickLength',ticklen);
  set(gca,'XMinorTick','on')
  set(gca,'YMinorTick','on')
  ylabel('N_{str} (km)','FontSize',12);
  hxl = xlabel(['t(s) after ' sTime ' UT']);
  
  textNormFig( gca, fxlab, fylab, {['(b) V_{str,N} = '] [num2str(pN(1)*dsc,3) 'km/s']}, 11 )
  
  if( iPlot381==2 ), export_fig([sDirPlots 'Poly_LN381_BscOut' num2str(iScOutIn) '_Brs' num2str(iBurst) '_Smo' num2str(nsmoothspan) '_Sub' num2str(iSubAvB) '_Rot' num2str(iRotate) '_noXRot' num2str(iNoXRotation) '_iSys' num2str(iSystem) '_iIncmprs' num2str(iIncmprs) '_iexctB' num2str(iExactB) '_iNF' num2str(iNormFlds) '_' num2str(wFlds(1)) '-' num2str(wFlds(2)) '-' num2str(wFlds(3)) '-' num2str(wFlds(4)) '-' num2str(wFlds(5)) '-' num2str(wFlds(6)) '_wB' num2str(wMag) '_iAltNe' num2str(iAltNe) '_t' num2str(tlo,3) '-' num2str(thi,3)  '.pdf '],'-pdf'); end
  
end % iPlot381

%%
if( iPlot71>0 )
  if( iScOut<1 || iScOut>4 )
    error('Need iScOut between 1 and 4 for iPlot71>0')
  end
  figure(71)
  clf;
  set(gcf,'Color','w');
  set(gcf,'Position',[200,500,500,400]);
  xsc1 = 0.12; xsc2 = 0.985; ysc1 = 0.12; ysc2 = .97; blue = [0.4,.4,1]; wid1 = 1; wid2 = 1.5; wid3 = 3; ticklen = [0.02 0.01];
  ms = 10;
  vgap = 0.02;
  nrow = 2;
  fxlab = .07; fylab = .5;
  sLab = { '(a)' '(b)'  };
  sXLab = ['t(s) after ' sTime ' UT'];
  sYLab = { '{\itB}_{obs},{\itB}_{mod} (nT)' '{\itdB}_{obs},{\itdB}_{mod} (nT)' };
  ca = [ .4 .4 1 ;  0 .75 0 ; .8 0 0  ];
  wida = [ wid1 wid1 wid1 ];
  widb = [ wid2 wid2 wid2 ];
  
  for iFullPerturbed= 1:2
    
    Bobs = squeeze(  bv(:,:,iScOut));
    Bfit2 = squeeze(Bfit(:,:,iScOut));
    if( iFullPerturbed==2 )
      Bobs0 = Bobs; Bfit20 = Bfit2;
      Bobs = Bobs - bavv;
      Bfit2 = Bfit2 - bavv;
    end
    
%     save([sFile '.mat'],'t','lambda','mvcalc','Bfit','bavv','B0fit','bv','Jpfit','Jpvav3','Jp0fit','Jpv3','iselne');
    
    Jpobs = squeeze(  Jpv3(:,:,iScOut));
    Jpfit2 = squeeze(Jpfit(:,:,iScOut));
    if( iFullPerturbed==2 )
      Jpobs0 = Jpobs; Jpfit20 = Jpfit2;
      Jpobs = Jpobs - Jpvav3;
      Jpfit2 = Jpfit2 - Jpvav3;
    end
    
    hax = my_subplotrc4(2,1, iFullPerturbed, 1, xsc1,xsc2,ysc1,ysc2,0,vgap );
    for ic = 1:3
      plot(t,Bobs(:,ic),'Color',ca(ic,:),'LineWidth',wida(ic));
      if( ic==1 ), hold on; end
      plot(t,Bfit2(:,ic),':','Color',ca(ic,:),'LineWidth',widb(ic));
    end
    ylim1 = get(gca,'YLim');
    if( ylim1(1)<0 && ylim1(2)>0 )
      plot([t(iselne(1)) t(iselne(end))],[0 0],'--','Color',gray);
    end
    hold off
    set(gca,'TickLength',ticklen);
    set(gca,'XMinorTick','on');
    set(gca,'YMinorTick','on');
    ylabel(sYLab{iFullPerturbed},'FontSize',12);
    if( iFullPerturbed==nrow )
      xlabel(sXLab,'FontSize',12);
    else
      set(gca,'XTickLabel','');
    end
    if( itscreen==1 ); xlim([tlo thi]); end
    textNormFig( gca, fxlab, fylab, sLab{iFullPerturbed}, 12 );
  end % iFullPerturbed
  if( iPlot71>=2 )
    sfile = [sDirPlots 'Poly_Berr_BscOut' num2str(iScOutIn) '_Brs' num2str(iBurst) '_Smo' num2str(nsmoothspan) '_Sub' num2str(iSubAvB) '_Rot' num2str(iRotate) '_noXRot' num2str(iNoXRotation) '_iSys' num2str(iSystem) '_iIncmprs' num2str(iIncmprs) '_iexctB' num2str(iExactB) '_iNF' num2str(iNormFlds) '_' num2str(wFlds(1)) '-' num2str(wFlds(2)) '-' num2str(wFlds(3)) '-' num2str(wFlds(4)) '-' num2str(wFlds(5)) '-' num2str(wFlds(6)) '_wB' num2str(wMag) '_iAltNe' num2str(iAltNe) '_t' num2str(tlo,3) '-' num2str(thi,3)];
    dlmwrite([sfile '.txt'],[t Bobs0 Bfit20 Bobs Bfit2 Jpobs0 Jpfit20 Jpobs Jpfit2]);
    if( iPlot71==2 ), export_fig([sfile '.pdf'],'-pdf'); end
  end
end % iPlot71

%%
if( iPlot72>0 )
  figure(72)
  clf;
  set(gcf,'Color','w');
  set(gcf,'Position',[900,300,630,800]);
     vgap = 0.01;
  xsc1 = 0.143; xsc2 = 0.977; ysc1 = 0.07; ysc2 = .7; ysc3 = ysc2+vgap; ysc4 = .99;
  sLab = { '(a)' '(b)' '(c)' '(d)' '(e)' '(f)' '(g)' '(h)' '(i)' '(j)' '(k)' };
  
  ticklen = [0.02 0.01];
  fxlab = .15; fylab = .8;
  casc = [ 0 0 0 ; .9 0 0 ; 0 .8 0 ; .3 .3 1 ]; sVertLine = ':'; widVert = 1.5;
  
 wid0 = 0.75; wid1 = 1; wid2 = 1.5; wid3 = 3;
  fsxy = 12; fsa = 10; fsl = 11; fsxy1 = 14;
    fxlab = .04; fylab = .8; gray1 = 0.4; gray = [gray1 gray1 gray1];
  
  if( iNormD == 1 )
    mingrads = (.1)^2;
  else
    mingrads = (.1/dsc)^2;
  end
    
    my_subplotrc4(4,1,1,1,xsc1,xsc2,ysc3,ysc4,0,vgap);
    semilogy(t,lambda(:,1)/mingrads,'Color',casc(4,:),'Linewidth',wid2);
    hold on
    semilogy(t,lambda(:,2)/mingrads,'Color',casc(3,:),'Linewidth',wid2);
    semilogy(t,lambda(:,3)/mingrads,'Color',casc(2,:),'Linewidth',wid2);
    semilogy([t(1),t(end)],[1 1],'k--','Linewidth',wid1);
    ylim([1.e-3 3.e3]);
%     if( iNormD==1 ), ylim([1.e-4 20.]); else, ylim([1.e-3 100.]); end 
    if(i72lines==1 )
      for iline = 1:numel(t72lo)
        plot([t72lo(iline) t72lo(iline)],get(gca,'YLim'),sVertLine,'Color',gray,'LineWidth',widVert);
        plot([t72hi(iline) t72hi(iline)],get(gca,'YLim'),sVertLine,'Color',gray,'LineWidth',widVert);
      end
    end
    hold off
    xlim([t(1) t(end)]);
    set(gca,'Fontsize',fsa);
    set(gca,'TickLength',ticklen);
    set(gca,'XMinorTick','on');
    set(gca,'YMinorTick','on');
        set(gca,'XTickLabel','');
    set(gca,'YTick',[1.e-8 1.e-7 1.e-6 1.e-5 1.e-4 1.e-3 .01 .1 1 10 100 1000 10000]);
%     if( iNormD==1 )
      ylabel({'$\lambda_{\rm MDD}$' '($\frac{\rm 0.1 nT}{L{\rm sc}}$)$^2$'},'Fontsize',fsxy1,'Interpreter','latex');
%      ylabel({'$\lambda_{\rm MDDB}$' '(\frac{0.1 nT}{$L_{\rm sc}$})$^2$'},'Fontsize',fsxy,'Interpreter','latex');
%     else
%       ylabel({'\lambda_{MDDB}' '(nT/km)^2'},'Fontsize',fsxy);
%     end
    textNormFig( gca, fxlab, fylab, sLab{1}, fsl );
      
    
    sYLaba = { '{\bfe}_{\itl}' '{\bfe}_{\itm}' '{\bfe}_{\itn}' };
    for ic = 1:3
      my_subplotrc4(4,1,ic+1,1,xsc1,xsc2,ysc3,ysc4,0,vgap);
      plot(t,mvcalc(:,1,ic,1),'Color',casc(4,:),'Linewidth',wid2);
      hold on
      plot(t,mvcalc(:,2,ic,1),'Color',casc(3,:),'Linewidth',wid2);
      plot(t,mvcalc(:,3,ic,1),'Color',casc(2,:),'Linewidth',wid2);
      plot([t(1),t(end)],[0 0],'k--','Linewidth',wid1);
      ylim([-1 1]);
      if(i72lines==1 )
        for iline = 1:numel(t72lo)
          plot([t72lo(iline) t72lo(iline)],get(gca,'YLim'),sVertLine,'Color',gray,'LineWidth',widVert);
          plot([t72hi(iline) t72hi(iline)],get(gca,'YLim'),sVertLine,'Color',gray,'LineWidth',widVert);
        end
      end
      hold off
      xlim([t(1) t(end)]);
      set(gca,'Fontsize',fsa);
      set(gca,'TickLength',ticklen);
      set(gca,'XMinorTick','on');
      set(gca,'YMinorTick','on');
      if( iRotate>0 )
        ylabel({sYLaba{ic} '{\color[rgb]{.3,.3,1}L}{\color[rgb]{0,.8,0}M}{\color[rgb]{.9,0,0}N}'},'Fontsize',fsxy);
      else
        ylabel({sYLaba{ic} 'GSE'},'Fontsize',fsxy);
      end
      set(gca,'XTickLabel','')
      textNormFig( gca, fxlab, fylab, sLab{ic+1}, fsl );
    end
   
  blue = [0.4,.4,1]; 
  ms = 10;
  nrow = 6;
  if( iNormD==1 )
    if( iRotate>0 )
      sYLab = { {'B_L' '(nT)'} {'B_M' '(nT)'} {'B_N' '(nT)'} {'\mu_0 J_L' '(nT/L_{sc})'} {'\mu_0 J_M' '(nT/L_{sc})'} {'\mu_0 J_N' '(nT/L_{sc})'} };
    else
      sYLab = { 'B_X GSE (nT)' 'B_Y GSE (nT)' 'B_Z GSE (nT)' '\mu_0 J_X GSE (nT/L_{sc})' '\mu_0 J_Y GSE (nT/L_{sc})' '\mu_0 J_Z GSE (nT/L_{sc})' };
    end
  else
    if( iRotate>0 )
      sYLab = { 'B_L GSE (nT)' 'B_M GSE (nT)' 'B_N GSE (nT)' 'J_L GSE (mA/m^2)' 'J_M GSE (mA/m^2)' 'J_N GSE (mA/m^2)' };
    else
      sYLab = { 'B_X GSE (nT)' 'B_Y GSE (nT)' 'B_Z GSE (nT)' 'J_X GSE (mA/m^2)' 'J_Y GSE (mA/m^2)' 'J_Z GSE (mA/m^2)' };
    end
  end
  sXLab = ['t(s) after ' sTime ' UT'];
  ca = [ 0 0 0 ; .9 0 0 ; 0 .8 0 ; .3 .3 1 ; .85 .65 .125 ; .85 .65 .125 ; 0 0 0 ; .8 0 0 ; 0 .75 0 ; .4 .4 1 ];
  wida = [ wid1 wid1 wid1 wid1 wid3 wid3 wid2 wid2 wid2 wid2 ];
  slnsty = { '-' '-' '-' '-' ':' '-' ':' ':' ':' ':' };
  
  for ifld = 1:2
    for ic = 1:3
      if( ifld==1 )
        a = [ squeeze(Bfit(:,ic,:)) bavv(:,ic) B0fit(:,ic) squeeze(bv(:,ic,:)) ];
        nl = 10;
        amin1 = minAll(bv(:,ic,:)); amax1 = maxAll(bv(:,ic,:));  
      else
        a = [ squeeze(Jpfit(:,ic,:)) Jpvav3(:,ic) Jp0fit(:,ic) squeeze(Jpv3(:,ic,:)) ];
        nl = 10;
        amin1 = minAll(Jpv3(:,ic,:)); amax1 = maxAll(Jpv3(:,ic,:)); 
      end
      amin2 = minAll(a); amax2 = maxAll(a); arange1 = amax1 - amin1; amin3 = amin1-arange1/2; amax3 = amax1+arange1/2;
      amin = max( amin2 , amin3 ); amax = min( amax2 , amax3 );
      irow = (ifld-1)*3 + ic;
      hax = my_subplotrc4(nrow,1, irow, 1, xsc1,xsc2,ysc1,ysc2,0,vgap );
      for il = 1:nl
        plot(t(iselne),a(iselne,il),slnsty{il},'Color',ca(il,:),'LineWidth',wida(il));
        if( il==1 ), hold on; end
      end
      ylim([amin , amax])
      ylim1 = get(gca,'YLim');
      if( ylim1(1)<0 && ylim1(2)>0 )
        plot([t(iselne(1)) t(iselne(end))],[0 0],':','Color',gray);
      end
      if(i72lines==1 )
        for iline = 1:numel(t72lo)
          plot([t72lo(iline) t72lo(iline)],get(gca,'YLim'),sVertLine,'Color',gray,'LineWidth',widVert);
          plot([t72hi(iline) t72hi(iline)],get(gca,'YLim'),sVertLine,'Color',gray,'LineWidth',widVert);
        end
      end
      hold off
      set(gca,'TickLength',ticklen);
      set(gca,'XMinorTick','on');
      set(gca,'YMinorTick','on');
      set(gca,'FontSize',fsa);
      ylabel(sYLab{irow},'FontSize',fsxy);
      if( irow==nrow )
        xlabel(sXLab,'FontSize',fsxy);
      else
        set(gca,'XTickLabel','');
      end
      if( itscreen==1 ); xlim([tlo thi]); end
      textNormFig( gca, fxlab, fylab, sLab{irow+4}, fsl );
      if( i72legend==1 & irow==1 )
        text(34,-2,'MMS{\color[rgb]{0,0,0}1},{\color[rgb]{.9,0,0}2},{\color[rgb]{0,.8,0}3},{\color[rgb]{.3,.3,1}4},{\color[rgb]{.85,.65,.125}Centroid}','Fontsize',fsxy);
      end
    end % ic
  end % ifld
  if( iPlot72>=2 )
    sFile = [sDirPlots 'Poly_MDDBBJ_BscOut' num2str(iScOutIn) '_Brs' num2str(iBurst) '_Smo' num2str(nsmoothspan) '_Sub' num2str(iSubAvB) '_Rot' num2str(iRotate) '_noXRot' num2str(iNoXRotation) '_iSys' num2str(iSystem) '_iIncmprs' num2str(iIncmprs) '_iexctB' num2str(iExactB) '_iNF' num2str(iNormFlds) '_' num2str(wFlds(1)) '-' num2str(wFlds(2)) '-' num2str(wFlds(3)) '-' num2str(wFlds(4)) '-' num2str(wFlds(5)) '-' num2str(wFlds(6)) '_wB' num2str(wMag) '_iAltNe' num2str(iAltNe) '_t' num2str(tlo,3) '-' num2str(thi,3) ];
    save([sFile '.mat'],'t','lambda','mvcalc','Bfit','bavv','B0fit','bv','Jpfit','Jpvav3','Jp0fit','Jpv3','iselne');
    if( iPlot72==2 )
      export_fig(sFile,'-pdf');
%     export_fig([sDirPlots 'Poly_MDDBBJ_BscOut' num2str(iScOutIn) '_Brs' num2str(iBurst) '_Smo' num2str(nsmoothspan) '_Sub' num2str(iSubAvB) '_Rot' num2str(iRotate) '_noXRot' num2str(iNoXRotation) '_iSys' num2str(iSystem) '_iIncmprs' num2str(iIncmprs) '_iexctB' num2str(iExactB) '_iNF' num2str(iNormFlds) '_' num2str(wFlds(1)) '-' num2str(wFlds(2)) '-' num2str(wFlds(3)) '-' num2str(wFlds(4)) '-' num2str(wFlds(5)) '-' num2str(wFlds(6)) '_wB' num2str(wMag) '_iAltNe' num2str(iAltNe) '_t' num2str(tlo,3) '-' num2str(thi,3)  '.eps '],'-eps'); 
    end
  end
end % iPlot72

%% iW28info

if( iW28info==1 && iSystem==28 )
  w28sum = sum(w28a);
  w28sumSum = sum(w28sum);
  w28sum = w28sum/w28sumSum
end

