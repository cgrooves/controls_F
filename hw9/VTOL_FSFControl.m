classdef VTOL_FSFControl < handle
    
    properties
        
        K_lat
        ki_lat
        K_lon
        ki_lon
        
        beta
        Ts
        limit
        
        d
        F_eq
        
        h_d1
        hdot_d1
        z_d1
        zdot_d1
        theta_d1
        thetadot_d1
        
        error_lat_d1
        errordot_lat_d1
        ui_lat
        error_lon_d1
        errordot_lon_d1
        ui_lon
        
    end
    
    methods
        %-------------------------------------------
        function self = VTOL_FSFControl(P)
            self.K_lat = P.K1_lat;
            self.ki_lat = P.ki1_lat;
            self.K_lon = P.K1_lon;
            self.ki_lon = P.ki1_lon;

            self.beta = (2*P.tau - P.Ts)/(2*P.tau + P.Ts);
            self.Ts = P.Ts;
            self.limit = P.sat_limit;

            self.F_eq = P.g*(P.mc + 2*P.mr);
            self.d = P.d;

            self.h_d1 = 0;
            self.hdot_d1 = 0;
            self.z_d1 = 0;
            self.zdot_d1 = 0;
            self.theta_d1 = 0;
            self.thetadot_d1 = 0;
            
            self.error_lon_d1 = 0;
            self.errordot_lon_d1 = 0;
            self.error_lat_d1 = 0;
            self.errordot_lat_d1 = 0;
            self.ui_lon = 0;
            self.ui_lat = 0;
        end
        %--------------------------------------------
        function u = input(self,h_r,h,z_r,z,theta)
            
            % Longitudinal Dynamics
            x_lon = zeros(2,1);
            x_lon(1) = h;
            x_lon(2) = self.derivative(h,self.h_d1,self.hdot_d1);
            
            % Integrator for longitudinal dynamics
            error_lon = h_r - h;
            errordot_lon = self.beta*self.errordot_lon_d1 + 1/self.Ts*(1-self.beta)*(error_lon - self.error_lon_d1);
            if errordot_lon < 0.5
                self.ui_lon = self.ui_lon + (self.Ts/2)*(error_lon + self.error_lon_d1);
            end
            
            F = -self.K_lon*x_lon - self.ui_lon*self.ki_lon + self.F_eq;
            
            % Lateral Dynamics
            x_lat = zeros(4,1);
            x_lat(1) = z;
            x_lat(2) = theta;
            x_lat(3) = self.derivative(z,self.z_d1,self.zdot_d1);
            x_lat(4) = self.derivative(theta,self.theta_d1,self.thetadot_d1);
            
            % integrator
            error_lat = z_r - z;
            errordot_lat = self.beta*self.errordot_lat_d1 + 1/self.Ts*(1-self.beta)*(error_lat - self.error_lat_d1);
            if errordot_lat < 0.5
                self.ui_lat = self.ui_lat + (self.Ts/2)*(error_lat + self.error_lat_d1);
            end
            
            Tau = -self.K_lat*x_lat - self.ki_lat*self.ui_lat;
            
            % Compute u
            fR = self.saturate(0.5*F + 0.5/self.d*Tau);
            fL = self.saturate(0.5*F - 0.5/self.d*Tau);
            
            u = [fL, fR];
            
            % Update old values
            self.h_d1 = x_lon(1);
            self.hdot_d1 = x_lon(2);
            
            self.z_d1 = x_lat(1);
            self.zdot_d1 = x_lat(3);
            self.theta_d1 = x_lat(2);
            self.thetadot_d1 = x_lat(4);
            
            self.errordot_lon_d1 = errordot_lon;
            self.error_lon_d1 = error_lon;
            
            self.errordot_lat_d1 = errordot_lat;
            self.error_lat_d1 = error_lat;
            
        end
        %-------------------------------------------
        function u = saturate(self,uin)
            
            if uin < self.limit(1)
                u = self.limit(1);
            elseif uin > self.limit(2)
                u = self.limit(2);
            else
                u = uin;
            end
            
        end
        %-------------------------------------------
        function ydot = derivative(self,y,y_d1,ydot_d1)
            
            ydot = self.beta*ydot_d1 + (1-self.beta)/self.Ts*(y-y_d1);
            
        end
        %-------------------------------------------
    end
end