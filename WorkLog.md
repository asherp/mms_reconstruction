# 2019-09-24 10:40:57.097485: clock-out

# 2019-09-24 09:24:02.423886: clock-in

# 2019-09-23 19:09:38.992719: clock-out

# 2019-09-23 18:24:03.295200: clock-in

# 2019-09-23 16:57:15.731618: clock-out

* working on field visualization
* checking if B(x_1(t), t) = B_1(t) - they don't match!

# 2019-09-23 14:46:33.197125: clock-in

# 2019-09-13 14:53:15.978872: clock-out
* Magnetic field trace bugs
* Still getting conflicting field line shape and vectors

# 2019-09-13 12:28:51.332360: clock-in

# 2019-09-12 16:26:24.646145: clock-out

* Continuing field line integration
* Not sure why the integrator is not following the field

# 2019-09-12 15:32:27.581460: clock-in

# 2019-09-12 13:07:03.145751: clock-out
* Started field line tracing

# 2019-09-12 12:29:25.073245: clock-in

# 2019-09-03 13:06:46.121506: clock-out
* Got normalized expression for fields
* Need to change integration symbol in kamodo

# 2019-09-03 12:24:49.356981: clock-in

# 2019-09-03 11:34:21.525229: clock-out

# 2019-09-03 11:27:00.923804: clock-in

# 2019-09-03 11:01:16.212944: clock-out
* Working on streamlines
* Normalizing fields

# 2019-09-03 10:00:35.149993: clock-in

# 2019-09-02 17:38:46.527376: clock-out
* Got Bfield at arbitrary position
* Got Bfield at arbitrary time
* Looking at 3D plot

# 2019-09-02 14:22:07.172379: clock-in

# 2019-09-02 13:03:07.146726: clock-out
* functionalized 2D vector matlab code
* generated 2D vector plot similar to Figure 2

# 2019-09-02 11:42:59.973564: clock-in

# 2019-09-02 11:33:07.023394: clock-out
* Added observed current at spacecraft
* Adding vector plots

# 2019-09-02 10:38:41.808706: clock-in

# 2019-08-31 13:05:30.809511: clock-out
* pandas 

# 2019-08-31 12:46:40.914608: clock-in

# 2019-08-30 18:41:34.710243: clock-out
* refactored Denton class

# 2019-08-30 16:51:47.178243: clock-in

# 2019-08-30 15:54:36.623316: clock-out
* Adding observed fields

# 2019-08-30 15:08:38.508036: clock-in

# 2019-08-30 13:13:44.887412: clock-out
* Creating Reconstruction class "Denton"

# 2019-08-30 10:50:13.896577: clock-in

# 2019-08-30 10:47:19.185791: clock-out

# 2019-08-30 09:53:52.875040: clock-in

# 2019-08-29 17:26:27.508461: clock-out
* kamodofying variables

# 2019-08-29 15:50:39.484858: clock-in

# 2019-08-29 14:42:44.162859: clock-out: kamodofication
* kamodofying reconstruction

# 2019-08-29 13:09:02.864716: clock-in

# 2019-08-29 12:01:43.113701: clock-out
* got figure 1 run with octave-python wrapper

# 2019-08-29 10:42:07.150572: clock-in

# 2019-08-29 10:12:57.540840: clock-out: refactoring matlab
* functionalizing matlab code

# 2019-08-29 09:36:13.907410: clock-in

# 2019-08-28 19:24:47.425580: clock-out: implemented oct2py version
* Using Oct2py to get more accurate solution


# 2019-08-28 17:28:04.167681: clock-in

# 2019-08-27 16:55:35.794293: clock-out
* Testing original code in octave
* Installing octave dependencies for optim, which has sqlin function
* Reproduced figure in octave!
* Should be able to compare arrays to see what goes wrong in python
* Comparing the deviations, the solutions for matlab are much better fits than what I'm producing in python

# 2019-08-27 14:36:53.267068: clock-in

# 2019-08-27 13:01:53.889289: clock-out
* Implemented new python sqlin function
* Still not getting good fit
* Testing lsqlin against spec yields good results
* Perhaps need a plot of dev 
* Some spacecraft fits are closer than others, but not really good agreement

# 2019-08-27 09:54:04.589499: clock-in

# 2019-08-26 22:36:45.275019: clock-out
* looking at scipy's least_squares solver
May have found an alternative:
* http://maggotroot.blogspot.ch/2013/11/constrained-linear-least-squares-in.html
* https://github.com/KasparP/PSI_simulations/blob/master/Python/SLAPMi/lsqlin.py
* https://cvxopt.org/install/index.html

# 2019-08-26 20:58:30.063041: clock-in

# 2019-08-26 19:19:54.102817: clock-out

