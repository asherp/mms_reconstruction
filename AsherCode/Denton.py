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

print('hullo guvnah')


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
			

		if solve:
			self.solve()

	def set_efield(self):
		for i, c in enumerate('lmn'):
			varname = 'evec_{}'.format(c)
			self.interpolators[varname] = array_interpolator(self.t, self.setup['mvcalc'][:,:,i,0])


		@kamodofy(citation = self.citation)
		def evec_l(t = self.t):
			"""the local MDD intermediate gradient direction l in components L,M,N"""
			return interpolators['evec_l'](t).T

		@kamodofy(citation = self.citation)
		def evec_m(t = self.t):
			"""the local MDD minimum gradient direction m, direction m in components L,M,N"""
			return interpolators['evec_m'](t).T

		@kamodofy(citation = self.citation)
		def evec_n(t = self.t):
			"""the local MDD maximum gradient direction n, in components L,M,N"""
			return interpolators['evec_n'](t).T

		self['evec_l'] = evec_l
		self['evec_m'] = evec_m
		self['evec_n'] = evec_n

		for i, c in enumerate('lmn'):
			for j, c_ in enumerate('LMN'):
				varname_c = 'e_{}_{}'.format(c, c_)
				self.interpolators[varname_c] = array_interpolator(self.t, self.setup['mvcalc'][:,j,i,0])
				self.set_e_components(varname_c)

	def set_lambdas(self):
		self.interpolators['lambdavec'] = array_interpolator(self.t, self.setup['lambda'])

		@kamodofy(citation = self.citation)
		def lambdavec(t = self.t):
			"""MDD eigenvalues in L,M,N directions"""
			return self.interpolators['lambdavec'](t).T

		self['lambdavec'] = lambdavec


		for i, c in enumerate('LMN'):
			varname = 'lambda_{}'.format(c)
			self.interpolators[varname] = array_interpolator(self.t, self.setup['lambda'][:,i])
			self.set_lambda_components(varname)
			
	def set_lambda_components(self, varname):
		@kamodofy(citation = self.citation)
		def lambda_i(t = self.t):
			"""MDD eigenvalue component"""
			return self.interpolators[varname](t).T
		self[varname] = lambda_i

	def set_e_components(self, varname):
		@kamodofy(citation = self.citation)
		def e_i_j(t = self.t):
			"""e component"""
			return self.interpolators[varname](t).T
		self[varname] = e_i_j

	def set_B_fit_c_component(self, varname, component):
		comp_lower = component.lower()
		def Bhat_c(t = self.t):
			"""Component of centroidal field"""
			return self.interpolators[varname](t).T
		self[varname] = kamodofy(Bhat_c, citation = self.citation, 
								 equation = "$$\hat{{B}}_{{c,{component}}}(t) = \hat{{B}}_{{c}} \hat{{{complower}}} $$".format(component = component, complower = comp_lower))

	def set_Bvec_fit_mms(self, varname, ispacecraft):
		def Bvechat(t = self.t):
			"""The magnetic field fit at MMS-{}: 3D Reduced quadratic model"""
			return self.interpolators[varname](t).T
		
		Bvechat.__doc__ = Bvechat.__doc__.format(ispacecraft)    
		self[varname] = kamodofy(Bvechat, citation = self.citation)

	def set_Bfit_components(self, varname):
		@kamodofy(citation = self.citation)
		def Bfit_c(t = self.t):
			"""Bfit component"""
			return self.interpolators[varname](t).T
		self[varname] = Bfit_c

	def set_Bfit(self):
		"""Registers Bfit solution"""
		self.interpolators['B0_fit'] = array_interpolator(self.t, self.soln.B0fit)

		@kamodofy(citation = self.citation, equation = "$$\hat{{\\vec{{B}}}}_{{c}} = \sum_{i=1}^4 \\vec{{B}}_i /4$$")
		def Bvechat_c(t = self.t):
			"""The average field of all spacecraft"""
			return self.interpolators['B0_fit'](t).T

		self['Bvechat_c'] = Bvechat_c

			
		for i, c in enumerate('LMN'):
			varname = 'Bhat_c_{}'.format(c)
			self.interpolators[varname] = array_interpolator(self.t, self.soln.B0fit[:,i])
			self.set_B_fit_c_component(varname, c)


		for i in range(4):
			varname = 'Bvechat_{}'.format(i+1)
			self.interpolators[varname] = array_interpolator(self.t, self.soln.Bfit[:,:,i])
			self.set_Bvec_fit_mms(varname, i+1)
			
			for j, c in enumerate('LMN'):
				varname = 'Bhat_{}_{}'.format(i+1,c)
				self.interpolators[varname] = array_interpolator(self.t, self.soln.Bfit[:,j,i])
				self.set_Bfit_components(varname)

	def set_J_fit_c_component(self, varname, component):
		comp_lower = component.lower()
		def Jhat_c(t = self.t):
			"""Component of centroidal field"""
			return self.interpolators[varname](t).T
		self[varname] = kamodofy(Jhat_c, citation = self.citation, 
								 equation = "$$\hat{{J}}_{{c,{component}}}(t) = \hat{{\\vec{{J}}}}_{{c}} \hat{{{complower}}} $$".format(component = component, complower = comp_lower))


	def set_Jvec_fit_mms(self, varname, ispacecraft):
		def Jvechat(t = self.t):
			"""The current field fit at MMS-{}: 3D Reduced quadratic model"""
			return self.interpolators[varname](t).T
		
		Jvechat.__doc__ = Jvechat.__doc__.format(ispacecraft)    
		self[varname] = kamodofy(Jvechat, citation = self.citation)

	def set_Jfit_components(self, varname):
		@kamodofy(citation = self.citation)
		def Jfit_c(t = self.t):
			"""Jfit component"""
			return self.interpolators[varname](t).T
		self[varname] = Jfit_c

	def set_Jfit(self):
		"""Registers Jfit solution"""
		self.interpolators['J0_fit'] = array_interpolator(self.t, self.soln.Jp0fit)

		@kamodofy(citation = self.citation, equation = "$$\hat{{\\vec{{J}}}}_{{c}} = \sum_{i=1}^4 \\vec{{J}}_i /4$$")
		def Jvechat_c(t = self.t):
			"""The average field of all spacecraft"""
			return self.interpolators['J0_fit'](t).T

		self['Jvechat_c'] = Jvechat_c
				
		for i, c in enumerate('LMN'):
			varname = 'Jhat_c_{}'.format(c)
			self.interpolators[varname] = array_interpolator(self.t, self.soln.Jp0fit[:,i])
			self.set_J_fit_c_component(varname, c)


		for i in range(4):
			varname = 'Jvechat_{}'.format(i+1)
			self.interpolators[varname] = array_interpolator(self.t, self.soln.Jpfit[:,:,i])
			self.set_Jvec_fit_mms(varname, i+1)

			for j, c in enumerate('LMN'):
				varname = 'Jhat_{}_{}'.format(i+1,c)
				self.interpolators[varname] = array_interpolator(self.t, self.soln.Jpfit[:,j,i])
				self.set_Jfit_components(varname)

	def solve(self):
		self.soln = octave.PolySolution(self.intro, self.setup)

		self.set_Bfit()

		self.set_Jfit()
		

		
