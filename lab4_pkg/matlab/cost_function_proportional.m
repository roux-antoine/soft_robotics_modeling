function [error] = cost_function_proportional(alpha, gamma, t, u, tau0, dtau0, tau_measured)
%cost_function Cost function to be minimized in the linear regression
%   K is the stiffness (linear elastic model)
%   D is the damping
%   alpha is the input gain
%   gamma is the input inertia
%   t is a vector of timesteps when data was collected
%   u is a vector of pwm inputs (with the same dimension as t)
%   q is a vector of angle measurements (with the same dimenstion as t)
%   q0 is the initial angle (probably zero)
%   dq0 is the initial angular velocity (probably zero)
%   tau0 is the initial torque (probably zero)
%   dtau0 is the initial jerk (probably zero)

% Integrate to find tau as a function of time
tau_hat = find_tau(u, t, alpha, gamma, tau0, dtau0);

error = tau_hat - tau_measured;

end
