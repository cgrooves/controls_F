import numpy as np

# VTOL parameters
# Problem variables
mass_c = 1 # kg, mass of center
mass_r = 0.25 # kg, mass of right rotor
mass_l = 0.25 # kg, mass of left rotor
g = 9.81 # m/s^2
mu = 0.1 # kg/s, viscosity
Jc = 0.0042 # kg m^2, intertia around center

# Geometric variables
rotor_width = 0.2
rotor_height = 0.05
VTOL_center_size = 0.1
d = 0.3 # rotor distance from center of mass
L = 2*d + rotor_width

z0 = 0.0
h0 = 0.0

Ts = 0.01

# Target parameters
target_width = 0.1
target_height = 0.1

body_coords = np.matrix([[-VTOL_center_size/2, -VTOL_center_size/2.0, \
            VTOL_center_size/2.0, d - rotor_width/2.0, d, -d, -d + rotor_width/2.0],\
            [0.0,-VTOL_center_size/2.0,0.0,0.0,0.0,0.0,0.0]])
