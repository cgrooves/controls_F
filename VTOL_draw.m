% VTOL param's
classdef VTOL
    
    properties(Access = private)
        mc = 1;
        Jc = 0.0042;
        mr = 0.25;
        ml = 0.25;
        d = 0.3;
        nu = 0.1;
        g = 9.81;

        box = Rectangle(0.1,0.1,[0;0]);
        rotor_r = Ellipse(0.1,0.05,[d; 0],20);
        rotor_l = Ellipse(0.1,0.05,[-d;0],20);
        
        mAx;
    end
    
    methods (Access = public)
        
        function obj = VTOL(ax)
            obj.mAx = ax;
        end
        
        function VRotate(obj,angle)
           obj.box.rotate(angle,obj.mAx);
           obj.rotor_r.rotate(angle,obj.mAx);
           obj.rotor_l.rotate(angle,obj.mAx);
        end
        
    end
    
end
