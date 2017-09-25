% add parameters
addpath ./..
VTOL_params

% create dynamics object
dynamics = VTOLDynamics(P);

% create signal input
VTOL = VTOL_gui;
handles = guidata(VTOL);
ax = handles.plot1; % get axes handle to plot on VTOL_gui, assign to ax
fL = handles.fL_slider;
fR = handles.fR_slider;

% create animation object
animation = VTOLAnimation(P,ax);

% while forever
while 1
    % get input values
    f = [get(fL,'Value'); get(fR,'Value')];     % get input value from sliders on VTOL_gui, assign to f
    % propagate the dynamics based on input
    dynamics.propagateDynamics(f);
    % advance the time - unnecessary step here
    
    % update the animation
    y = dynamics.output();
    animation.drawVTOL(y);
    
end