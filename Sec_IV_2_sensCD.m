%%% MA 493 - Topic IV.2 
%%% Compute scaled sensitivites based on centered finite difference 
%%% approximations

% Clear the workspace
clear all

% Set the final time 
tFinal = 8;

% Set the step size in the centered difference approximation (6)
h = 0.1/2;

% Create the time vector with interval size h
t = [0:h:tFinal];

% Set the nominal values of the parameters
mNom = 1;
kNom = 1;
cNom = 2.3;
ANom = 0.1;
thetaNom = [mNom,kNom,cNom,ANom];

% Set the value of the perturbation for computing scaled sensitivities
alpha = 0.1;

% Evaluate and plot the response at the nominal values
y = fOD(t,thetaNom);
figure(1)
plot(t,y);

% Calculate the scaled sensitivities via the centered difference rule (6)
s1 = 2*alpha*mNom*(fOD(t,thetaNom+[h,0,0,0])-fOD(t,thetaNom-[h,0,0,0]))/(2*h);
s2 = 2*alpha*kNom*(fOD(t,thetaNom+[0,h,0,0])-fOD(t,thetaNom-[0,h,0,0]))/(2*h);
s3 = 2*alpha*cNom*(fOD(t,thetaNom+[0,0,h,0])-fOD(t,thetaNom-[0,0,h,0]))/(2*h);
s4 = 2*alpha*ANom*(fOD(t,thetaNom+[0,0,0,h])-fOD(t,thetaNom-[0,0,0,h]))/(2*h);

% Plot the scaled sensitivities
figure(2)
subplot(2,2,1)
plot(t,s1);
title('dy/dm')
hold on
subplot(2,2,2);
plot(t,s2);
title('dy/dk')
hold on
subplot(2,2,3);
plot(t,s3);
title('dy/dc')
hold on
subplot(2,2,4);
plot(t,s4);
title('dy/dA')
hold on

% Lastly, compute the scaled sensitivity matrix at the 4 indicated 
% data points

% Here, we have 4 data points (rows) and 4 parameters (columns)
S = zeros(4,4);

% Store the time values where data is collected
tData = [2 4 6 8];

% Compute the senstivity matrix based on centered differences
S(:,1) = 2*alpha*mNom*(fOD(tData,thetaNom+[h,0,0,0])-fOD(tData,thetaNom-[h,0,0,0]))/(2*h);
S(:,2) = 2*alpha*kNom*(fOD(tData,thetaNom+[0,h,0,0])-fOD(tData,thetaNom-[0,h,0,0]))/(2*h);
S(:,3) = 2*alpha*cNom*(fOD(tData,thetaNom+[0,0,h,0])-fOD(tData,thetaNom-[0,0,h,0]))/(2*h);
S(:,4) = 2*alpha*ANom*(fOD(tData,thetaNom+[0,0,0,h])-fOD(tData,thetaNom-[0,0,0,h]))/(2*h);

S