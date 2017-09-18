import numpy as np

class RigidBody:

    def __init__(self, keypts):

        self.flagInit = True    # for first time tasks
        self.keypoints = keypts # [x,y]T, where x and y are row vectors


    def move(self, u):
        z = u[0]
        h = u[1]
        theta = u[2]

        self.rotate(theta)
        self.translate(z,h)


    def translate(self,z,h):
        self.keypoints[0,:] += z
        self.keypoints[1,:] += h

    def rotate(self,theta):
        rMatrix = np.matrix([[np.cos(theta), -np.sin(theta)],[np.sin(theta), np.cos(theta)]])

        self.keypoints = rMatrix*self.keypoints
