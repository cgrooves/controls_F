% VTOL parameters
P.mc = 1; % kg, center mass weight
P.Jc = 0.0042; % kg m^2, inertia
P.mr = 0.25; % kg, right rotor mass
P.ml = P.mr; % kg, assumption for derivation
P.d = 0.3; % m, distance of rotor center from center mass center
P.nu = 0.1; % kg/s, drag coefficient
P.g = 9.81; % m/s^2, gravitational force

P.var = 0.2; % uncertainty parameter, affects mc, Jc, d, and nu

% Simulation parameters
P.t_start = 0; % start time, seconds
P.Ts = 0.05; % time step value, seconds

% Initial values
P.zv0 = 0;
P.z_min = -3;
P.z_max = 4;

P.h0 = 5;
P.h_min = 0;
P.h_max = 10;

P.theta0 = 0;

P.zvdot0 = 0;
P.hdot0 = 0;
P.thetadot0 = 0;

% Animation parameters
P.width = 0.15; % m
P.height = 0.15; % m
P.rotor_height = 0.05; % m
P.rotor_width = 0.15; % m
P.plot_length = 2*P.z_max;
P.plot_height = P.h_max;

P.f_init = P.g*(P.mc+P.mr+P.ml)/2; % force necessary to keep VTOL up
P.f_max = P.f_init * 5;
P.f_min = P.f_init * -5;

% target stuff
P.target_b = 0.1;
P.target_h = 0.15;

% Control parameters-----------------------------
P.sat_limit = [0,10];

% Manual gain values
% P.kp_h = 0.1134;
% P.kd_h = 0.5833;

% Auto calculate gains based on system response params
% Comment out to manually set the gains (above)
% System response params
P.tr_h = 1;
P.zeta_h = 0.707;

P.tr_theta = 0.8;
P.zeta_theta = 0.707;

P.tr_z = 10*P.tr_theta;
P.zeta_z = 0.707;

% Gain Values
P.kp_h = (P.mc+2*P.mr)*(2.2/P.tr_h)^2;
P.kd_h = (P.mc+2*P.mr)*(4.4*P.zeta_h/P.tr_h);

P.kp_theta = (P.Jc + 2*P.mr*P.d^2)*(2.2/P.tr_theta)^2;
P.kd_theta = (P.Jc + 2*P.mr*P.d^2)*4.4*P.zeta_theta/P.tr_theta;

P.kp_z = -1/P.g*(2.2/P.tr_z)^2;
P.kd_z = 1/P.g*(P.nu/(P.mc+2*P.mr) - 4.4*P.zeta_z/P.tr_z);