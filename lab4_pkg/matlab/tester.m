

data = importdata('our_data/flex_160_3.csv', 5, 100); %CHANGE ALSO u LINE 68!!

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

%%%%%%%
hyperelastic_model = 1;
if hyperelastic_model == 0
    alpha = 0.009;
    gamma = 0.2;
    t = 0:(3/length(qs)):3;
    u = 160*ones(size(t));
    tau0 = 0;
    dtau0 = 0;
    tau = find_tau(u, t, alpha, gamma, tau0, dtau0);


    K = 0.075;
    D = 0.0027;
    q0 = 0;
    dq0 = 0;
    q = find_q(tau, t, K, D, q0, dq0);

    hold on
    p1 = plot(qs*180/3.14);
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
    C1 = 9.7768;
    C2 =  9.8086;
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
