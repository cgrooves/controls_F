classdef PDControl < handle
   
    properties
        kP
        kD
        Ts
        limit
        beta
        
        y_d1
        error_d1
        uD_d1
    end
    
    methods
       
        % Constructor-------------------
        function self = PDControl(kp, kd, tau, Ts, limit)
           self.kP = kp;
           self.kD = kd;
           self.Ts = Ts;
           self.limit = limit;
           self.beta = (2*tau - Ts)/(2*tau + Ts);
           
           self.y_d1 = 0.0;
           self.error_d1 = 0.0;
           self.uD_d1 = 0.0;
       
        end
        %---------------------------------
        function u = PD(self, y_r, y, u_eq)
           % calculate error
           error = y_r - y;
            
            % calculate uP, uD, uI
            uP = error;
            uD = self.beta * self.uD_d1 + (1 - self.beta)/self.Ts*(y-self.y_d1);
            
            % calculate u_unsat
            u_unsat = self.kP*uP - self.kD*uD + u_eq;
            % saturate
            u = self.saturate(u_unsat);
            
            % Update [n-1] values
            self.y_d1 = y;
            self.error_d1 = error;
            self.uD_d1 = uD;
            
        end
        %------------------------------
        function u_sat = saturate(self,u)
            
            if u < self.limit(1)
                u_sat = self.limit(1);
            elseif u > self.limit(2)
                u_sat = self.limit(2);
            else
                u_sat = u;
            end
        end
        %------------------------------
        
    end           
    
end