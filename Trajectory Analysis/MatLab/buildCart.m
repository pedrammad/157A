function [sailCart] = buildCart(cRoot, taper, AR, span, cla, cl0, cd0, aStall, rhoAxle, rhoBody, rhoMast)

global rhoATM;
global vWind;
global mFront;
global mMid;
global mEnd;

% Uses aerodata to convert 2d to 3d 
% Uses 3D characteristics and weights to define base dimensions

% Sail Geometric  Properties 
sailCart.cTip = taper*cRoot;
sailCart.area = cRoot * 0.5 * (1 + taper)*span;
sailCart.yc = ((1 + 2*taper)/(1 + taper))*(span/3);

% Lift
threeD = AR/(2 + (4 + AR^2)^.5);
sailCart.cLa = cla * threeD;
sailCart.cL0 = cl0 * threeD;
sailCart.maxL = 2.6;
% 0.5*rhoATM*vWind^2*sailCart.area*(sailCart.cLa*aStall*pi/180 + sailCart.cL0);

sailCart.mMast = span*rhoMast;

% Axle
lw = 1.5;
a = (lw *rhoBody + rhoAxle)*9.81/2;
disp(a)
b = (mEnd + 0.5*(mMid + sailCart.mMast))*9.81;
disp(b)
c = -sailCart.maxL*sailCart.yc;
sailCart.wAxle = (-b + (b^2 - 4*a*c)^.5)/(2*a);

% Body 
sailCart.lBody = lw*sailCart.wAxle;

% Drag
e = 1.78*(1-0.045*AR^0.68) - 0.64;
sailCart.k = 1/(pi*AR*e);
sailCart.cD0 = cd0;

% Total Mass
sailCart.totalMass = mMid + sailCart.mMast + 2*mEnd + mFront + rhoBody*sailCart.lBody + rhoAxle*sailCart.wAxle;









