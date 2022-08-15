import numpy as np
from pyCascade import utils
from matplotlib import pyplot as plt


class LES_Physics:
    def __init__(self, LES_params = {}):
        # LES params
        self.LES_params = {}
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

        uStar = utils.get_input(uStar, self.LES_params['uStar'])
        z0 = utils.get_input(z0, self.LES_params['z0'])
        disp = utils.get_input(disp, self.LES_params['disp'])
        vK_const = utils.get_input(vK_const, self.LES_params['vK_const'])
        z_values = utils.get_input(z_values, self.LES_params['z_values'])

        z_scaled = (z_values - disp)/z0
        z_scaled[z_scaled<1] = 1

        log_wind = (uStar/vK_const)*np.log(z_scaled)
        plt.plot(log_wind, z_values)
        plt.xlabel('velocity')
        plt.ylabel('height [m]')