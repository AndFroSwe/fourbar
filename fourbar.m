disp('************************************')
disp('Starting Four bar solver...')

disp('Defining helper functions...')
% Help functions
function m = f(b4)
% First order function of four bar linkage
% Parameters:
% b4: Four bar geometry struct

% Equation system with x and y components = 0
m1 = -b4.rl*cos(b4.input_a) + b4.rs*cos(b4.crosslink_a) - b4.rf + b4.rj*cos(b4.output_a);
m2 = b4.rl*sin(b4.input_a) - b4.rs*sin(b4.crosslink_a) - b4.rj*sin(b4.output_a);

% Put into vector that is returned
m = [m1; m2];

endfunction

function m = J(b4)
% Jacobian for four bar linkage geometry function
% Parameters:
% b4: Four bar geometry struct

m = [-b4.rs*sin(b4.crosslink_a), -b4.rj*sin(b4.output_a);
    -b4.rs*cos(b4.crosslink_a), -b4.rj*cos(b4.output_a)];

endfunction

function r = deg2rad(d)
% Converts degrees to radians
r = d*pi/180;

endfunction

function x = n_r_fourbar(b4)
% Newton Rhapson solver for non linear equation in four bar geometry
% Input

delta = 0.1; % Accuracy of solver
max_it = 10; % Maximum number of iterations
it = 0; % Number of done interations
x = [b4.output_a; b4.crosslink_a];
b4_temp = b4 % Temporary struct
dx = [1; 1] % Step. Dummy values

printf('Starting values: \n output_a: %0.2f rad \n crosslink_a: %0.2f rad\n', x(1), x(2))

% Solver iteration
while ((abs(dx(1)) > delta && abs(dx(2)) > delta) || it < max_it)
    % Fill temporary struct with values for x
    b4_temp.output_a = x(1);
    b4_temp.crosslink_a = x(2);

    % Calculate dx
    dx = -inv(J(b4_temp))*f(b4_temp)

    x = x + dx % Update x

    it++
end

endfunction



% ************************************** %
% Main funciton 
disp('** Executing main script... ***')
disp('Defining four bar start geometry')
% Create four bar geometry struct
% Lengths
b4.rf = 100; % Frame length
b4.rl = 60; % Link length
b4.rj = 50; % Jaw length
b4.rs = 70; % Shank length
% Angles
b4.input_a = deg2rad(180-73.93); % Input angle to system. Independent variable
b4.output_a = deg2rad(80); % Ángle between frame and jaw. Initial guess for solver
b4.crosslink_a = deg2rad(10); % Anlge between frame and shank. Initial guess for solver

% ************* Correct test values**************** %
% Use these to test program
%b4.rf = 100; % Frame length
%b4.rl = 60; % Link length
%b4.rj = 50; % Jaw length
%b4.rs = 70; % Shank length
% Angles
%b4.input_a = deg2rad(180-73.93); % Input angle to system. Independent variable
%b4.output_a = deg2rad(73.6551); % Ángle between frame and jaw. Initial guess for solver
%b4.crosslink_a = deg2rad(7.94727); % Anlge between frame and shank. Initial guess for solver

disp('************************************')
disp('Program done!')
disp('************************************')
