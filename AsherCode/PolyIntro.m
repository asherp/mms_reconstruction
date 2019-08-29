% clcl;

%%
function intro = PolyIntro()

intro.iLaptop = 0;
% if( iLaptop==1 )
%   addpath('C:\IDL\IDL_wk\SaveIDL\MMS\Poly');
% else
%   addpath('G:\IDL\IDLwk\SaveIDL\MMS\Poly');
% end

% Time
intro.iTest=0; % To do analytical test of equations; normally=0
intro.sTime = '12:18'; % Hour and minute for plots
intro.itscreen = 1; iInt = 13; 
%         1  2   3    4     5     6    7       8     9      10    11     12  13
tloa = [ 31 32  32    32   32.6  32.8  32.84  32.4  32.52   31.3  32.3   20  31];
intro.tloa = tloa;
thia = [ 36 35  33.3  32.5 33.1  33    32.94  33.2  33.12   33.3  32.9   45  35.5];  tlo = tloa(iInt); thi = thia(iInt);
intro.tlo = tlo;
intro.thi = thi;
intro.thia = thia;
intro.iNoJConvert = 0; % =1 for simulation units

% Data and smoothing
intro.iBurst = 2; % 1 to use burst data
if( intro.iBurst==2 ), tsub = 0; else, tsub = 0; end % t -> t - tsub
intro.tsub = tsub;
intro.iSubAvB = 0;  % 1 to subtract off the average quiet B, 0 for none, 1 for Richard, 2 for Kevin
intro.iAltSmooth = 0; % =0 to use nsmoothspan0, 1 to use VaSmooth0 to calculate, 2 to get 1st quartile of real Va for VaSmooth
intro.nsmoothspan0 = 301;
intro.VaSmooth0 = 300;

% Adjustment of density
intro.iAltNe = 2; % 0 not to not fiddle with Ne, 1 to use best value to match Jcurl to Jp, 2 to use median match
intro.iRotate = 35;

% Method of solution
intro.iSystem = 2; % 1 for 2D special, 2 for 3D special, 3/4/5/6/7 for quad+,quad,quad-,quad--,2D, 8 for 3D special with Lmin, 9 to add third N deriv of Bl, 10 for linear, 11 for linear 2D
% 9 for Roy-like solution with one term, 28 for Roy solution
intro.iScOutIn = 0; % Don't use sc iScOut in solution, 11/12/13/14 for just J out
% For iSystem==9:
intro.i28term = 3; % 1/2/3/4 for d^3Bl/dn^3, d^3Bm/dn^2 dl, d^3Bn/dl^2 dm, d^3Bl/dn^2 dm - only relevant for iSystem=-1 or 9
% For iSystem==28
intro.bnorm0 = 0.05; % minimum normalization value for 28th term
intro.i28termRaw = 1; % Uses weight of 28 term = 1/term
intro.iNormFlds = 0; % Option to weight field components differently
intro.wFlds = [ 3 3 1 2 3 1 ]; % for Bl, Bm, Bn, Jl, Jm, Jn
intro.iAltOrigin = 0; % >0 for origin at sc iAltOrigin, 11-14 for shifted sc to sc origin + [1 1 1]
  
% Presentation
intro.iNormD = 1; % 1 to normalize distances to sc spacing - Normally use this = 1
intro.Lmax = 3; % Max distance from centroid for plots
intro.iLocalBM = 0; % option for perturbed BM

% Less frequently used
intro.iExactB = 0; % 1 to fit B exactly in overdetermined systems
intro.wMag = 1; % Enhancement weight for B, 1 to weight B and Jp equally - use with iExactB=0
intro.iNoXRotation = 0; % 1 to not rotate into local MDDB directions for evaluation of model
intro.iIncmprs = 0; % For divergence of in-plane field = 0
intro.iMovieStep = 1; % >1 to skip frames in movies

% Plots, 1 to plot and 2 to print
intro.iPlot30 = 0; % MDDB and MG
intro.iPlot31 = 0; % MDDB + B
intro.iPlot32 = 0; % fNe
intro.iPlot33 = 0; % Ne, Bsc, Jsc
intro.iPlot34 = 0; % Model X
intro.iPlot35 = 0; % B vs LN
intro.iPlot51 = 0; % B vs LN compact + BavLMN
intro.iLocalGradCoord = 0;
intro.iPlot510 = 0; % B vs LN compact + BavLMN - 1 row for comparison
  intro.i510lr = 2; 
  intro.i510sim = 0; % Use sim data
  intro.ialtT510 = 0; % use specified times
  intro.altT510 = [ 32.84 32.88 32.91 32.94 ]; % alternate times
