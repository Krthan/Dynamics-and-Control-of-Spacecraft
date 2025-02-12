% Discrete-time simulation
[Ad, Bd] = c2d(Ac, Bc, 0.1); %discritization
Q = diag([500, 500, 500, 1e-02, 1, 1, 1]); %output weights
R = diag([200, 200, 200, 1]); %input weights
[P_lqr, K_lqr, L] = idare(Ad, Bd, Q, R); %Idare function to solve the ARE and produce Qp and K
N = 2500; % Number of time steps
x = zeros(size(Ad, 1), N); % Preallocate state array
u = zeros(size(Bd,2), N); %Preallocate input array
x0 = [-0.05; 0.15; -0.08; 300; -0.4777; 0.2126; 0.6744]; %initial conditions
x(:, 1) = x0; 

for k = 1:N-1
    u(:,k) = -K * x(:, k); % Control input
    x(:, k+1) = (Ad - Bd * K) * x(:, k); % State update
end

% Plot the results
time = 0:N-1; % Time steps
plot(time, x(1:3,:));
xlabel('Time step');
ylabel('State');
title('State Trajectories with LQR Control (Discrete)');
legend('\omega_1', '\omega_2', '\omega_3');

%%
figure()
plot(1:100, x(4,1:100));
xlabel('Time step');
ylabel('State');
title('State Trajectories with LQR Control (Discrete)');
legend('w_w');


%% finding eta
eta = zeros(1, N);
for i = 1 : N
    eta(i) = sqrt(1 - x(5:7,i)' * x(5:7,i));
end

%% converting quaternions to eulerangles
quats = vertcat(eta,x(5:7,:));

for i = 1:N
   eulerangles_in_rad = quat2eul(quats(:,i)'); 
   euler_deg(:,i) = rad2deg(eulerangles_in_rad);
end

figure()
plot(time, euler_deg)
xlabel('Time');
ylabel('Euler angles');

%% Plotting the inputs
figure()
plot(1:200, u(:,1:200))
xlabel('Time')
ylabel('Inputs')
legend('\tau_1', '\tau_2', '\tau_3', '\tau_w')
