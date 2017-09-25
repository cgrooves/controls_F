classdef VTOLAnimation
    
    properties
        width
        height
        d
        rotor_width
        ax
        
        center
        rotor_r
        rotor_l
        connector_r
        connector_l
    end
    
    methods
              % Constructor -------------------------------------------
              function self = VTOLAnimation(P,plot_axes)
                  % include path to graphics objects
                  addpath ~/Documents/MATLAB
                  
                 % Initialize variables
                 self.width = P.width;
                 self.height = P.height;
                 self.d = P.d;
                 self.rotor_width = P.rotor_width;
                 self.ax = plot_axes;
                 
                 % Initialize axes
                 % Draw ground
                 plot([-P.plot_length/2, P.plot_length/2],[0,0],'k');
                 hold on
                 xlabel('zv (m)')
                 ylabel('h (m)')
                 
                 % Initialize VTOL to initial conditions
                 self.center = Rectangle(self.width,self.height,0);
                 self.rotor_r = Ellipse(self.rotor_width,self.height,[self.d;0],50);
                 self.rotor_l = Ellipse(self.rotor_width,self.height,[-self.d;0],50);
                 self.connector_l = SLine([0,self.d],[0,0]);
                 self.connector_r = SLine([0,-self.d],[0,0]);
              end
              % ----------------------------------------------------------
              function self = drawVTOL(self,x)
                  
                  zv = x(1);
                  h = x(2);
                  theta = x(3);
                  
                  self.center.translate([zv;h],self.ax);
                  self.center.rotate(theta,self.ax);
                  
                  self.rotor_r.translate([zv;h],self.ax);
                  self.rotor_r.rotate(theta,self.ax);
                  
                  self.rotor_l.translate([zv;h],self.ax);
                  self.rotor_l.rotate(theta,self.ax);
                  
                  self.connector_l.translate([zv;h],self.ax);
                  self.connector_l.rotate(theta,self.ax);
                  
                  self.connector_r.translate([zv;h],self.ax);
                  self.connector_r.rotate(theta,self.ax);
              end
              % ----------------------------------------------------------
        
    end    
end
