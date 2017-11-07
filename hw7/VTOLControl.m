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
           self.hCtrl = PIDControl(P.h_gains,P.tau,P.Ts,2*P.sat_limit,P.threshold);
           self.thetaCtrl = PDControl(P.theta_gains.kP,P.theta_gains.kD,P.tau,P.Ts,[-inf, inf]);
           self.zCtrl = PIDControl(P.z_gains,P.tau,P.Ts,[-inf,inf],P.threshold);
           
           self.mc = P.mc;
           self.mr = P.mr;
           self.d = P.d;
           self.g = P.g;
           
           self.limit = P.sat_limit;
           
       end
       %----------------
       function force = u(self,h_r,h,z_ref,z,theta)
           
           
           % get theta_ref from z
           theta_ref = self.zCtrl.PID(z_ref,z,0,1);
           T = self.thetaCtrl.PD(theta_ref,theta,0); % get torque T
           
           % find equilibrium force
           Fe = self.g*(self.mc + 2*self.mr);
           
           % get F from height controller
           F = self.hCtrl.PID(h_r,h,Fe,1);
           
           force = zeros(2,1);

           force(1) = 0.5*F - 0.5/self.d*T; % get force
           force(2) = 0.5*F + 0.5/self.d*T;
           
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