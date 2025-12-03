% (aula do dia 21/08) -> scripts passados em sala de aula. 

s = tf('s');
g = 1000/(s + 1000);
step(g);

% sistema discreto gz.
% 0.2/1000 define a taxa de amostragem do sistema.
gz = c2d(g, 0.2/1000, 'tustin');

%hold: segura a figura anterior
hold;

step(gz);

clc;
