import numpy as np

class RigidBody:

    def __init__(self, keypts):

        self.flagInit = True    # for first time tasks
        self.keypoints = keypts # [x,y]T, where x and y are row vectors

    def move(self, u):
        z = u[0]
        h = u[1]
        theta = u[2]

        self.translate(z,h)
        self.rotate(theta)
        self.translate(-0.05,-0.05)


    def translate(self,z,h):
        self.keypoints[0,:] += z
        self.keypoints[1,:] += h

    def rotate(self,theta):
        size = self.keypoints.shape
        xc = self.keypoints[0,size[0]-1]
        yc = self.keypoints[1,size[1]-1]
        centroid = np.matrix(self.keypoints)
        centroid[0,:] = xc
        centroid[1,:] = yc

        rMatrix = np.matrix([[np.cos(theta), -np.sin(theta)],[np.sin(theta), np.cos(theta)]])

        self.keypoints = rMatrix*(self.keypoints-centroid)+centroid

if __name__ == '__main__':
    pass