# 2019-08-26 17:49:54.964387: clock-in

# 2019-08-26 16:05:12.297710: clock-out
* The fits are still scrambled
* Splitting off iSystem=2 code
* Checking if referencing any unpadded variables
* Got much better graphs using a different least squares method
* Need to compare closely with figures

# 2019-08-26 12:45:15.156882: clock-in

# 2019-08-26 12:09:51.871169: clock-out: T-5m
* Checking solution
* Comparing with plots

# 2019-08-26 11:30:41.979566: clock-in

# 2019-08-25 01:07:29.008290: clock-out
* Investigating flippening
* Found the problem! From the numpy docs, the eigenvectors are:

> The normalized (unit “length”) eigenvectors, such that the column v[:,i] is the eigenvector corresponding to the eigenvalue w[i].
So when we get the sorted eigenvectors, we have to index v[:,isort] instead of v[isort]

# 2019-08-24 23:42:36.954438: clock-in

# 2019-08-24 11:09:51.635223: clock-out
* The dot product may be causing the flippening

# 2019-08-24 10:40:41.552612: clock-in

# 2019-08-23 20:49:09.555353: clock-out
* Bfit calculation
* Plotting
* Something goes wrong at mv calculation

# 2019-08-23 19:21:16.259283: clock-in

# 2019-08-23 16:30:46.460946: clock-out
* computed solution for each time step
* lots of variance in solution

# 2019-08-23 15:17:10.120207: clock-in

# 2019-08-23 15:14:57.450442: clock-out
* Looking at sequential least squares
* constructed callable function to be minimized
* added equality constraint
* minimized function

# 2019-08-23 13:19:53.913123: clock-in

# 2019-08-23 12:01:50.563258: clock-out
* PolySolution
* Padding arrays just prior to solver
* choosing a linear least squares solver

# 2019-08-23 11:01:25.738946: clock-in

# 2019-08-22 17:29:33.998244: clock-out
* working through PolySolution

# 2019-08-22 15:36:05.528427: clock-in

# 2019-08-22 14:17:29.855856: clock-out
* pushing to private repo
* finished polysetup

# 2019-08-22 12:15:54.279334: clock-in

# 2019-08-22 12:15:47.712709: clock-out: T-12m

# 2019-08-22 11:18:11.001635: clock-in

# 2019-08-21 18:21:13.254683: clock-out

# 2019-08-21 16:56:58.801777: clock-in

# 2019-08-21 16:35:56.760909: clock-out
* Working through polysetup

# 2019-08-21 14:57:41.953489: clock-in

# 2019-08-21 13:01:24.897211: clock-out
* plotting arrays
* defining arange so it returns 0-indexed values

# 2019-08-21 12:27:40.197024: clock-in

# 2019-08-21 12:02:54.635297: clock-out

* started plotting

# 2019-08-21 11:09:45.006414: clock-in

# 2019-08-20 17:51:37.446477: clock-out
* moving averages

# 2019-08-20 14:42:58.598844: clock-in

# 2019-08-20 14:31:55.684581: clock-out

# 2019-08-20 14:01:12.093212: clock-in

# 2019-08-20 13:22:07.831622: clock-out

# 2019-08-20 12:50:05.585350: clock-in

# 2019-08-20 12:35:58.762521: clock-out
* going to try smop with python 2.7
* Loading data from matlab save files

# 2019-08-20 11:20:14.096712: clock-in

# 2019-08-19 17:12:20.316343: clock-out
* working through PolySetup
* most of the fitting is in PolySolution

# 2019-08-19 15:34:22.080843: clock-in

# 2019-08-16 17:43:49.167917: clock-out
* parsing into python, smop was written for 2.7 so bugfixes..

# 2019-08-16 17:12:08.756158: clock-in

# 2019-08-09 00:19:46.950974: clock-out
* looking at python-matlab bridge https://github.com/arokem/python-matlab-bridge
* Also looking for auto-translator smop - looks promising!
* Got utf-8 reading errors - try copy/pasting

# 2019-08-08 23:44:14.862557: clock-in

# 2019-08-08 23:39:05.758576: clock-out
* installed octave and jupyter with gnuplot
* tested sample notebook
* Loaded most of the code into jupyter
* Need to break up the code and run in sections

# 2019-08-08 22:09:05.490844: clock-in

# 2019-08-05 10:12:41.114856: clock-out

# 2019-08-05 09:49:08.269708: clock-in

# 2019-08-04 17:35:26.180635: clock-out: T-5m

# 2019-08-04 17:22:39.701500: clock-in

# 2019-08-03 11:00:58.565321: clock-out
* Reading through paper

# 2019-08-03 09:42:57.878209: clock-in: T-10m

