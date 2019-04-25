
alpha = 0.07;
gamma = 0.15;
t = 0:0.01:3;
u = 150*ones(size(t));
tau0 = 0;
dtau0 = 0;
tau = find_tau(u, t, alpha, gamma, tau0, dtau0);


K = 0.07;
D = 0.020;
q0 = 0;
dq0 = 0;
q = find_q(tau, t, K, D, q0, dq0);

plot(t,q)
