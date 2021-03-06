clc

data = importdata('our_data/flex_80_0.csv', 7, 100); %CHANGE ALSO u LINE 68!!

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

% we have to generate q (also called q_m in the lab document)

qs = [];
for i = 1:length(y)
    qs = [qs, 2*atan(x(i) / y(i))];
end

% qs = qs - qs(1); %'normalizing' the values so that we start at an angle of zero


disp('Generation of q finished')

% load('all_mess.mat')

%%%%%%%
model = 0;
if model == 0
    
    %%%
    K = 55.8973;
    D = 0.4856;
    alpha = 0.3074; 
    gamma = 0.1139;
    %%%
    
    t = 0:(3/length(qs)):3;
    u = 80*ones(size(t));
    tau0 = 0;
    dtau0 = 0;
    start = cputime;
    
    tau = find_tau(u, t, alpha, gamma, tau0, dtau0);
    
    q0 = 0;
    dq0 = 0;
    q = find_q(tau, t, K, D, q0, dq0);
    cputime - start

    hold on
    p1 = plot(qs);
    p2 = plot(q);
    xlabel('timestep')
    ylabel('bend angle (radians)');
    title('Evolution of bend angle for a step input');
    hold off
    
elseif model == 1
    alpha = 0.0036 ;
    gamma = 0.0308;
    t = 0:(3/length(qs)):3;
    u = 80*ones(size(t));
    tau0 = 0;
    dtau0 = 0;
    tau = find_tau(u, t, alpha, gamma, tau0, dtau0);


    D = 0.0019;
    C1 = 0.2246 ;
    C2 =  14.5257;
      
    q0 = 0;
    dq0 = 0;
    q = find_q_hyperelastic(tau, t, C1, C2, D, q0, dq0);
    hold on
    p1 = plot(qs*180/3.14);
    p2 = plot(q);
    xlabel('timestep')
    ylabel('bend angle (radians)');
    title('Evolution of bend angle for a step input');
    hold off
else
    t = 0:(3/length(qs)):3;
    u = 80*ones(size(t));
    
    alpha = 0.3074; 
    gamma = 0.1139;
    A = 0.0180;
    
    tau0 = 0;
    dtau0 = 0;
    start = cputime;

    tau1 = find_tau(u, t, alpha, gamma, tau0, dtau0);
    
    q = A * tau1;
    
    %tau = alpha * (1 - (1+t./gamma).* exp(-t./gamma));
    cputime - start
    
    hold on
    plot(qs);
    plot(q);
    xlabel('timestep')
    ylabel('bend angle (radians)');
    title('Evolution of bend angle for a step input');
    hold off
end


