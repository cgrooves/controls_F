classdef VTOLControl
   
    properties
        hCtrl
        thetaCtrl
        zCtrl
        
        mc
        mr
        d
        g
        
        limit
        
    end
    
    methods
       %----------------
       function self = VTOLControl(P)
           self.hCtrl = PDControl(P.kp_h,P.kd_h,P.Ts);
           self.thetaCtrl = PDControl(P.kp_theta,P.kd_theta,P.Ts);
           self.zCtrl = PDControl(P.kp_z,P.kd_z,P.Ts);
           
           self.mc = P.mc;
           self.mr = P.mr;
           self.d = P.d;
           self.g = P.g;
           
           self.limit = P.sat_limit;
           
       end
       %----------------
       function force = u(self,h_r,h,z_ref,z,theta)
           % find equilibrium force
           Fe = self.g*(self.mc + 2*self.mr);
           
           % get F from height controller
           F = self.hCtrl.PD(h_r,h) + Fe;
           
           % get theta_ref from z
           theta_ref = self.zCtrl.PD(z_ref,z);
           T = self.thetaCtrl.PD(theta_ref,theta); % get torque T
    
           left_force = 0.5*F - 0.5/self.d*T; % get force
           right_force = 0.5*F + 0.5/self.d*T;
           
           force = zeros(2,1);
           
           force(1) = self.saturation(left_force);
           force(2) = self.saturation(right_force);
           
       end
       %----------------
       function u = saturation(self,f)
           % check for f inside limits
           if f < self.limit(1)
               u = self.limit(1);
           elseif f > self.limit(2)
               u = self.limit(2);
           else
               u = f;
           end
       end
       %----------------
        
    end
    
end