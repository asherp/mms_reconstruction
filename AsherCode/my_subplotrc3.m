function hAxis = my_subplotrc3(nrow, ncol, irow, icol, xsc1, xsc2, ysc1, ysc2 )
% Like subplotrc(nrow, ncol, irow, icol), but with exactly range of position on the plot defined

height = (ysc2-ysc1)/nrow;
width  = (xsc2-xsc1)/ncol;

pos = [xsc1   + (icol-1)*width,    ...
       ysc2    -    irow*height,   ...
       width,                      ...
       height
       ];

hAxis = subplot('position', pos);

end