//
//  main.cpp
//  TrajCalc
//
//  Created by Pedram Madanchian on 4/26/16.
//  Copyright © 2016 Pedram Madanchian. All rights reserved.
//



#include <iostream>
#include <math.h>

using namespace std;

// Global Chit

double PI = 3.14159265359;

// Track Constants [m]
double trackWidth = 1.2192;
double trackLength = 4.2672;
double trackHeight = 1.2192;

// Component Masses [kg]
double m1d = .143;         // 1d wheel
double m2d = .1695;        // 2d wheel
double mServo = .04;
double mBatP = .010;       // Battery Pack
double mBat = .060;        // Battery

double mc = 2*mServo + mBatP + mBat;
double mEnd = m1d;
double mFront = m2d;

// Dowel Densities [kg/m]
double rhoWH = .08934;
double rhoWS = .0772;

// Track Conditions [kg/m^3], [m/s]
double rhoAtm = 1.225;
double vWind = 6.03;
double  q = .5*rhoAtm*vWind*vWind;

// Sail Constants
double cRoot = .3;
double minCamber = .09;
double maxCamber = .09;
double maxAR = 7;
double cla = .0885084;
double cD0 = .03858;
double alphaStall = 7.5;

// Base
double ld = 1.5;            //lenght/width of the car
double rhoBody = rhoWH;
double rhoAxle = rhoWH;
double rhoMast = rhoWH;

// Varied Parameters
double camber;
double AR;
double taperRatio;
double alpha;
double maxL;


// Calculated Geometry
double Span(){
    return AR*cRoot*(1+taperRatio)*.5;
}
double CTip(){
    return taperRatio*cRoot;
}
double Area(){
    return cRoot*.5*(1+taperRatio)*Span();
}
double Yc(){
    return ((1+taperRatio*2)/(1+taperRatio))*(Span()/3)+.0634/2;
}

// Lift
double threeD(){
    return ( AR/(2+pow((4+AR*AR),.5)));
}
double cl0(){
    return 4*PI*camber*cRoot;
}
double cL(){
    return (cl0()+cla*alpha)*threeD();
}
double Lift(){
    return cL()*q*Area();
}
double cL2(double a){
    return (cl0()+cla*a)*threeD();
}
double Lift2(double a){
    return cL2(a)*q*Area();
}
double maxLift(){
    double max =0, loc = 0;
    for (double i =0; i <= alphaStall; i+= .5){
        loc = Lift2(i);
        if(loc>max){
            max = loc;}
        
    }
    
    return max;
}

// Drag
double e(){
    return 1.78*(1-.045*pow(AR,.68))-.64;
}
double cD(){
    double b = cL();
    return cD0 + b*b/(e()*PI*AR);
}
double Drag(){
    return cD()*q*Area();
}


// Trajectory
double theta(){
    return .5*atan((Lift()/Drag()))*180/PI-alpha;
}

// Structure
double mMast(){
    return Span()*rhoMast;
}
double DAxle(){
    double a = (ld*rhoBody+rhoAxle)*9.81/2;             // LOOK AT THIS AGAIN (PEDRAM) -- Checked
    double b = (mEnd+.5*(mc+mMast()+mFront))*9.81;
    double c = -maxL*Yc();                               // CHANGED -- Check again
    return (-b + pow(b*b - 4*a*c,.5))/(2*a);
    
}

double LBody(){
    return DAxle()*ld;
}
double lMast(){
    return (maxLift()*Yc()-mFront*9.81*LBody()+.5*rhoBody*pow(LBody(),2)*9.81)/((mc+mMast())*9.81);
}


// Mass
double mTotal(){
    return mc + mMast() + 2*mEnd + mFront + rhoBody*LBody() + rhoAxle*DAxle();
}

// Kinematics
double ax(){
    double a = (1/mTotal()) * ((Lift()*cos((alpha+theta())*PI/180)+Drag()*sin((alpha+theta())*PI/180))*sin((alpha+theta())*PI/180) - Drag());
    
    
    return a;
}
double ay(){
    double a = ax()*tan((alpha+theta())*PI/180);
    return a;
}
double tTack(){
    
    return pow(2*(trackWidth-DAxle())/ay(),.5);
    
}
double vFinal(){
    return ax()*tTack();
}
double xCovered(){
    return .5*ax()*tTack()*tTack();
}


