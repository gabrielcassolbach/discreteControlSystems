s = tf('s'); 
g = 5*(s+1)/(s^2+4*s+5)*exp(-0.1*s); 
dt = 0.01; 
t = 0:dt:5; 
u = ones(length(t),1); 
u(1:1/dt)=0; 
yreal = lsim(g,u,t); 
plot(t,[u,yreal], 'LineWidth',4); 
axis([0 5 0 1.4]); 
grid on; 
legend('u', 'yreal'); 

data = iddata(yreal,u,dt); 
gest1= tfest(data,2,0,NaN); 
step(g,gest1); 
legend('g','gest1'); 
