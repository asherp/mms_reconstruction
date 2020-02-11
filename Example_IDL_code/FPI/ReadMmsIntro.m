clear all; close all;
% addpath('C:\IDL\IDLwk\SaveIDL\MMS\ReadMMS'); % You could use this to put
% the programs somewhere else

iBurst = 2; dtBurst2 = 0.001; % dtBurst2 used only for iBurst=2
iBurstE = 0;
iQuarterFPI = 0;

stime = '15:03';
hr0 = 15; mn0 = 03; 
iCut = 1; % Use = 1; Cut times in s
if( iBurst>=2 )
   tCut1 = 24.03; tCut2 = 24.07;
else
   tCut1 = 24.03; tCut2 = 24.07;
end

% You shouldn't need to change anything below here

% Only relevant if iBurst==3:
if( iBurst>=3 )
  iBurst3op = 1;
  if( iBurst3op==0 )
    sigpos = 0.040; sigtfld = 0.000020; sigtfpi = 0.0005;   sigposa = randn(3,4)*sigpos; sigposa(:,5) = mean(sigpos,2); sigtflda = randn(1,4)*sigtfld; sigtfpia = randn(1,4)*sigtfpi;
    sigB = 0.1; sigBa = randn(3,4)*sigB; sigV = 100.; sigVa = randn(3,4)*sigV;
  elseif( iBurst3op==1 )
    sigpos = 0.00; sigtfld = 0.00000; sigtfpi = 0.000;   sigposa = randn(3,4)*sigpos; sigposa(:,5) = mean(sigpos,2); sigtflda = randn(1,4)*sigtfld; sigtfpia = randn(1,4)*sigtfpi;
    sigB = 0.; sigV = 00.; sigJ = 0.0; sigBa = randn(3,4)*sigB; sigVa = randn(3,4)*sigV; sigJa = randn(3,4)*sigJ;
  end
end
if( iBurst==4 )
  iBurst4spintone = 1;
  iB4en = 10;
end

% Don't fiddle with this
iScreenOffsets = 0; t1Off = 50; t2Off = 112;
iSpin = 0; t1SpinOff = 241.7; t2SpinOff = 243.1;
itPlotLim = 0;

sFilePt3 = '_brst_l2.txt';

if( iBurst>=2 )
  sFileMagPt3 = '_fsm_b_gse_brst_l3.txt';
  sMag = 'FGM_L3';
elseif( iBurst==1 )
  sFileMagPt3 = '_fgm_b_gse_brst_l2.txt';
  sMag = 'FGM';
else
  sFileMagPt3 = '_fgm_b_gse_brst_l2.txt';
  sMag = 'FGM';
end
if( iBurst==4 )
  sFileB4_1 = '../justFPI/';
  sFileB4_2 = 'mms';
  sFileB4_4 = '_fpi_brst_l2_';
  sFileB4_5 = { 'des-moms' 'des-partmoms' ; 'dis-moms' 'dis-partmoms' };
  sFileB4_6 = '.cdf';
%    sFileB4 = [sFileB4_1 sFileB4_2 num2str(isc) sFileB4_4 sFileB4_5{iei,ifp} sFileB4_6];
end
if( iBurstE == 1 )
  sFileEPt3 = '_edp_dce_gse_brst_l2.txt';
  sElec= 'EDP';
else
  sFileEPt3 = '_edp_dce_gse_fast_l2.txt';
  sElec= 'EDP';
end
if( iQuarterFPI==1 )
  sFPI = 'FPI_L3';
else
  sFPI = 'FPI';
end
sSpin = 'Spin';
sFileSpinPt3 = '_spin_axis_dir_gse.txt';

%%

if( iBurst>=1 )
  
  ReadMmsBurstProcess
  
else
  
  ReadMmsElectronProcess
  
end

%%

MakeAaProcess