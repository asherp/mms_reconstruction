function export_fig(sFile,sFormat)
%UNTITLED5 Wrapper to use print if export_fig is not available
%   sFile = output file name
%   sFormat = output format in export_fig  style

if( strcmp(sFormat,'-pdf') )
  print([sFile '.pdf'],'-dpdf');
else
  error('Add option for another format in export_fig');
end

