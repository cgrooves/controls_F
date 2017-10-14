classdef DynamicPlotData < handle
    
    properties
        t
        y
        u
        Ts
        
        input_handle
        output_handle
        input_graph_handle
        output_graph_handle
        
    end
    
    methods
        %-----------------
        function self = DynamicPlotData(P,input_label,output_label)
            
            self.t = 0;
            self.y = 0;
            self.u = 0;
            self.Ts = P.Ts;
            
            % create subplots
            figure(2), clf
            self.input_handle = subplot(2,1,1);
                hold(self.input_handle,'on')
                self.input_graph_handle = plot(self.input_handle,self.t,self.u,'r');
                xlabel('Time (s)');
                ylabel(input_label);
                title('Input');
                
            self.output_handle = subplot(2,1,2);
                hold(self.output_handle,'on')
                self.output_graph_handle = plot(self.output_handle,self.t,self.y);
                xlabel('Time (s)');
                ylabel(output_label);
                title('Output');                
                   
        end
        %-----------------
        function update(self,u,y)
            % Add on to t, y, u data
            if size(self.t) == [0 0]
                self.t = cat(2,self.t,self.Ts);
            else
                self.t = cat(2,self.t,self.t(end)+self.Ts);
            end
%            self.t = [self.t self.t(end)+self.Ts];
%             self.y = [self.y y];
%             self.u = [self.u u];
            self.y = cat(2,self.y,y);
            self.u = cat(2,self.u,u);
            

            % Update plots
            set(self.input_graph_handle,'Xdata',self.t,'Ydata',self.u);
            set(self.output_graph_handle,'Xdata',self.t,'Ydata',self.y);

            
        end
        %-----------------
        
    end
    
end