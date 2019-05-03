

data = importdata('our_data/flex_80_1.csv', 5, 100); %CHANGE ALSO u LINE 68!!

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
%     syms q1;
%     syms q2;
%     
%     % Using the equation: y = L * (1-cos(q))/q)
%     % q1 = vpasolve(y(i) == L*(1-cos(q1))/q1, q1, [0, 3.14/2]);
%     q1 = vpasolve(x(i) == L*(1-cos(q1))/q1, q1,[-0.1, 3.14/2] );
%     q1size = size(q1);
%         
%     q2 = vpasolve(x(i) == L*(sin(q2))/q2, q2,[-0.1, 3.14/2] );
%     q2size = size(q1);
%     
%     if (q1size(1) == 1) 
%         qs = [qs, double(q1)];
%     else
%         qs = [qs, qs(end)];
%         disp('WARNING: Solver could not find q...');
%     end
    qs = [qs, 2*atan(x(i) / y(i))];
end

% qs = qs - qs(1); %'normalizing' the values so that we start at an angle of zero


disp('Generation of q finished')

% load('all_mess.mat')

%%%%%%%
hyperelastic_model = 0;
if hyperelastic_model == 0
    
    %%%
    K = 0.6446;
    D = 0.0040;
    alpha = 0.0030;
    gamma = 0.0109;
    %%%
                            
    
    
    %alpha = 0.009;
    %gamma = 0.2;
    t = 0:(3/length(qs)):3;
    u = 80*ones(size(t));
    tau0 = 0;
    dtau0 = 0;
    tau = find_tau(u, t, alpha, gamma, tau0, dtau0);
    
    q0 = 0;
    dq0 = 0;
    q = find_q(tau, t, K, D, q0, dq0);
    


    hold on
    p1 = plot(qs);
    p2 = plot(q);
    xlabel('timestep')
    ylabel('bend angle (degrees)');
    title('Evolution of bend angle for a step input');
    hold off
else
    alpha = 0.009;
    gamma = 0.27;
    t = 0:(3/length(qs)):3;
    u = 160*ones(size(t));
    tau0 = 0;
    dtau0 = 0;
    tau = find_tau(u, t, alpha, gamma, tau0, dtau0);


    D = 0.0027;
    C1 = 0.11;
    C2 =  0.02;
    q0 = 0;
    dq0 = 0;
    q = find_q_hyperelastic(tau, t, C1, C2, D, q0, dq0);

    hold on
    p1 = plot(qs*180/3.14);
    p2 = plot(q);
    xlabel('timestep')
    ylabel('bend angle (degrees)');
    title('Evolution of bend angle for a step input');
    hold off
end
