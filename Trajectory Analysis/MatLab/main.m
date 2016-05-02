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
% [cla] = degree^-1, [astall]  degrees



cla = 2*pi*pi/180;
    cl0 = 1.1;
    cd0 = .03;
    aStall = 27.5;         %Stall Angle
    rhoAxle = rhoWH;
    rhoBody = rhoWH;
    rhoMast = rhoWH;

wing = zeros(125,3);
iWing = 0;
AR = 1:5;             
sweep = 0:8:32;
cRoot = .1:0.1:0.5;

for iAR = 1:length(AR)
    for iSweep = 1:length(sweep)
        for icRoot = 1:length(cRoot)
            
             iWing = iWing +1;
             wing(iWing, 1)= AR(iAR);
             wing(iWing, 2)= sweep(iSweep);
             wing(iWing, 3)= cRoot(icRoot);

        end
    end
end

for i = 1:iWing
   
    AR(i) = wing(i,1);
    sweep(i) = wing(i,2);
    cRoot(i) = wing(i,3);

car = buildCart(cRoot(i), AR(i), sweep(i), cla, cl0, cd0, aStall, rhoAxle, rhoBody, rhoMast);
fprintf (['Case ' num2str(i) ': When AR =\t' num2str(AR(i)) ' & cRoot =\t' num2str(cRoot(i)) ' & sweep =\t' num2str(sweep(i)) '\n']);
car  = kinematics(car);
fprintf ('\n')
end        




