classdef PDControl < handle
   
    properties
        kp
        kd
        limit
        beta
        Ts
        
        y_dot
        y_d1
        error_dot
        error_d1
    end
    
    methods
       
        % Constructor-------------------
        function self = PDControl(kp, kd, Ts)
           self.kp = kp;
           self.kd = kd;
           self.Ts = Ts;
           
           self.y_dot = 0.0;
           self.y_d1 = 0.0;
           self.error_dot = 0.0;
           self.error_d1 = 0.0;
       
        end
        %---------------------------------
        function u = PD(self, y_r, y)
            % Compute the error
            error = y_r - y;
            
            % derivative of y
            self.d_y(y);
            
            % Calculate input to plant
            u = self.kp*error - self.kd*self.y_dot;
            
        end
        %-----------------------------
        function self = d_y(self,y)
            self.y_dot = (y - self.y_d1)/(self.Ts);
            self.y_d1 = y;
        end
        %------------------------------
        
    end           
    
end