% add parameters
addpath ./..
VTOL_params

% create dynamics object
dynamics = VTOLDynamics(P);
% create signal input
VTOL_gui
% get axes handle to plot on VTOL_gui, assign to ax
% create animation object
animation = VTOLAnimation(P,ax);

% while forever
while 1
    % get input values
    % get input value from sliders on VTOL_gui, assign to f
    % propagate the dynamics based on input
    dynamics.propagateDynamics(f);
    % advance the time - unnecessary step here
    
    % update the animation
    y = dynamics.output();
    animation.drawVTOL(y);
    
end