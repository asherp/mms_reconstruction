from plotly.offline import plot
from plotly.subplots import make_subplots
from plotly.offline import plot
import plotly.graph_objs as go
import pandas as pd
import numpy as np
from scipy.interpolate import interp1d
from kamodo import Kamodo, kamodofy, pointlike

import oct2py
from oct2py import octave

octave.eval('pkg load optim')


def array_interpolator(t, a, columns = None):
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
        self.set_xv()
        self.set_efield()
        self.set_bfield()
        
            

        if solve:
            self.solve_fields()

        # register user-defined functions
        for varname, varfunc in kwargs.items():
            self[varname] = varfunc


    def register_field(self, varname, doc, **kwargs):
        '''registers fields'''
        
        columns = kwargs.get('columns', None)
        def f(t = self.t):
            result = self.interpolators[varname](t).T
            try:
                return pd.DataFrame(result, index = t, columns = columns)
            except:
                return result
        
        f.__doc__ = doc.format(**kwargs)
        f.__name__ = varname

        equation = kwargs.get('equation', None)
        if equation is not None:
            equation = equation.format(**kwargs)

        self[varname] = kamodofy(f, 
            citation = self.citation,
            units = kwargs.get('units', ''), 
            equation = equation)


    def set_xv(self):
        '''Sets positions as a function of time'''
        for i in range(4):
            varname = 'xvec_{}'.format(i+1)
            self.interpolators[varname] = array_interpolator(self.t, self.setup['xv'][:, :, i])
            self.register_field(varname, "position of MMS-{ispacecraft} in LMN coordinates", 
                ispacecraft = i+1, columns = list('LMN'))

    def set_efield(self):
        '''Sets electric field interpolators'''
        strengths = ['intermediate', 'minimum', 'maximum']
        for i, c in enumerate('lmn'):
            varname = 'evec_{}'.format(c)
            self.interpolators[varname] = array_interpolator(self.t, self.setup['mvcalc'][:, :, i, 0], list('LMN'))
            docstr = "the local MDD {strength} gradient direction {c} in components L,M,N"
            self.register_field(varname, docstr,
                strength = strengths[i], c = c, columns = list('LMN'))


    def set_lambdas(self):
        '''sets lambda interpolators'''
        self.interpolators['lambdavec'] = array_interpolator(self.t, self.setup['lambda'])
        self.register_field('lambdavec', "MDD eigenvalues in L,M,N directions", columns = list('LMN')) 



    def set_bfield(self):
        """Registers observed bfield"""
        self.interpolators['Bvec_c'] = array_interpolator(self.t, self.setup.bavv)
        self.register_field('Bvec_c', "The observed centroidal magnetic field of all MMS spacecraft \n {equation}",
            units = 'nT', equation = "$$\\vec{{B}}_{{c}} = \\sum_i \\vec{{B}}_i /4$$", columns = list('LMN'))


        for i in range(4):
            varname = 'Bvec_{}'.format(i+1)
            self.interpolators[varname] = array_interpolator(self.t, self.setup.bv[:, :, i])
            self.register_field(varname, "The observed magnetic field observed at MMS-{ispacecraft} in {units}", 
                ispacecraft = i+1, units = 'nT', columns = list('LMN'))

    def set_jfield(self):
        """Registers observed jfield"""
        # Jpv3 Jpvav3
        self.interpolators['Jvec_c'] = array_interpolator(self.t, self.soln.Jpvav3)
        self.register_field('Jvec_c', "The observed centroidal current field \n{equation}",
            units = '', equation = "$$\\vec{{J}}_{{c}} = \\sum_i \\vec{{J}}_i /4$$", columns = list('LMN')) 

        for i in range(4):
            varname = "Jvec_{}".format(i+1)
            self.interpolators[varname] = array_interpolator(self.t, self.soln.Jpv3[:, :, i])
            self.register_field(varname, "The observed current obbserved at MMS-{ispacecraft}",
                ispacecraft = i+1, units = '', columns = list('LMN'))


    def set_Bfit(self):
        """Registers Bfit solution"""
        self.interpolators['Bvechat_c'] = array_interpolator(self.t, self.soln.B0fit)
        self.register_field('Bvechat_c', "The average predicted field of all spacecraft [{units}]\n{equation}",
            equation = "$$\\hat{{\\vec{{B}}}}_{{c}} = \\sum_i \\hat{{\\vec{{B}}}}_i /4$$",
            units = 'nT', columns = list('LMN'))



        for i in range(4):
            varname = 'Bvechat_{}'.format(i+1)
            self.interpolators[varname] = array_interpolator(self.t, self.soln.Bfit[:, :, i])
            self.register_field(varname, "The magnetic field fit at MMS-{ispacecraft} [{units}] (3D Reduced quadratic model)", 
                ispacecraft = i+1,
                units = 'nT', columns = list('LMN'))
            


    def set_Jfit(self):
        """Registers Jfit solution"""
        self.interpolators['Jvechat_c'] = array_interpolator(self.t, self.soln.Jp0fit)
        self.register_field('Jvechat_c', "The average current field of all MMS spacecraft",
            units = '', columns = list('LMN'))
                

        for i in range(4):
            varname = 'Jvechat_{}'.format(i+1)
            self.interpolators[varname] = array_interpolator(self.t, self.soln.Jpfit[:, :, i])
            self.register_field(varname, "The current field fit at MMS-{ispacecraft}: 3D Reduced quadratic model",
                ispacecraft = i+1, columns = list('LMN'))




    def register_spatial(self):
        Lmax = self.intro.Lmax
        La = np.linspace(-1*Lmax,Lmax, 11) # +- intro.Lmax 31 default

        # points = np.array([p for p in zip(result['L3D'].ravel(), result['M3D'].ravel(), result['N3D'].ravel())])
        coordinates = np.meshgrid(La,La,La, indexing = 'ij')
        points = np.column_stack([c.ravel() for c in coordinates])
        
        def squeeze_dict(d, keys):
            return {k:d[k].squeeze() for k in keys}

        def to_arrays(d, keys):
            return {k:np.array(d[k], ndmin = 1) for k in keys}

        @kamodofy(citation = self.citation)
        def Bvec(xvec = points, t = self.t[0]):
            "Time interpolation over solution space"
            try:
                ps = xvec.reshape((-1,3))
            except:
                ps = xvec
            id0 = np.searchsorted(self.t, t, side="left")
            results = []
            cols = ['BL3D', 'BM3D', 'BN3D']
            
            r1 = octave.B3d(self.intro, self.setup, self.soln, id0+1, ps) # 1-indexed
            r2 = octave.B3d(self.intro, self.setup, self.soln, id0+2, ps)
            
            try:
                r1 = squeeze_dict(r1, cols)
                r2 = squeeze_dict(r2, cols)
                
            except:
                r1 = to_arrays(r1, cols)
                r2 = to_arrays(r2, cols)
            
            results = pd.concat([pd.DataFrame(r1),pd.DataFrame(r2)], axis = 1).values.reshape(-1,3,2, order = 'F')

            result = interp1d([self.t[id0], self.t[id0+1]], results)(t)

            try:
                return pd.DataFrame(result, columns = list('LMN'))
            except:
                return result
            
        self['Bvec'] = Bvec

    def solve_fields(self):
        self.soln = octave.PolySolution(self.intro, self.setup)

        self.set_Bfit()

        self.set_jfield()
        self.set_Jfit()
        self.register_spatial()
        

        
