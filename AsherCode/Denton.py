from plotly.offline import plot
from plotly.subplots import make_subplots
from plotly.offline import plot
import plotly.graph_objs as go
import pandas as pd
import numpy as np
from scipy.interpolate import interp1d
from kamodo import Kamodo, kamodofy

import oct2py
from oct2py import octave

octave.eval('pkg load optim')


def array_interpolator(t, a):
	return interp1d(t, a.T, bounds_error=False, copy = False)

class Denton(Kamodo):
	def __init__(self, sDirData = '.', nsmoothspan0 = 1, solve = True, **kwargs):
		self.citation = "Denton et al, 2019"
		
		self.sDirData = sDirData
		self.intro = octave.PolyIntro();

		if nsmoothspan0 is not None:
			self.intro.nsmoothspan0 = nsmoothspan0

		self.mms = octave.load_mms(self.sDirData, self.intro.iBurst)
		
		self.setup = octave.PolySetup(self.intro, self.mms)
		self.interpolators = {}
		self.soln = None

		super(Denton, self).__init__(**kwargs)


		self.t = self.setup.t.squeeze()
	

		self.set_lambdas()
		self.set_efield()
		self.set_bfield()
			

		if solve:
			self.solve()


	def register_field(self, varname, doc, **kwargs):
		def f(t = self.t):
			return self.interpolators[varname](t).T
		
		f.__doc__ = doc.format(**kwargs)
		f.__name__ = varname

		equation = kwargs.get('equation', None)
		if equation is not None:
			equation = equation.format(**kwargs)

		self[varname] = kamodofy(f, 
			citation = self.citation,
			units = kwargs.get('units', ''), 
			equation = equation)


	def set_efield(self):
		strengths = ['intermediate', 'minimum', 'maximum']
		for i, c in enumerate('lmn'):
			varname = 'evec_{}'.format(c)
			self.interpolators[varname] = array_interpolator(self.t, self.setup['mvcalc'][:,:,i,0])
			docstr = "the local MDD {strength} gradient direction {c} in components L,M,N"
			self.register_field(varname, docstr,
				strength = strengths[i], c = c)

			for j, c_ in enumerate('LMN'):
				varname_c = 'e_{}_{}'.format(c, c_)
				self.interpolators[varname_c] = array_interpolator(self.t, self.setup['mvcalc'][:,j,i,0])
				self.register_field(varname_c, "{component} component of the local MDD {strength} gradient direction {c}",
					c = c, component = c_, strength = strengths[i])

	def set_lambdas(self):
		self.interpolators['lambdavec'] = array_interpolator(self.t, self.setup['lambda'])
		self.register_field('lambdavec', "MDD eigenvalues in L,M,N directions") 

		for i, c in enumerate('LMN'):
			varname = 'lambda_{}'.format(c)
			self.interpolators[varname] = array_interpolator(self.t, self.setup['lambda'][:,i])
			self.register_field(varname, "{component} component of MDD eigenvalue", component = c)


	def set_bfield(self):
		"""Registers observed bfield"""
		self.interpolators['Bvec_c'] = array_interpolator(self.t, self.setup.bavv)
		self.register_field('Bvec_c', "The centroidal vector field of all MMS spacecraft \n {equation}",
			units = 'nT', equation = "$$\\vec{{B}}_{{c}} = \\sum_i \\vec{{B}}_i /4$$")

		for i, c in enumerate('LMN'):
			varname = 'B_c_{}'.format(c)
			self.interpolators[varname] = array_interpolator(self.t, self.setup.bavv[:,i])
			self.register_field(varname, "{component} component of centroidal magnetic field", 
				equation = "$$B_{{c,{component}}}(t) = \\vec{{B}}_{{c}} \hat{{{complower}}} $$",
				units = 'nT', component = c, complower = c.lower())


		for i in range(4):
			varname = 'Bvec_{}'.format(i+1)
			self.interpolators[varname] = array_interpolator(self.t, self.setup.bv[:,:,i])
			self.register_field(varname, "The observed magnetic field observed at MMS-{ispacecraft} in {units}", 
				ispacecraft = i+1, units = 'nT')

			for j, c in enumerate('LMN'):
				varname = 'B_{}_{}'.format(i+1,c)
				self.interpolators[varname] = array_interpolator(self.t, self.setup.bv[:,j,i])
				self.register_field(varname, 
					"{component} component of observed magnetic field at MMS-{ispacecraft}",
					component = c, ispacecraft = i+1, units = 'nT')


	def set_Bfit(self):
		"""Registers Bfit solution"""
		self.interpolators['Bvechat_c'] = array_interpolator(self.t, self.soln.B0fit)
		self.register_field('Bvechat_c', "The average predicted field of all spacecraft [{units}]\n{equation}",
			equation = "$$\\hat{{\\vec{{B}}}}_{{c}} = \\sum_i \\hat{{\\vec{{B}}}}_i /4$$",
			units = 'nT')

		for i, c in enumerate('LMN'):
			varname = 'Bhat_c_{}'.format(c)
			self.interpolators[varname] = array_interpolator(self.t, self.soln.B0fit[:,i])
			self.register_field(varname, 
				"{component} component of predicted centroidal field", 
				component = c, units = 'nT', complower = c.lower(),
				equation = "$$\\hat{{B}}_{{c,{component}}}(t) = \\hat{{B}}_{{c}} \\hat{{{complower}}} $$"
				)


		for i in range(4):
			varname = 'Bvechat_{}'.format(i+1)
			self.interpolators[varname] = array_interpolator(self.t, self.soln.Bfit[:,:,i])
			self.register_field(varname, "The magnetic field fit at MMS-{ispacecraft} [{units}] (3D Reduced quadratic model)", 
				ispacecraft = i+1,
				units = 'nT')
			
			for j, c in enumerate('LMN'):
				varname = 'Bhat_{}_{}'.format(i+1,c)
				self.interpolators[varname] = array_interpolator(self.t, self.soln.Bfit[:,j,i])
				self.register_field(varname, "{component} component of magnetic field fit at MMS-{ispacecraft} [{units}] (3D Reduced quadratic model)",
					component = c, ispacecraft = i+1, units = 'nT')


	def set_Jfit(self):
		"""Registers Jfit solution"""
		self.interpolators['Jvechat_c'] = array_interpolator(self.t, self.soln.Jp0fit)
		self.register_field('Jvechat_c', "The average current field of all MMS spacecraft",
			units = '')
				
		for i, c in enumerate('LMN'):
			varname = 'Jhat_c_{}'.format(c)
			self.interpolators[varname] = array_interpolator(self.t, self.soln.Jp0fit[:,i])
			self.register_field(varname, "{component} component of average current of all MMS spacecraft", 
				equation = "$$\\hat{{J}}_{{c,{component}}}(t) = \\hat{{\\vec{{J}}}}_{{c}} \\hat{{{complower}}} $$",
				component = c, complower = c.lower())


		for i in range(4):
			varname = 'Jvechat_{}'.format(i+1)
			self.interpolators[varname] = array_interpolator(self.t, self.soln.Jpfit[:,:,i])
			self.register_field(varname, "The current field fit at MMS-{ispacecraft}: 3D Reduced quadratic model",
				ispacecraft = i+1)

			for j, c in enumerate('LMN'):
				varname = 'Jhat_{}_{}'.format(i+1,c)
				self.interpolators[varname] = array_interpolator(self.t, self.soln.Jpfit[:,j,i])
				self.register_field(varname, "{component} component of current at MMS-{ispacecraft}: 3D Reduced quadratic model",
					ispacecraft = i+1, component = c)

	def solve(self):
		self.soln = octave.PolySolution(self.intro, self.setup)

		self.set_Bfit()

		self.set_Jfit()
		

		
