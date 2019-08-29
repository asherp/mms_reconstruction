function htn = textNormFig( haxis, fx, fy, slabel, fontSize )
% Plots label in figure panel using normalized coordinates

  xlim1 = get(haxis,'XLim');
  ylim1 = get(haxis,'YLim');
  xscale = get(haxis,'XScale');
  yscale = get(haxis,'YScale');
  if( strcmp(xscale , 'log' ) ); xlim1 = log10(xlim1); end;
  if( strcmp(yscale , 'log' ) ); ylim1 = log10(ylim1); end;
  xlim2 = xlim1(1) + (xlim1(2)-xlim1(1))*fx;
  ylim2 = ylim1(1) + (ylim1(2)-ylim1(1))*fy;
  if( strcmp(xscale , 'log' ) ); xlim2 = 10^(xlim2); end;
  if( strcmp(yscale , 'log' ) ); ylim2 = 10^(ylim2); end;

  htn = text(xlim2,ylim2,slabel,'FontSize',fontSize,'HorizontalAlignment','center', ...
        'VerticalAlignment','middle');

end

