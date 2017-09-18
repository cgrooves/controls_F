import time
import sys
import numpy as np
import matplotlib.pyplot as plt
import VTOL_params as P
from slider_input import Sliders
from VTOL_animation import VTOLAnimation

t_start = 0.0
t_end = 20.0
t_Ts = P.Ts # Simulation step time
t_elapse = 0.01 # Simulation time elapsed between each iteration
t_pause = 0.01 # Pause time

user_input =  Sliders()
simAnimation = VTOLAnimation()

t = t_start

while t < t_end:

    plt.ion()
    plt.figure(user_input.fig.number)
    plt.pause(0.001)
    plt.figure(simAnimation.fig.number)
    simAnimation.drawVTOL(user_input.getInputValues())

    t = t + t_elapse
