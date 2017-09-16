import matplotlib.pyplot as plt
import matplotlib as mpl
import matplotlib.patches as mpatches

import numpy as np

# Data to be described on each axis
x_data1 = np.linspace(0,10,100)
y_data1 = np.sin(0.2*np.pi*x_data1)
x_data2 = np.linspace(0,20,200)
y_data2 = np.cos(0.2*np.pi*x_data2)

f, ax = plt.subplots(2)

f.sca(ax[0])

line1, = ax[0].plot(x_data1,y_data1)

ax[0].set_title("First Plot")
ax[0].set_xlabel("X Data 1")
ax[0].set_ylabel("Y Data 1")

ax[1].set_title("Second Plot - woopee")
ax[1].set_xlabel("X Data 2")
ax[1].set_ylabel("Y Data 2")

line2, = ax[1].plot(x_data2,y_data2)

f.tight_layout()

f.show()

thing = raw_input("Press Enter to continue")

line3 = ax[0].plot(x_data1,np.cos(0.2*np.pi*x_data1))
line2.set_ydata(0.5*y_data2)

f.show()

thing = raw_input("...")

exit()
