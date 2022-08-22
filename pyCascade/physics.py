import numpy as np
from pyCascade import utils
from matplotlib import pyplot as plt


class LES_Physics(utils.Helper):
    def __init__(self, LES_params = {}):
        # LES params
        self.LES_params = {
            'uStar': None,
            'z0': None,
            'disp': None,
            'vk_const': None,
            'z_values': None,
            'rho': None,
            'mu': None,
            'flatplate': {'yPlus': None}
        }
        self.LES_params.update(LES_params)

    def calc_Uref_q(self, uStar = None, z0 = None):
        uStar = utils.get_input(uStar, self.LES_params['uStar'])
        z0 = utils.get_input(z0, self.LES_params['z0'])

        # deltas = self.LES_parmas['deltas']

        Uref = uStar/0.41*np.log(1.975/z0)
        q = 0.5*1.225*Uref**2

        self.LES_params.update({
            'Uref': Uref,
            'q': q
        })

    def plot_log_wind(
        self, 
        uStar = None, 
        z0 = None, 
        disp = None, 
        vK_const = None,
        z_values = None,
        ):

        uStar = self.get_input(uStar, self.LES_params['uStar'])
        z0 = self.get_input(z0, self.LES_params['z0'])
        disp = self.get_input(disp, self.LES_params['disp'])
        vK_const = self.get_input(vK_const, self.LES_params['vK_const'])
        z_values = self.get_input(z_values, self.LES_params['z_values'])

        z_scaled = (z_values - disp)/z0
        z_scaled[z_scaled<1] = 1

        log_wind = (uStar/vK_const)*np.log(z_scaled)
        self.LES_params['log_wind'] = log_wind
        plt.plot(log_wind, z_values)
        plt.xlabel('velocity')
        plt.ylabel('height [m]')

    def calc_flatplate_quantities(
        self,
        rho = None,
        uInf = None,
        L = None,
        mu = None,
        yPlus = None
        ):

        if 'flatplate' not in self.LES_params:
            self.LES_params['flatplate'] = {}

        rho = self.get_input(rho, self.LES_params['rho'])
        uInf = self.get_input(uInf, self.LES_params['log_wind'][-1], overwrite=False)
        L = self.get_input(L, self.LES_params['z_values'][-1], overwrite=False)
        mu = self.get_input(mu, self.LES_params['mu'])
        yPlus = self.get_input(yPlus, self.LES_params['flatplate']['yPlus'])

        Rex = rho*uInf*L/mu
        Cf = .026/Rex**(1/7)
        tauW = (Cf*rho*uInf**2)/2
        uFric = np.sqrt(tauW/rho)
        spacingW = yPlus*mu/(uFric*rho)

        self.LES_params['flatplate'].update({
            'Rex' : Rex,
            'Cf' : Cf,
            'tauW' : tauW,
            'uFric' : uFric,
            'spacingW' : spacingW
        })


