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

m = [-b4.rj*sin(b4.output_a), -b4.rs*sin(b4.crosslink_a);
    -b4.rj*cos(b4.output_a), -b4.rs*cos(b4.crosslink_a)];

endfunction

function r = deg2rad(d)
% Converts degrees to radians
r = d*pi/180;

endfunction

function d = rad2deg(r)
% Converts radians to degrees
d = r*180/pi;

endfunction

function x = n_r_fourbar(b4)
% Newton Rhapson solver for non linear equation in four bar geometry
% Input

delta = 0.001; % Accuracy of solver
max_it = 10; % Maximum number of iterations
it = 0; % Number of done interations
x = [b4.output_a; b4.crosslink_a];
b4_temp = b4; % Temporary struct
dx = [1; 1]; % Step. Dummy values

%printf('Starting values: \n output_a: %0.2f rad \n crosslink_a: %0.2f rad\n', x(1), x(2))

% Solver iteration
while ((sqrt(dx(1)^2 + dx(2)^2) > delta) && it < max_it)
    % Fill temporary struct with values for x
    %printf('*** Loop %d ***\n', it);
    b4_temp.output_a = x(1);
    b4_temp.crosslink_a = x(2);

    % Calculate dx
    dx = -inv(J(b4_temp))*f(b4_temp);
    %printf('x0 = [%0.2f, %0.2f] degrees\n', rad2deg(x(1)), rad2deg(x(2)))
    %printf('dx = [%0.2f, %0.2f] degrees\n', rad2deg(dx(1)), rad2deg(dx(2)))

    x = x + dx; % Update x

    %printf('x1 = [%0.2f, %0.2f] degrees\n', rad2deg(x(1)), rad2deg(x(2)))

    %disp('----------------------------------')
    it++;
end

endfunction



% ************************************** %
% Main funciton 
disp('** Executing main script... ***')
disp('Defining four bar start geometry')
% Create four bar geometry struct
% Lengths
b4.rf = 75.7; % Frame length
b4.rl = 55.5; % Link length
b4.rj = 24.26; % Jaw length
b4.rs = 15.5; % Shank length
% Angles
b4.input_a = deg2rad(100); % Input angle to system. Independent variable
b4.output_a = deg2rad(80); % Ángle between frame and jaw. Initial guess for solver
b4.crosslink_a = deg2rad(10); % Anlge between frame and shank. Initial guess for solver

% ************* Correct test values**************** %
% Use these to test program
%b4.rf = 100; % Frame length
%b4.rl = 60; % Link length
%b4.rj = 50; % Jaw length
%b4.rs = 70; % Shank length
% Angles
%b4.input_a = deg2rad(180-70); % Input angle to system. Independent variable
%b4.output_a = deg2rad(78.61); % Angle between frame and jaw. Initial guess for solver
%b4.crosslink_a = deg2rad(6.04); % Anlge between frame and shank. Initial guess for solver

disp('Calculating and plotting positions')
input_min = deg2rad(150)
input_max = deg2rad(160)

hf = figure('visible', 'off');
axis([-10 110 -100 10])
axis manual

angles = input_min:0.005:input_max;
for ii = 1:length(angles) % Ugly quick fix
    printf('Plotting %d/%d\n', ii, length(angles))
    i = angles(ii); % Ugly quick fix
    axis([-10 110 -100 10])
    axis manual
    % Get angles 
    b4.input_a = i;
    a = n_r_fourbar(b4);
    b4.output_a = a(1); % Update output angle
    b4.crosslink_a = a(2); % Update crosslink angle

    % Plot results
    hold on
    % Plot frame
    plot([0, b4.rf], [0, 0])
    % Plot link
    plot([0, -cos(b4.input_a)*b4.rl], [0, -sin(b4.input_a)*b4.rl])
    % Plot shank
    plot([-cos(b4.input_a)*b4.rl, -cos(b4.input_a)*b4.rl + cos(b4.crosslink_a)*b4.rs], [-sin(b4.input_a)*b4.rl, -sin(b4.input_a)*b4.rl + sin(b4.crosslink_a)*b4.rs])
    % Plot jaw
    plot([b4.rf - cos(b4.output_a)*b4.rj, b4.rf], [-sin(b4.output_a)*b4.rj, 0])

    pause(0.001)
    drawnow

    plname = sprintf('./images/fourbar%d.png', ii);
    print(hf, plname, "-dpng")

    hold off 
    plot([1])


endfor

disp('************************************')
disp('Program done!')
disp('************************************')
