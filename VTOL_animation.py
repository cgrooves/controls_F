import matplotlib.pyplot as plt
import matplotlib as mpl
import matplotlib.patches as mpatches
import numpy as np
import VTOL_params as P
from RigidBody import RigidBody

CENTER = 0
LEFT_CONNECTOR = 1
RIGHT_CONNECTOR = 2
LEFT_ROTOR = 3
RIGHT_ROTOR = 4

class VTOLAnimation:

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

        self.body.move(u) # translate and rotate skeleton

        # draw out the updated components
        self.drawCenter(theta)
        self.drawConnectors()
        self.drawRotors(theta)

        if self.flagInit == True:
            self.flagInit = False

    def drawCenter(self,theta):

        xy = (self.body.keypoints[0,1],self.body.keypoints[1,1])

        if self.flagInit == True:
            self.handle.append(mpatches.Rectangle(xy,P.VTOL_center_size,\
            P.VTOL_center_size,angle=theta))
            self.ax.add_patch(self.handle[CENTER])
        else:
            self.handle[CENTER].set_xy(xy)

    def drawConnectors(self):

        x_left = (self.body.keypoints[0,0],self.body.keypoints[0,6])
        y_left = (self.body.keypoints[1,0],self.body.keypoints[1,6])
        x_right = (self.body.keypoints[0,2],self.body.keypoints[0,3])
        y_right = (self.body.keypoints[1,2],self.body.keypoints[1,3])

        if self.flagInit == True:
            self.handle.append(mpl.lines.Line2D(x_left,y_left,lw=1,alpha=0.3))
            self.handle.append(mpl.lines.Line2D(x_right,y_right,lw=1,alpha=0.3))
            self.ax.add_line(self.handle[LEFT_CONNECTOR])
            self.ax.add_line(self.handle[RIGHT_CONNECTOR])

        else:
            self.handle[LEFT_CONNECTOR].set_ydata(y_left)
            self.handle[LEFT_CONNECTOR].set_xdata(x_left)
            self.handle[RIGHT_CONNECTOR].set_ydata(y_right)
            self.handle[RIGHT_CONNECTOR].set_xdata(x_right)

    def drawRotors(self,theta):

        x_left = self.body.keypoints[0,5]
        y_left = self.body.keypoints[1,5]
        x_right = self.body.keypoints[0,4]
        y_right = self.body.keypoints[1,4]

        xy_left = (x_left, y_left)
        xy_right = (x_right, y_right)

        if self.flagInit == True:
            # Draw left rotor
            self.handle.append(mpatches.Ellipse(xy_left,P.rotor_width,P.rotor_height\
            ,angle=theta))
            self.ax.add_patch(self.handle[LEFT_ROTOR])
            # Draw right rotor
            self.handle.append(mpatches.Ellipse(xy_right,P.rotor_width,P.rotor_height\
            ,angle=theta))
            self.ax.add_patch(self.handle[RIGHT_ROTOR])
        else:
            self.handle[LEFT_ROTOR].set_xy(xy_left)
            self.handle[RIGHT_ROTOR].set_xy(xy_right)


# Used to see the animation
if __name__ == "__main__":

    dingie = VTOLAnimation()
    z = 0
    theta = np.pi/3
    h = 0.5
    dingie.drawVTOL([z,h,theta])
    plt.show()
