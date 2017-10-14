classdef PlotVTOLData < handle
    
    properties
        t
        h
        z
        fL
        fR
        Ts
        
        fL_plot
        fR_plot
        
        fL_line
        fR_line
        
        h_plot
        z_plot
        
        h_handle
        z_handle
        
    end
    
    methods
        %-----------------
        function self = PlotVTOLData(P)
            
            self.t = 0;
            self.h = P.h0;
            self.z = P.zv0;
            self.fL = P.f_init;
            self.fR = P.f_init;
            self.Ts = P.Ts;
            
            % create subplots
            figure(2), clf
            self.fL_plot = subplot(4,1,1);
                hold(self.fL_plot,'on')
                self.fL_line = plot(self.fL_plot,self.t,self.fL,'r');
                xlabel('Time (s)');
                ylabel('Force (N)');
                title('Left Rotor Force');
                
            self.fR_plot = subplot(4,1,2);
                hold(self.fR_plot,'on')
                self.fR_line = plot(self.fR_plot,self.t,self.fR,'r');
                xlabel('Time (s)');
                ylabel('Force (N)');
                title('Right Rotor Force');
                
            self.h_plot = subplot(4,1,3);
                hold(self.h_plot,'on')
                self.h_handle = plot(self.h_plot,self.t,self.h);
                xlabel('Time (s)');
                ylabel('Height (m)');
                title('VTOL Height');
                
             self.z_plot = subplot(4,1,4);
                hold(self.z_plot,'on')
                self.z_handle = plot(self.z_plot,self.t,self.z);
                xlabel('Time (s)');
                ylabel('Lateral Position (m)');
                title('VTOL Lateral Position');
                   
        end
        %-----------------
        function update(self,f,y)
            % extract data
            fL = f(1);
            fR = f(2);
            
            h = y(2);
            z = y(1);
            
            % Add on to t, y, u data
            if size(self.t) == [0 0]
                self.t = cat(2,self.t,self.Ts);
            else
                self.t = cat(2,self.t,self.t(end)+self.Ts);
            end

            self.h = cat(2,self.h,h);
            self.z = cat(2,self.z,z);
            self.fL = cat(2,self.fL,fL);
            self.fR = cat(2,self.fR,fR);
            
            % Update plots
            set(self.h_handle,'Xdata',self.t,'Ydata',self.h);
            set(self.z_handle,'Xdata',self.t,'Ydata',self.z);
            set(self.fL_line,'Xdata',self.t,'Ydata',self.fL);
            set(self.fR_line,'Xdata',self.t,'Ydata',self.fR);            
        end
        %-----------------
        
    end
    
end