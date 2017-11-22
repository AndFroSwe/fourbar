% Fourbar solver

% Geometric parameters
rf = 100; % Frame length [mm]
rl = 50; % Link length [mm]
rs = 60; % Shank length [mm]
rj = 40; % Jaw length [mm]

disp '*******************************************************'
disp 'Starting Four bar calculator...'
printf("Geometric parameters:\n \
    rf = %0.2f mm \n \
    rl = %0.2f mm \n \
    rs = %0.2f mm \n \
    rj = %0.2f mm \n", ...
    rf, rl, rs, rj)

% Set starting angle
input_angle = pi/3; % [rad]
printf("Input angle phi: %0.2f rad \n", input_angle)

% Solve for unknown angles
disp 'Solving unknown angles theta and alpha'
disp 'Output angle: theta'
disp 'Shank angle vs. horizontal angle: alpha'

% Use Newton Rhapson to solve non linear equations

disp 'Ending Four bar calculator...'
disp '*******************************************************'
