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

file_prefix = '../data/calibration/flex_120';
input_file = [file_prefix, '.csv'];
data = importdata(input_file, 2, 100);

u = data.left_pwm;
t = data.time;

x = data.tip_pos_x - data.base_pos_x;
y = data.tip_pos_y - data.base_pos_y;
% they maybe need some filtering...

%% Generate q(t)

% we have to generate q (also called q_m in the lab document)

qs = [];
for i = 1:length(y)
    qs = [qs, 2*atan(x(i) / y(i))];
end

%qs = qs - qs(1); %'normalizing' the values so that we start at an angle of zero

disp('Generation of q finished')


%% Save to csv somehow

M = table2array(data);
data_array = [M, qs'];
header={'index', 'time', 'left_pwm', 'right_pwm', 'left_pressure', 'right_pressure', 'left_flex', 'right_flex', 'base_pos_x', 'base_pos_y', 'tip_pos_x', 'tip_pos_y', 'q'};
data_table = array2table(data_array, 'VariableNames', header);

output_file = [file_prefix, '_q.csv'];
writetable(data_table, output_file);
fprintf("wrote to file %s\n", output_file);