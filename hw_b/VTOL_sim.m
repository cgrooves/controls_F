% clear
clear; close; clc;

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

% set slider values
set(fR,'Min',P.f_min,'Max',P.f_max,'Value',P.f_init)
set(fL,'Min',P.f_min,'Max',P.f_max,'Value',P.f_init)

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
    
    % reset VTOL if it falls too far
    if y(2) < -10
        dynamics.reset();
        set(fR,'Value',P.f_init);
        set(fL,'Value',P.f_init);
    end

    animation.drawVTOL(y);
    
    pause(0.08);
    
end