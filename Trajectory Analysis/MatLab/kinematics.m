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
alpha = 3.5:0.5:7.5;

%alpha = 6.5;
XX = sprintf ('@ Alpha = ');
disp(XX)
disp(alpha)

cL = (sailCart.cLa*alpha + sailCart.cL0 );
cD = sailCart.cD0 + sailCart.k*cL.^2;

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

q = .5*rhoATM*sailCart.area*(vWind + vx ).^2;
Lift = cL .* q;
Drag = cD .* q;

theta = alpha + .5 * atan(Lift./Drag) * (180/pi);
beta = (theta + alpha) * pi/180;

ax = (1/sailCart.totalMass) * (.5 * Lift .* sin(2 * beta) - .5 * Drag.* ( 1 + cos(2 * beta)) - rollingFriction * cos(beta));
ay = ax .* tan (beta);

xCart = xCart + vx * dt;
yCart = yCart + vy * dt;

t = t + dt;
% if t>5
%     YY = sprintf ('Alpha = %d is no good;  ',alpha);
% disp(YY)
%     break
% end

TT =sprintf ('@Time  = %d; x_Acceleration = ',t);
disp (TT)
disp(ax)

end

sailCart.vFinal = vx;

[maxValue,maxIndex] = max(vx);
vxMax = vx(maxIndex);
alphaMax = alpha(maxIndex);
disp(XX)
disp(alpha)
FF = sprintf ('Final x_Velocity @ Tack 0: ');
disp (FF)
disp(vx)
sailCart.xFinal = xCart;
sailCart.timeFinal = t;
sailCart.totalTime = (trackLength./sailCart.xFinal)*sailCart.timeFinal;

DD= sprintf ('Max Velocity of %d occurs @ Alpha =',vxMax);
display(DD)
alphaMax
disp('Andrew Da Chump')