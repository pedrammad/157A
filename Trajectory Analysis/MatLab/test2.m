clc;
close all;
 L = 	3.152;
 D = 	0.35986;

 alpha = 7.5;
 theta = 0:.1:65;
 beta_deg=(alpha + theta);
 beta = (alpha + theta)*pi/180;
 
 y = L * cos(2 * beta) + D * sin(2 * beta);
 z = zeros(1, length(y));
 
 s  = tan(2*beta);
 t(1:length(y)) = -L/D;
 
 figure
 hold on;
 plot(theta, y );
 plot(theta, z);
 legend('dfx','zer0')
 
 figure
 hold on;
 plot(theta,s);
 plot(theta,t, 'linewidth', 2, 'color','k');
 legend('tan(2beta)','-l/d')

beta2 = 0.5*atan(-L/D)
L * cos(2 * beta2) + D * sin(2 * beta2)
 %disp(l * cos(2*ans) + d * sin(2*ans))