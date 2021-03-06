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

startAlpha = 15;
stallAlpha = 25;
alpha = startAlpha:stallAlpha;
for j = 1: length(alpha);

%  fprintf (['When Alpha =\t' num2str(alpha(j)) ' degrees, tack 0 occurs @ \n']);


cL(j) = (sailCart.cLa*alpha(j) + sailCart.cL0 );
cD(j) = sailCart.cD0 + sailCart.k*cL(j).^2;

vx(j) = 0;
vy(j) = 0;

ax(j) = 0;
ay(j) = 0;

xCart(j) = 0;
yCart(j) = 0;

t(j) = 0;

while yCart(j) < trackWidth - sailCart.wAxle;
    
vx(j) = vx(j) + ax(j) * dt;
vy(j) = vy(j) + ay(j) * dt;

q(j) = .5*rhoATM*sailCart.area*(vWind + vx(j) ).^2;
Lift(j) = cL(j) .* q(j);
Drag(j) = cD(j) .* q(j);

theta(j) = -alpha(j) + .5 * atan(-Lift(j)./Drag(j)) * (180/pi)+90; %2nd answer in the solution set
beta(j) = (theta(j) + alpha(j)) * pi/180;
beta_deg(j) = beta(j)*180/pi;

ax(j) = (1/sailCart.totalMass) * (.5 * Lift(j) .* sin(2 * beta(j)) - .5 * Drag(j).* ( 1 + cos(2 * beta(j))) - rollingFriction * cos(beta(j)));
ay(j) = ax(j) .* tan (beta(j));

xCart(j) = xCart(j) + vx(j) * dt;
yCart(j) = yCart(j) + vy(j) * dt;

t(j) = t(j) + dt;
if t>30          % END if it takes more than 5sec to go from edge to edge
%  disp(['Alpha = ' num2str(alpha(j)) ' is no good'])
    break
end

end

% All these outputs are right before the first turn occurs (once the sail
% reaches the opposite edge)
% fprintf(['\t t =\t' num2str(t(j)) '\t seconds & \n \t a_x =\t' ...
%     num2str(ax(j)) '\t m/s^2 & \n \t v_x =\t' ...
%     num2str(vx(j)) '\t m/s & \n \t x =\t' ...
%     num2str(xCart(j)) '\t m/s & \n \t theta =\t' ...
%     num2str(theta(j)) '\t degrees & \n \t beta =\t' ...
%     num2str(beta_deg(j)) '\t degrees & \n \t Lift = \t' ...
%     num2str(Lift(j)) '\t N & \n \t Drag = \t'...
%     num2str(Drag(j)) '\t N \n\n'])
    


if xCart(j) < 0
    xCart(j) = NaN;
end
if vx(j) <0
    vx(j) = NaN;
end

%vFinal(j) = vx(j);     %Velocity at the turn (before the turn)


end

% vx
% [maxValue,maxIndex] = max(vx);
% vxMax = vx(maxIndex);
% alphaMax = alpha(maxIndex);
% display(['Max Velocity of ' num2str(vxMax)  ' m/s occurs @ Alpha =' num2str(alphaMax)]);

%xCart
%t
xFinal = xCart;
timeFinal = t;
totalTime = (trackLength./xFinal).*timeFinal;
[minValue,fastestIndex] = min(totalTime);
sailCart.fastestTime = totalTime(fastestIndex);
fastestAlpha= alpha(fastestIndex);
if isnan(sailCart.fastestTime)
else
display(['Fastest Trip of ' num2str(sailCart.fastestTime)  ' seconds occurs @ Alpha =' num2str(fastestAlpha) ' degrees']);
end

%New = sortrow(car,fastestTime);
%sailCart