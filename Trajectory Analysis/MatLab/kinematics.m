function [sailCart] = kinematics(sailCart)

global trackWidth;
global trackLength;
global rhoATM;
global vWind;

% Rolling friction found through experiment
rollingFriction = .03 * sailCart.totalMass * 9.81;

% Time incriment 
dt = .2;

% loop through alpha, calculate vf 
%for alpha = 0:.5:7.5;

alpha = 7.5;
cL = (sailCart.cLa*alpha + sailCart.cL0 );
cD = sailCart.cD0 + sailCart.k*cL^2;

vx = 0;
vy = 0;

ax = 0;
ay = 0;

xCart = 0;
yCart = 0;

t = 0;

while yCart < trackWidth - sailCart.wAxle;
    
vx = vx + ax * dt;
vy = vy + ay * dt;

q = .5*rhoATM*sailCart.area*(vWind + vx )^2;
Lift = cL * q;
Drag = cD * q;

theta = alpha + .5 * atan(Lift/Drag) * (180/pi);
beta = (theta + alpha) * pi/180;

ax = (1/sailCart.totalMass) * (.5 * Lift * sin(2 * beta) - .5 * Drag * ( 1 + cos(2 * beta)) - rollingFriction * cos(beta));
ay = ax * tan (beta);

xCart = xCart + vx * dt;
yCart = yCart + vy * dt;
disp(ax)
t = t + dt;
end

sailCart.vFinal = vx;
sailCart.xFinal = xCart;
sailCart.timeFinal = t;
sailCart.totalTime = (trackLength/sailCart.xFinal)*sailCart.timeFinal;
disp('Andrew')