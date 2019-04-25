clear all
close all
clc

%% Package paths

cur = pwd;
addpath( genpath( [cur, '/gen/' ] ));

% %% testing with generated data
% % Note the values used are totally made up and shouldn't be used as
% % starting points for your actual analysis
% 
% alpha = 0.1;
% gamma = 0.5;
% t = 0:0.01:2;
% u = 150*ones(size(t));
% tau0 = 0;
% dtau0 = 0;
% tau = find_tau(u, t, alpha, gamma, tau0, dtau0);
% 
% K = 3;
% D = 0.4;
% q0 = 0;
% dq0 = 0;
% q = find_q(tau, t, K, D, q0, dq0);
% 
% 
% % x = K, D, alpha, gamma
% 
% cost = @(x) cost_function(x(1), x(2), x(3), x(4), t, u, q, q0, dq0, tau0, dtau0);
% 
% 
% [X, resnorm] = lsqnonlin(cost, [2.6, 0.5, 0.31, 0.6])
% % [X, resnorm] = lsqnonlin(cost, [K, D, alpha, gamma])


%% 

clear all
close all
clc

%% Load CSV

data = importdata('our_data/flex_160_3.csv', 5, 100);

u = data.left_pwm; %or maybe right
t = data.time;

x = data.tip_pos_x - data.base_pos_x;
y = data.tip_pos_y - data.base_pos_y;
% they probably need some filtering...


% plot(t,x);
% plot(t,y);


%% Generate q(t)

% we have to generate q (also called q_m in the lab document)
% do some trigonometry using x and y and other stuff

L = 251; %seems like the correct value
qs = [];
q1s = [];
q2s = [];
for i = 1:length(y)
    i
    syms q1;
    % Using the equation: y = L * (1-cos(q))/q)
    q1 = vpasolve(y(i) == L*(1-cos(q1))/q1, q1, [0, 3.14/2]);
    
    syms q2;
    % Using the equation: x = L * sin(q)/q
    q2 = vpasolve(y(i) == L*sin(q2)/q2, q2, [0, 3.14/2]);
    
    q = 0;
    q1size = size(q1);
    q2size = size(q2);
    
    if (q1size(1) == 1) && (q2size(1) == 1)
        q = (q1 + q2) / 2;
    elseif q1size(1) == 1
        q = q1;
    elseif q2size(1) == 1
        q = q2;
    else
        q = qs(end);
        disp('Something went wrong');
    end
    qs = [qs, q];
end

save('all_mess.mat')

disp('Generation of q finished')

% load('all_mess.mat')

qs = double(qs); % had to add that to get the ode45 to work in later stages

plot(t, qs*180/3.14)



%% do your regression

% x = K, D, alpha, gamma
q = qs;
q0 = q(1);
dq0 = 0;
tau0 = 0;  % according to the documentation of find_tau
dtau0 = 0; % according to the documentation of find_tau

cost = @(x) cost_function(x(1), x(2), x(3), x(4), t, u, q, q0, dq0, tau0, dtau0);

disp('Solving the non linear least squares')

X0 = [2.6, 0.5, 0.31, 0.6];
[X, resnorm] = lsqnonlin(cost, X0)
% [X, resnorm] = lsqnonlin(cost, [K, D, alpha, gamma])


%%%%%%%%%%%%%
