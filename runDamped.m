% MA 493 - Mathematical Foundations of Data Science - Mansoor Haider
%
% runDamped.m
%
% Main routine to run the model for damped oscillatory motion

% Set the nominal parameter values
mNom = 1;
cNom = 2.3;
kNom = 1;
ANom = 0.1;

% Specify the final time and the time interval and spacing
tFinal = 8;
dt = tFinal/100;
t = [0;dt;tFinal];

% Use ode45 to solve our system of ODEs where:
% t is the vector of time values 
% y is the vector of solutions at the time points in t

% Specify the paramater values (passed to the ODE solver)
p(1) = mNom;
p(2) = cNom;
p(3) = kNom;

% Set options on for the ode solver
options = odeset('AbsTol',1e-9, 'RelTol', 1e-8); 

% Specify the model to be solved - see below for function definition
modelRHS = @(t,y)(Damped(t,y,p));

% Solve the ODE system, numerically, using "ode45"
[t,y] = ode45(modelRHS, [0 tFinal], [ANom 0], options);

% Extract the relevant solutions
disp = y(:,1);
vel = y(:,2);

% Plot the solutions
figure(1)
plot(t,disp, 'LineWidth', 3)
title('Displacement')
set(gca, 'FontSize', 18)

figure(2)
plot(t,vel, 'LineWidth', 3)
title('Velocity')
set(gca, 'FontSize', 18)

% Functon "Damped"
%
% Implements ODE model for damped oscillatory motion of a
% mass-spring-dashpot system

% Inputs:
%   t - time
%   y - state variables (displacement and velocity)
%   p - vector of model parameters [m c k]
% Output:
%   dy/dt 

function dy = Damped(t, y, p)
  dy = [0; 0];
  m = p(1);
  c = p(2);
  k = p(3);

  dy(1) = y(2);
  dy(2) = -k/m * y(1) - c/m * y(2);

end
