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
P.Ts = 0.01; % time step value, seconds

% Initial values
P.zv0 = 0;
P.z_min = -5;
P.z_max = 5;

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

% Auto calculate gains based on system response params
% Comment out to manually set the gains (above)
% System response params
P.tr_h = 1;
P.wn_h = 2.2/P.tr_h;
P.zeta_h = 0.707;

P.tr_theta = 0.18;
P.wn_theta = 2.2/P.tr_theta;
P.zeta_theta = 0.707;

P.tr_z = 10*P.tr_theta;
P.wn_z = 2.2/P.tr_z;
P.zeta_z = 0.707;

% PID Gain Values
P.tau = 0.05;
P.threshold = 0.1;

P.h_gains.kP = (P.mc+2*P.mr)*(2.2/P.tr_h)^2;
P.h_gains.kD = (P.mc+2*P.mr)*(4.4*P.zeta_h/P.tr_h);
P.h_gains.kI = 0.1;

P.theta_gains.kP = (P.Jc+2*P.mr*P.d^2)*(2.2/P.tr_theta)^2;
P.theta_gains.kD = (P.Jc+2*P.mr*P.d^2)*(4.4*P.zeta_theta/P.tr_theta);

P.z_gains.kP = -1/P.g*(2.2/P.tr_z)^2;
P.z_gains.kD = 1/P.g*(P.nu/(P.mc+2*P.mr) - 4.4*P.zeta_z/P.tr_z);
P.z_gains.kI = -0.1;

%% Full-state feedback
% Lateral Dynamics
P.A_lat = [0 0 1 0;
    0 0 0 1;
    0 -P.g -P.nu/(P.mc+2*P.mr) 0;
    0 0 0 0];
P.B_lat = [0 0 0 1/(P.Jc+2*P.mr*P.d^2)]';
P.Cr_lat = [1 0 0 0];
P.D_lat = 0;

P.CC_lat = ctrb(P.A_lat,P.B_lat);

if det(P.CC_lat) == 0
    fprintf ("Lateral dynamics are not controllable\n");
else
    fprintf("Lateral dynamics are controllable\n");
end

P.lat_desired = conv([1,2*P.wn_z*P.zeta_z,P.wn_z^2],[1,2*P.wn_theta*...
    P.zeta_theta,P.wn_theta^2]);
P.p_lat = roots(P.lat_desired);

P.K_lat = place(P.A_lat,P.B_lat,P.p_lat);
P.kr_lat = -1/(P.Cr_lat*((P.A_lat - P.B_lat*P.K_lat)\P.B_lat));

% Longitudinal Dynamics
P.A_lon = [0 1;
    0 0];
P.B_lon = [0 1/(P.mc+2*P.mr)]';
P.Cr_lon = [1 0];
P.D_lon = 0;

P.CC_lon = ctrb(P.A_lon,P.B_lon);

if det(P.CC_lon) == 0
    fprintf ("Longitudinal dynamics are not controllable\n");
else
    fprintf("Longitudinal dynamics are controllable\n");
end

P.p_lon = roots([1,2*P.zeta_h*P.wn_h,P.wn_h^2]);

P.K_lon = place(P.A_lon,P.B_lon,P.p_lon);
P.kr_lon = -1/(P.Cr_lon*((P.A_lon-P.B_lon*P.K_lon)\P.B_lon));