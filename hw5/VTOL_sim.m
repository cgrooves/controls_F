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
z_slider = handles.slider2;
h_slider = handles.slider1;

% set slider values
set(z_slider,'Min',P.z_min,'Max',P.z_max,'Value',P.zv0)
set(h_slider,'Min',P.h_min,'Max',P.h_max,'Value',P.h0)

% create animation object
animation = VTOLAnimation(P,ax);

% create VTOL controller
controller = VTOLControl(P);

% create target object animation
target = Rectangle(P.target_b, P.target_h, [0; P.target_h/2],ax);

% initialize y
y = dynamics.output();

% make output plot object
plt = PlotVTOLData(P);

% while forever
while isgraphics(VTOL)
    % get input values
    z_ref = get(z_slider,'Value');
    h_ref = get(h_slider,'Value');
    
    % get force from controller
    f = controller.u(h_ref,y(2));
    
    % propagate the dynamics based on input
    dynamics.propagateDynamics(f);

    % update the animation
    y = dynamics.output();
    animation.drawVTOL(y);
    
    % update plot
    plt.update(f,y);
    
    pause(P.Ts);
    
end