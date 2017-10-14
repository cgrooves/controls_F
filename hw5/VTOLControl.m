classdef VTOLControl
   
    properties
        hCtrl
        
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
           
           self.mc = P.mc;
           self.mr = P.mr;
           self.d = P.d;
           self.g = P.g;
           
           self.limit = P.sat_limit;
           
       end
       %----------------
       function force = u(self,h_r,h)
           % find equilibrium force
           Fe = self.g*(self.mc + 2*self.mr);
           
           % get F from height controller
           F = self.hCtrl.PD(h_r,h) + Fe;
    
           left_force = 0.5*F; % get force
           right_force = 0.5*F;
           
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