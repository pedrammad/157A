function [sailCart] = buildCart(cRoot, AR, sweep, cla, cl0, cd0, aStall, rhoAxle, rhoBody, rhoMast)

global rhoATM;
global vWind;
global mFront;
global mMid;
global mEnd;

% Uses aerodata to convert 2d to 3d 
% Uses 3D characteristics and weights to define base dimensions

% Sail Geometric  Properties 
taper = 0;
sailCart.span = AR*cRoot*(1 + taper)*.5;
sailCart.AR = AR;
sailCart.cTip = taper*cRoot;
sailCart.area = cRoot * 0.5 * (1 + taper)*sailCart.span;
sailCart.yc = ((1 + 2*taper)/(1 + taper))*(sailCart.span/3);
sailCart.cRoot = cRoot;
% Lift
sailCart.threeD = sailCart.AR/(2 + (4 + sailCart.AR^2)^.5);
sailCart.cLa = cla * sailCart.threeD;
sailCart.cL0 = cl0 * sailCart.threeD;
sailCart.maxL = 0.5*rhoATM*vWind^2*sailCart.area*(sailCart.cLa*aStall + sailCart.cL0);

sailCart.mMast = sailCart.span*rhoMast;

% Axle
lw = 1.5;
a = (lw *rhoBody + rhoAxle)*9.81/2;
b = (mEnd + 0.5*(mMid + sailCart.mMast))*9.81;
c = -sailCart.maxL*sailCart.yc;
sailCart.wAxle = (-b + (b^2 - 4*a*c)^.5)/(2*a);

% Body 
sailCart.lBody = lw*sailCart.wAxle;

% Drag
e = 4.61*(1 - 0.045*sailCart.AR^0.68)*(cos(sweep*pi/180))^0.15 - 3.1; % Raymer pg 299
sailCart.k = 1/(pi*sailCart.AR*e);
sailCart.cD0 = cd0;

% Total Mass
sailCart.totalMass = mMid + sailCart.mMast + 2*mEnd + mFront + rhoBody*sailCart.lBody + rhoAxle*sailCart.wAxle;









