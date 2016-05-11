clc; 
clear all; 

%% Course Constants 
% Track Dimensions [m]
global trackWidth;
global trackLength;
trackWidth = 1.2192; 
trackLength = 4.2672; 
trackHeight = 1.2192; 
%       maxL: 4.9530 
%Track Conditions [kg/m^3]
global rhoATM;
global vWind;
rhoATM = 1.225;
vWind = 6.03;

% Component Masses [kg]
global mFront;
global mMid;
global mEnd;
global mPitch;
m1D = 0.143;
m2d = 0.1695;
mServo = 0.04;
mBatP = 0.010;
mBat = 0.060;
mFront = m2d;
mMid = 2*mServo + mBatP + mBat + mFront;
mPitch = 2*mServo + mBatP + mBat;
mEnd = m1D;

% Dowel Densities [kg/m]
rhoPlank = 0.2856;    % assuiming 2in(0.0508m) width and 0.01m height
rhoWH = 0.08934;
rhoWS = 0.0772;
rhoAl = 0.5563;
%% Test Sections

% buildCart(cRoot, AR, sweep, cla, cl0, cd0, aStall, rhoAxle, rhoBody, rhoMast)
% [cla] = degree^-1, [astall]  degrees



%cla = 2*pi*pi/180; cl0 = 0; cd0 = .03;
aStall = 27.5;         %Stall Angle
    
cla = 0.2454*pi/180; cd0 = 0.057;   cl0 = 1.296;     %case1 ( 5.2697 sec)
%cla = 0.1742*pi/180; cd0 = 0.1228;  cl0 = 1.296;    %case2 ( 5.7847 sec)
%cla = 0.2111*pi/180; cd0 = 0.109;   cl0 = 1.296;    %case3 ( 5.6686 sec)

    
    rhoAxle = rhoAl;
    rhoBody = rhoPlank;
    rhoMast = rhoWH;

iWing = 0;
AR = 1.5:0.1:6.5;             
sweep = 0:8:32;
cRoot = .1:0.05:0.5;

totalWings = length(AR)*length(sweep)*length(cRoot);
wing = zeros(totalWings,3);

%5.3858   25
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
[car]  = kinematics(car);
if isnan(car.fastestTime)
else
fprintf (['Case ' num2str(i) ': When AR =\t' num2str(AR(i)) ' & cRoot =\t' num2str(cRoot(i)) ' & sweep =\t' num2str(sweep(i)) '\n']);
fprintf ('\n')
end
tFastWing(i) = car.fastestTime; 
spanFastest(i) = car.span;
lBodyFastest(i) = car.lBody;
carSpecs(i) = car;



end        
figure
plot (tFastWing, spanFastest,'.')
xlabel ({'Fastest Time For Each Design', '[seconds]'});
ylabel ({'Span' , '[meters]'})
axis ([6 15 0.3 1.2])
figure
plot (tFastWing, lBodyFastest,'.')
xlabel ({'Fastest Time For Each Design', '[seconds]'});
ylabel ({'Body Length' , '[meters]'})
axis ([6 15 0.1 0.8])

figure
plot (tFastWing, AR,'.')
xlabel ({'Fastest Time For Each Design', '[seconds]'});
ylabel ({'AR' })
axis ([6 15 1.5 6.5])

[minValue,fastestIndex] = min(tFastWing);
tFastMax = tFastWing(fastestIndex)
carOptimized = carSpecs(fastestIndex)

fprintf (['FASTEST Travel Time @Case ' num2str(fastestIndex) ': When AR =\t' ...
                  num2str(AR(fastestIndex)) ' & cRoot =\t' ...
                  num2str(cRoot(fastestIndex)) ' & sweep =\t' ...
                  num2str(sweep(fastestIndex)) '\n']);

Afields = fieldnames(carSpecs);
Acell = struct2cell(carSpecs);
sz = size(Acell);            % Notice that the this is a 3 dimensional array.
                            % For MxN structure array with P fields, the size
                            % of the converted cell array is PxMxN
% Convert to a matrix
Acell = reshape(Acell, sz(1), []);      % Px(MxN)

% Make each field a column
Acell = Acell';                         % (MxN)xP

% Sort by first field "name"
Acell = sortrows(Acell, 18);

% Put back into original cell array format
Acell = reshape(Acell', sz);

% Convert to Struct
Asorted = cell2struct(Acell, Afields, 1);

