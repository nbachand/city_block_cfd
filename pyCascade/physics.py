import numpy as np
from pyCascade import utils
from matplotlib import pyplot as plt


class LES_Physics(utils.Helper):
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
        uStar = "self.LES_params['uStar']", 
        z0 = "self.LES_params['z0']", 
        disp = "self.LES_params['disp']", 
        vK_const = "self.LES_params['vK_const']",
        z_values = "self.LES_params['z_values']",
        ):

        uStar, z0, disp, vK_const, z_values = [self.get_input(input) for input in [uStar, z0, disp, vK_const, z_values]]

        z_scaled = (z_values - disp)/z0
        z_scaled[z_scaled<1] = 1

        log_wind = (uStar/vK_const)*np.log(z_scaled)
        self.LES_params['log_wind'] = log_wind
        plt.plot(log_wind, z_values)
        plt.xlabel('velocity')
        plt.ylabel('height [m]')

        for key in ['uStar', 'z0', 'disp', 'vK_const', 'z_values']:
            self.LES_params[key] = eval(key) #save params

    def calc_flatplate_quantities(
        self,
        rho = "self.LES_params['rho']",
        uInf = "self.LES_params['log_wind'][-1]",
        L = "self.LES_params['z_values'][-1]",
        mu = "self.LES_params['mu']",
        yPlus = "self.LES_params['flatplate']['yPlus']"
        ):

        '''
        from https://www.cadence.com/en_US/home/tools/system-analysis/computational-fluid-dynamics/y-plus.html
        '''

        if 'flatplate' not in self.LES_params:
            self.LES_params['flatplate'] = {}

        rho, uInf, L, mu, yPlus = [self.get_input(input) for input in [rho, uInf, L, mu, yPlus]]

        Rex = rho*uInf*L/mu
        Cf = .026/Rex**(1/7)
        tauW = (Cf*rho*uInf**2)/2
        uFric = np.sqrt(tauW/rho)
        spacingW = yPlus*mu/(uFric*rho)

        print(f'U infinity is {uInf} with L = {L}')
        print(f'flat plate Reynolds number is {Rex}')
        print(f'wall spacing is {spacingW} for y+ of {yPlus}')

        for key in ['rho', 'mu']:
            self.LES_params[key] = eval(key) #save params
        
        for key in ['yPlus', 'Rex', 'Cf', 'tauW', 'uFric', 'spacingW']:
            self.LES_params['flatplate'][key] = eval(key) #save params


