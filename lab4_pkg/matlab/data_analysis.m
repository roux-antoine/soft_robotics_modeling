clear all
close all
clc

%% Package paths

cur = pwd;
addpath( genpath( [cur, '/gen/' ] ));

%% Load CSV


data = importdata('../data/sys_id/flex_200_3.csv', 2, 95);

u = data.left_pwm;
t = data.time;

x = data.tip_pos_x - data.base_pos_x;
y = data.tip_pos_y - data.base_pos_y;
pressure = data.left_pressure - min(data.left_pressure);

hold on
plot(t,x);
plot(t,y);
legend('x', 'y')
hold off

%% Generate q(t)

% we have to generate q (also called q_m in the lab document)

qs = [];
for i = 1:length(y)
    qs = [qs, 2*atan(x(i) / y(i))];
end

%qs = qs - qs(1); %'normalizing' the values so that we start at an angle of zero

disp('Generation of q finished')


hold on
plot(t, qs*180/3.14)
hold off



%% do your regression

% x = K, D, alpha, gamma
q = qs;
q0 = q(1);
dq0 = 0;
tau0 = 0;  % according to the documentation of find_tau
dtau0 = 0; % according to the documentation of find_tau

model = 1;
if model == 0 % ie the classical model
    
    alpha = 0.3074; 
    gamma = 0.1139;
    
    % cost = @(x) cost_function(x(1), x(2), x(3), x(4), t, u, q, q0, dq0, tau0, dtau0);
    cost = @(x) cost_function(x(1), x(2), alpha, gamma, t, u, q, q0, dq0, tau0, dtau0);
    
    X0 = [55,  0.5];
    [X, resnorm] = lsqnonlin(cost, X0) % K, D, alpha, gamma
elseif model == 1 %ie hyperelastic
    D = 0.4856;
    alpha = 0.3074; 
    gamma = 0.1139;
    cost = @(x) cost_function_hyperelastic(x(1), x(2), D, alpha, gamma, t, u, q, q0, dq0, tau0, dtau0);
    X0 = [0.11, 0.02]; %C1, C2
    [X, resnorm] = lsqnonlin(cost, X0, [0,0], [Inf, Inf])
else
    cost = @(x) cost_function_proportional(x(1), x(2), t, u, tau0, dtau0, pressure);
    X0 = [2, 2]; %alpha, gamma
    [X, resnorm] = lsqnonlin(cost, X0, [0,0], [Inf, Inf])
end


%% try to fit a second order model for the pressure



disp('Solved the non linear least squares')



%%%%%%%%%%%%%
