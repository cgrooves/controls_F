import matplotlib.pyplot as plt
import matplotlib as mpl
import matplotlib.patches as mpatches
import numpy as np
import VTOL_params as P

class VTOL_animation:

    def __init__(self):
        self.flagInit = True
        self.fig, self.ax = plt.subplots()
        self.handle = []
        self.body = RigidBody(P.body_coords)

        plt.axis([-3*P.rotor_width, 3*P.rotor_width, -0.1, 3*P.rotor_width])
        plt.plot([-2*P.rotor_width, 2*P.rotor_width],[0,0],'b--')

    def drawVTOL(self,u):
        z = u[0]
        h = u[1]
        theta = u[2]

        self.body.move(u)

        self.drawRotors(u)
        self.drawCenter(u)
        self.drawConnectors(u)

        if self.flagInit == True:
            self.flagInit = False

    def drawCenter(self,u):

    def drawConnectors(self,u):

    def drawRotors(self,u):

        z = u[0]
        h = u[1]
        theta = u[2]

        x =
