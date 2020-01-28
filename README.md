# About

This repo tracks development of MMS analysis with Kamodo. Currently, the kamodofied Denton reconstruction code performs
the analysis on a matlab drump of the event from Denton et al. 2019. We have also developed a kamodofied cdf
reader that provides a functional interface to cdf files such as those produced by pyspedas, as demonstrated
in [this video](https://www.youtube.com/watch?v=g5Ftm0H_7yc). The eventual goal is to combine the two
so we can run the polynomial reconstruction on any event from MMS.


## Polynomial Expansion

1. Linear Model - Only linear variation in B

2. Quadratic Model - all terms except 2nd derivative w.r.t. MDD local minimum gradient coordinate me.

3. Quadratic-linear m model - drops all m terms except those linear in m

4. Reduced quadratic model - drops additional terms to keep ∂Bn/∂n small, for n perpendicular to current sheet.


* Linear has most regular variation but no plasmoids
* Quadrtic often shows overfitting
* Quadratic-linear are or Reduced quadratic are better fits for the event, though reduced quadratic does better when there is poor sampling of the structure and the plasma sheet transition appears better
* Plasmoids may not be realistic since the model is quadratic and likes to form plasmoids whether or not they are in the data.

## Taylor Expansion

Fu et al. [2015] has a first-order Taylor expansion (FOTE) that gives the x-line distance and null point. 

# Design goals

We want the solution to be as faithful to the data and physics as possible.

* Default behavior should be on the conservative side
* Plasmoids


## Generating docs

You will need mkdocs to generate this documentation site

	pip install mkdocs
	pip install mknotebooks
	pip install python-markdown-math