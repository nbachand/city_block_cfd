class LES_Physics:
    def __init__ (self, LES_params):
        # LES params
        self.LES_params.update(LES_params)

        uStar = self.LES_params['uStar']
        z0 = self.LES_params['z0']
        # deltas = self.LES_parmas['deltas']

        Uref = uStar/0.41*np.log(1.975/z0)
        q = 0.5*1.225*Uref**2

        self.LES_params.update({
            'Uref': Uref,
            'q': q
        })