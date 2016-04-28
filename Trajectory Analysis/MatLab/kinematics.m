function [sailCart] = kinematics(sailCart)

global trackWidth;
global trackLength;
global rhoATM;
global vWind;

% Rolling friction found through experiment
rollingFriction = .03 * sailCart.totalMass * 9.81;

% Time incriment 
dt = .01;

% loop through alpha, calculate vf 

startAlpha = 3.5;
stallAlpha = 7.5;
alpha = startAlpha:0.5:stallAlpha;
for j = 1: length(alpha);

disp (['When Alpha = ' num2str(alpha(j))]);


cL(j) = (sailCart.cLa*alpha(j) + sailCart.cL0 );
cD(j) = sailCart.cD0 + sailCart.k*cL(j).^2;

vx(j) = 0;
vy(j) = 0;

ax(j) = 0;
ay(j) = 0;

xCart(j) = 0;
yCart(j) = 0;

t = 0;

while yCart(j) < trackWidth - sailCart.wAxle;
    
vx(j) = vx(j) + ax(j) * dt;
vy(j) = vy(j) + ay(j) * dt;

q(j) = .5*rhoATM*sailCart.area*(vWind + vx(j) ).^2;
Lift(j) = cL(j) .* q(j);
Drag(j) = cD(j) .* q(j);

theta(j) = alpha(j) + .5 * atan(Lift(j)./Drag(j)) * (180/pi);
beta(j) = (theta(j) + alpha(j)) * pi/180;

ax(j) = (1/sailCart.totalMass) * (.5 * Lift(j) .* sin(2 * beta(j)) - .5 * Drag(j).* ( 1 + cos(2 * beta(j))) - rollingFriction * cos(beta(j)));
ay(j) = ax(j) .* tan (beta(j));

xCart(j) = xCart(j) + vx(j) * dt;
yCart(j) = yCart(j) + vy(j) * dt;

t = t + dt;
if t>25          % END if it takes more than 5sec to go from edge to edge
disp(['Alpha = ' num2str(alpha(j)) ' is no good'])
    break
end
end


disp(['tack 0 @ t = ' num2str(t) ' seconds and a_x = ' num2str(ax(j)) 'm/s^2']);


sailCart.vFinal(j) = vx(j);

end

% vx
% [maxValue,maxIndex] = max(vx);
% vxMax = vx(maxIndex);
% alphaMax = alpha(maxIndex);
% display(['Max Velocity of ' num2str(vxMax)  ' m/s occurs @ Alpha =' num2str(alphaMax)]);


sailCart.xFinal = xCart;
sailCart.timeFinal = t;
sailCart.totalTime = (trackLength./sailCart.xFinal)*sailCart.timeFinal;
sailCart.totalTime
[minValue,fastestIndex] = min(sailCart.totalTime);
fastestTime = sailCart.totalTime(fastestIndex);
fastestAlpha= alpha(fastestIndex);
display(['Fastest Trip of ' num2str(fastestTime)  ' seconds occurs @ Alpha =' num2str(fastestAlpha) ' degrees']);
disp('Andrew Da Chump')