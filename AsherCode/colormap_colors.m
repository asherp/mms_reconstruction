function colorOut = colormap_colors(zcolor,colors)
% This function defines a colormap using multiple colors at breakpoints.
%  The breakpoints are defined by z.  Colors should be a two-dimensional array, with the corresponding
%  z value represented by the row index, and the three dimensional RGB
%  color as three column entries.

  ni = 256;
  z = linspace (min(zcolor),max(zcolor),ni)';
  colorOut = zeros(ni,3);
  colorOut = interp1(zcolor,colors,z);

end

