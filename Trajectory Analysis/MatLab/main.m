clc; 
clear all; 

%% Course Constants 

% Track Dimensions [m]
global trackWidth;
global trackLength;
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

%% Test Sections

% buildCart(cRoot, AR, sweep, cla, cl0, cd0, aStall, rhoAxle, rhoBody, rhoMast)
% cla in degree^-1 a stall in degrees

cRoot = .25;
AR = 5;
sweep = 0;
cla = 2*pi*pi/180;
cl0 = 1.1;
cd0 = .03;
aStall = 9;
rhoAxle = rhoWH;
rhoBody = rhoWH;
rhoMast = rhoWH;

sail1 = buildCart(cRoot, AR, sweep, cla, cl0, cd0, aStall, rhoAxle, rhoBody, rhoMast);
sail1 = kinematics(sail1);




