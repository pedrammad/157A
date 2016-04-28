clc;
clear all;

alpha = 11;
dt = .2;
cL = 2.6;
cD = .2;
vCart = 0;
ax = 0;
xCart = 0;
t = 0;
i = 1;
while xCart < 4.1;
vCart = vCart + ax*dt;
q = .5*1.225*.16*(6 + vCart )^2;
Lift = cL * q;
Drag = cD * q;
theta = alpha + .5 * atan(Lift/Drag) * (180/pi);
beta = (theta + alpha) * pi/180;
ax = (1/.7) * (.5 * Lift * sin(2 * beta) - .5 * Drag * ( 1 + cos(2 * beta)) - .03*9.81*.7 * cos(beta));
xCart = xCart + vCart * dt;
end

plot(t,v)