intro.iPlot511 = 2; % B vs LN 4x4 + BavLMN
 intro.irandsl511 = 0;
 intro.ialtT511 = 1;
 intro.altT511 = [ 31 31.478 31.6 32 32.33 32.442 32.7 32.87 33.04 33.5 33.84 34.2 34.5 34.8 35 36 ];
intro.iPlot512 = 0; % B vs LN 6x1 + BavLMN - 1 column for comparison
  intro.s512let = 'm'; % starting letter for panels
  intro.ialtT512 = 1; % use specified times
  intro.altT512 = [ 31.33, 32.33, 32.67, 32.88, 33, 33.2 ]; % alternate times
  intro.ycblab512 = 0.6;
  intro.i512ylab = 1;
  intro.ialtBM512 = 1;
  intro.altBM512 = 11.236;
intro.iPlot36 = 0; % B vs MN
intro.iPlot52 = 0; % B vs MN compact + BavLMN
intro.iPlot37 = 0; % Movie with both coords, =6 for check movie with 1 point
intro.iPlot57 = 0; % Movie with both coords + BavLMN, =6 for check movie with 1 point
intro.iPlot58 = 2; % 3D view
  intro.t3D = 32.91; sLabel58Letter = ''; % Use '' for none  % 32.87
  intro.i3DaltLN=0; % 1 for L=0, 2 for N=0; otherwise M=0
  intro.iReconstructionLabel =1; 
  intro.i58slran = 0; 
  intro.i58small = 1;
  intro.view58 = [-30,30]; % [] for default
  intro.iPrintView58 = 0;
  intro.printView58a = [ -30 30 ; 0 0 ; 0 90 ];
  intro.i58NoB0 = 0; % 2 for just M
  intro.iB0op = 1; % iB0op = 1/2 for av sc/constant poly coeff
  intro.fsphB = 0.05; 
  intro.nLB = 41; 
intro.iPlot582 = 0; % 3D Difference from simulation  ****ONLY GOOD FOR SIMULATION DATA****
  intro.iBerrOp = 1; % iBerrOp = 1/2 for dB/ang
  if( intro.iBerrOp==1 )
    intro.isoErrB = 0.01;
  else
    intro.isoErrB = 10;
  end
  intro.iErrBPlane = [ 9 9 9 ]; % =9 for none extra
intro.iPlot584 = 0; % Histogram of 3D Difference from simulation versus radial distance ****ONLY GOOD FOR SIMULATION DATA****
  intro.dRhB = 0.1; imax584 = 1; max584 = 3.25;
intro.iPlot583 = 0; % 3D Simulation B
intro.i583_2D = 0;
intro.iPlot581 = 0; % 3D movie
intro.iPlot68 = 0; % 3D view of J
intro.i68slran = 1; i68NoJ0 = 0;
intro.fsphJ = 0.05; 
intro.nLJ = 41; iJ0op = 1; % iJ0op = 1/2 for av sc/constant poly coeff
intro.iJerrOp = 1; % iJerrOp = 1/2 for dJ/ang
if( intro.iJerrOp==1 )
  intro.isoErrJ = 0.02;
else
  intro.isoErrJ = 10;
end
intro.iErrJPlane = [ 9 9 9 ]; % =9 for none extra
intro.iPlot682 = 0; % 3D Difference from simulation J ****ONLY GOOD FOR SIMULATION DATA****
intro.iPlot684 = 0; % Histogram of 3D Difference from simulation versus radial distance ****ONLY GOOD FOR SIMULATION DATA****
intro.dRhJ = 0.1;
intro.iPlot683 = 0; % 3D Simulation J
intro.iPlot38 = 0; % Lstr, Nstr
intro.iPlot381 = 0; % Lstr, Nstr horizontal for Powerpoint
%   iPlot61 = 0; % doesn't seem to exist anymore
%     t61 = 0.3;
intro.iPlot71 = 0; % Magnetic field for spacecraft not used for fit
intro.iPlot72 = 2; % MDDB + B + J fits
intro.i72lines = 1; t72lo = [32 32.84]; t72hi = [32.5 32.94];
intro.i72legend = 1;
intro.iPlot40 = 0; % BLN
intro.iW28info = 0; % sum w28a 

end %% end Function PolyIntro
%%

% PolySetup

% if( iSystem==28 )
%   PolySolution28
% else
%   PolySolution
% end

% %%

% PolyPlots

