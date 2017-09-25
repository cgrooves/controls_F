% VTOL parameters
P.mc = 1; % kg, center mass weight
P.Jc = 0.0042; % kg m^2, inertia
P.mr = 0.25; % kg, right rotor mass
P.ml = P.mr; % kg, assumption for derivation
P.d = 0.3; % m, distance of rotor center from center mass center
P.nu = 0.1; % kg/s, drag coefficient
P.g = 9.81; % m/s^2, gravitational force

% Simulation parameters
P.t_start = 0; % start time, seconds
P.Ts = 0.1; % time step value, seconds

% Initial values
P.zv0 = 0;
P.h0 = 2;
P.theta0 = 0;
P.zvdot0 = 0;
P.hdot0 = 0;
P.thetadot0 = 0;

% Animation parameters
P.width = 0.1; % m
P.height = 0.1; % m
P.rotor_width = 0.2; % m
P.plot_length = 5;
P.plot_height = 5;

P.f_init = P.g*(P.mc+P.mr+P.ml)/2; % force necessary to keep VTOL up
P.f_max = P.f_init * 5;
P.f_min = P.f_init * -5;