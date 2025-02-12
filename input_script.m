i11 = 4.250; %satellite inertia matrix elements
i22 = 4.337;
i33 = 3.664;

I_wheel = 4e-05; %Axial wheel inertia in Kgm^2

wheel_place = [0; 1; 0]; %axial wheel placement

K_nom = [0.0484; 0.0484; 0.0398]; %Nominal thruster torque in Nm

T_max_wheel = 0.002; %maximum wheel torque in Nm
  
omega_max_wheel = 527; %maximum wheel velocity in rad/sec

kx = (i22 - i33)/i11;
ky = (i11 - i33)/i22;
kz = (i22 - i11)/i33;
kappa = i22 - I_wheel;

omega_0 = 0.000281;

Ac = [0                   0        (1-kx)*omega_0   0        -8*kx*(omega_0)^2               0                                 0;
     0                    0              0          0                0            (-6*ky*i22*(omega_0)^2)/kappa                0;
     (kz - 1)*omega_0     0              0          0                0                       0                      -2*kz*omega_0^2;
     0                    0              0          0                0            (6*ky*i22*(omega_0)^2)/kappa                 0;
     1/2                  0              0          0                0                       0                                 0;
     0                   1/2             0          0                0                       0                                 0;
     0                    0             1/2         0                0                       0                                 0];
 
Bc = [1/i11   0      0        0;
        0   1/kappa  0     -1/kappa;
        0      0    1/i33     0;
        0   -1/kappa 0   i22/(kappa*I_wheel);
        0     0      0         0;
        0     0      0         0;
        0     0      0         0];


Cc = eye(size(Ac));
Dc = zeros(size(Bc));

% plantcont = ss(Ac,Bc,Cc,Dc);
% Ts = 0.1;
% plantdisc = c2d(plantcont,Ts);
% 
% Q = diag([500, 500, 500, 1e-07, 1, 1, 1]);
% R = diag([200, 200, 200, 1]);
% 
% plantdisc.InputName = {'T_1', 'T_2', 'T3', 'Tw'};
% plantdisc.OutputName = {'w1', 'w2', 'w3', 'Ww', 'e1', 'e2', 'e3'};
% plantdisc.StateName = {'w1', 'w2', 'w3', 'Ww', 'e1', 'e2', 'e3'};
% 
% mpcobj = mpc(plantdisc,0.1, 10, 3);
% 
% umin = {-0.0484; -0.0484; -0.0398; -0.0020};
% umax = {0.0484; 0.0484; 0.0398; 0.0020};
% xmin = {-1; -1; -1; -527; -1; -1; -1};
% xmax = {1; 1; 1; 527; 1; 1; 1};
% mpcobj.MV = struct('Min',umin, 'Max', umin);
% mpcobj.OutputVariables = struct('Min',xmin, 'Max', xmax);
% mpcobj.Weights.OutputVariables = Q;
% mpcobj.Weights.ManipulatedVariables = R;
% 
% x0 = [-0.05; 0.15; -0.08; 300; -0.6710; 0.1830; 0.3966];
% r = zeros(7,1);









