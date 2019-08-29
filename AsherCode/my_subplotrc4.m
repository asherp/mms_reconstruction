function hAxis = my_subplotrc4(nrow, ncol, irow, icol, xsc1, xsc2, ysc1, ysc2, hgap, vgap )
% Like subplotrc(nrow, ncol, irow, icol), but with exactly range of position on the plot defined

height = (ysc2-ysc1 -(nrow-1)*vgap)/nrow;
width  = (xsc2-xsc1-(ncol-1)*hgap)/ncol;
heightp = height + vgap;
widthp = width + hgap;

pos = [xsc1   + (icol-1)*widthp,    ...
       ysc2    - height - (irow-1)*heightp,   ...
       width,                      ...
       height
       ];

hAxis = subplot('position', pos);

end