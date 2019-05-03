clear all
close all
clc

%% Package paths

cur = pwd;
addpath( genpath( [cur, '/gen/' ] ));


%% 

clear all
close all
clc

%% Load CSV


data = importdata('../data/sys_id/flex_80_0.csv', 2, 100);

u = data.left_pwm;
t = data.time;

x = data.tip_pos_x - data.base_pos_x;
y = data.tip_pos_y - data.base_pos_y;
% they maybe need some filtering...

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

hyperelastic = 0;
if hyperelastic == 0
    cost = @(x) cost_function(x(1), x(2), x(3), x(4), t, u, q, q0, dq0, tau0, dtau0);
    %X0 = [2.6, 0.5, 0.31, 0.6];
    X0 = [0.075, 0.0027, 0.009, 0.2];
    [X, resnorm] = lsqnonlin(cost, X0)
else
    D = 0.027;
    alpha = 0.095;
    gamma = 0.27;
    cost = @(x) cost_function_hyperelastic(x(1), x(2), D, alpha, gamma, t, u, q, q0, dq0, tau0, dtau0);
    X0 = [2, 2]; %C1, C2
    % IDEA: we can maybe reduce the number of variables by hardcoding the
    % ones found with the other model
    [X, resnorm] = lsqnonlin(cost, X0, [0,0], [Inf, Inf])
end



disp('Solving the non linear least squares')



%%%%%%%%%%%%%
