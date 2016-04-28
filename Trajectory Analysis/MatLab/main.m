clc; 
clear all; 

%% Course Constants 

% Track Dimensions [m]
trackWidth = 1.2192; 
trackLength = 4.2672; 
trackHeight = 1.2192; 

%Track Conditions [kg/m^3]
global rhoATM;
global vWind;
rhoATM = 1.225;
vWind = 6.03;

% Component Masses [kg]
global mFront;
global mMid;
global mEnd;
m1D = 0.143;
m2d = 0.1695;
mServo = 0.04;
mBatP = 0.010;
mBat = 0.060;
mFront = m2d;
mMid = 2*mServo + mBatP + mBat + mFront;
mEnd = m1D;

% Dowel Densities [kg/m]
rhoWH = 0.08934;
rhoWS = 0.0772;
%% fix span and stuff parameters they are interdependent do not need so many inputs.
% other than that looking not too bad we dont need to worry about
% computation time like monte carlo this is ok. 

%buildCart[cRoot, taper, AR, span, cla, cl0, cd0, aStall, rhoAxle, rhoBody, rhoMast]
sailCart = buildCart(.3, .6, 3.5, .84, 5.07,0, .15, 7.5, rhoWH, rhoWH, rhoWH);
i =1;
for AR = 1:.5:5
       sailCart(i) = buildCart(, 0, AR , 5.06, 0 , .15, 7.6, rhoWH, rhoWH, rhoWH);
       i = i+1;
   end
end




