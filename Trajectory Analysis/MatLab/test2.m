clc;
close all;
 l = 	3.152;
 d = 	0.35986;

 alpha = 7.5;
 theta = 0:.2:65;
 
 beta = (alpha + theta)*pi/180;
 
 y = l * cos(2 * beta) + d * sin(2 * beta);
 z = zeros(1, length(y));
 
 s  = tan(2*beta);
 t = -l/d* ones(length(y));
 
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

 
 disp(l * cos(2*ans) + d * sin(2*ans))