int main() {
    
    
    
    double camber1=0;
    double AR1=0;
    double area1=0;
    double tR1=0;
    double maxLift1=0;
    double alpha1=0;
    double theta1=0;
    double yc1=0;
    double axle1=0;
    double body1=0;
    double span1=0;
    double m1=0;
    double tt1=0;
    double lift1=0;
    double drag1 = 0;
    double ax1=0;
    double ay1=0;
    double vf1=0;
    double cd1 = 0;
    double ttack1 = 0;
    
    
    
    // Loop
    
    
    for (camber = minCamber; camber <= maxCamber; camber+= .005)
    {
        for(AR = 2; AR <= maxAR; AR+= .5)
            
        {
            for(taperRatio = 1; taperRatio >= 0; taperRatio-= .1)
            {
                maxL = maxLift();
                
                
                
                for(alpha = 0; alpha <= alphaStall; alpha += .5)
                {
                    
                    //                    cout<<"AR: "<<AR<<endl;
                    //                    cout<<"TR: "<<taperRatio<<endl;
                    //                    cout<<"camber: "<<camber<<endl;
                    //                    cout<<"Span: "<<Span()<<endl;
                    //                    cout<<"alpha: "<<alpha<<endl;
                    //                    cout<<"theta: "<<theta()<<endl;
                    //
                    //                    cout<<"lift: "<<Lift()<<endl;
                    //                    cout<<"drag: "<<Drag()<<endl;
                    ////                    cout<<"Theta: "<<theta()<<endl;
                    ////                    cout<<"CD: "<<cD()<<endl;
                    ////                    cout<<"CL: "<<cL()<<endl;
                    ////                    cout<<"Lift: "<<Lift()<<endl;
                    ////                    cout<<"Drag: "<<Drag()<<endl;
                    //                    cout<<"ax: "<<ax()<<endl;
                    //                    cout<<"ay: "<<ay()<<endl;
                    ////                    cout<<"Max Lift: " <<maxL<<endl;
                    ////                    cout<<"mass: "<<mTotal()<<endl;
                    //                    cout<<"Vfinal: "<<vFinal()<<endl;
                    //                      cin.get();
                    // find max v but still in size
                    
                    if(vFinal()>vf1 && DAxle()<trackWidth && Span()< trackHeight*.7 )
                    {
                        vf1 = vFinal();
                        camber1 = camber;
                        area1 = Area();
                        AR1 = AR;
                        span1 = Span();
                        tR1 = taperRatio;
                        axle1 = DAxle();
                        body1 = LBody();
                        maxLift1 = maxLift();;
                        alpha1 = alpha;
                        theta1 = theta();
                        yc1 = Yc();
                        
                        m1 = mTotal();
                        tt1 = tTack();
                        ax1 = ax();
                        ay1 = ay();
                        
                        lift1 = Lift();
                        drag1 = Drag();
                        cd1 = cD();
                        ttack1 = tTack();
                        
                        
                    }
                    
                    
                }
            }
        }
    }
    
    
    cout<<"camber: "<<camber1<<endl;
    cout<<"Taper: "<<tR1<<endl;
    cout<<"AR: "<<AR1<<endl;
    cout<<"Span: "<<span1<<endl;
    cout<<"Chord: "<<cRoot<<endl;
    cout<<"Area: "<<area1<<endl;
    cout<<"CE (y): "<<yc1<<endl;
    cout<<"Axle: "<<axle1<<endl;
    cout<<"Body: "<<body1<<endl;
    cout<<"x Mast: "<<lMast()<<endl;
    cout<<"alpha: "<<alpha1<<endl;
    cout<<"theta: "<<theta1<<endl;
    cout<<"V Final: "<<vf1<<endl;
    cout<<"Mass: "<<m1<<endl<<endl;
    cout<<"ax: "<<ax1<<endl;
    cout<<"ay: "<<ay1<<endl;
    cout<<"Lift: "<<lift1<<endl;
    cout<<"Drag: "<<drag1<<endl;
    cout<<"CD: "<<cd1<<endl;
    cout<<"Time to tack: "<<ttack1<<endl;
    
    
    
}












