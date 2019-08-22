# About

This repo tracks development of MMS analysis with Kamodo

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