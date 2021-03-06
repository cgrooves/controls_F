classdef VTOLDynamics < handle
    
    properties
       state
       mc
       Jc
       ml
       mr
       d
       nu
       g
       Ts
       initials
       var
       
    end
    
    methods
        % Constructor -----------------------------------------------
        function self = VTOLDynamics(P)
            
            % Initialize state vector with initial values
            self.state = [...
                P.zv0;...
                P.zvdot0;...
                P.h0;...
                P.hdot0;...
                P.theta0;...
                P.thetadot0;...
                ];
            self.initials = self.state; % store initial values
            
            % Initialize other simulation parameters
            % introduce +- 20% uncertainty in some params
            self.var = P.var;
            
            self.mc = P.mc*((2*self.var)*rand + (1-self.var));
            self.Jc = P.Jc*((2*self.var)*rand + (1-self.var));
            self.d = P.d*((2*self.var)*rand + (1-self.var));
            self.nu = P.nu*((2*self.var)*rand + (1-self.var));
            
            self.ml = P.ml;
            self.mr = P.mr;
            
            self.g = P.g;
            self.Ts = P.Ts; % system time step
        end
        % --------------------------------------------------------------
        function self = propagateDynamics(self,u)
            %
            % Integrate the differential equations defining dynamics by
            % using Runga-Kutta 4th order methods.
            % u is the system inputs (fL, fR)
            
            k1 = self.derivatives(self.state, u);
            k2 = self.derivatives(self.state + self.Ts/2*k1, u);
            k3 = self.derivatives(self.state + self.Ts/2*k2, u);
            k4 = self.derivatives(self.state + self.Ts*k3, u);
            self.state = self.state + self.Ts/6 * (k1 + 2*k2 + 2*k3 + k4);
            
            % constrain against ground
            if self.state(3) < 0
                self.state(3) = 0;
                self.state(4) = 0;
            end
            
        end
        % ---------------------------------------------------------------
        function xdot = derivatives(self, state, u)
           %
           % Return xdot = f(x,u) the derivatives of the continuous states
           % as a matrix
           fL = u(1);
           fR = u(2);
           
           % Equations of motion!!!
           xdot = zeros(6,1);
           
           F_wind = 0.1;
           
           xdot(1) = state(2);
           xdot(2) = 1/(self.mc + 2*self.mr)*(-(fL+fR)*sin(state(5)) - self.nu*state(2))+F_wind;
           xdot(3) = state(4);
           xdot(4) = 1/(self.mc + 2*self.mr)*((fL+fR)*cos(state(5)) - self.g*(self.mc + 2*self.mr));
           xdot(5) = state(6);
           xdot(6) = 1/(self.Jc + 2*self.mr * (self.d)^2)*(fR - fL)*self.d;
           
        end
        % -----------------------------------------------------------------
        function y = output(self)
            % Return the system variables as a column vector
            zv = self.state(1);
            h = self.state(3);
            theta = self.state(5);
            
            y = [zv; h; theta];
            
        end
        % -----------------------------------------------------------------
        function self = reset(self)
            % Reset to initial values
            self.state = self.initials;
        end
        % -----------------------------------------------------------------
    end       
    
end
