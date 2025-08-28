s = tf('s');
g = 1/(s^2 + 5*s + 6); % filtro passa baixas.

% zero polo gain.
zpk(g);

bode(g);

gz = c2d(g, 0.1, 'tustin'); % método de tustin para amostrar um sinal contínuo. 

step(g);
hold;
step(gz);

bode(gz);

clc;









