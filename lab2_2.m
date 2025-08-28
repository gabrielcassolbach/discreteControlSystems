s = tf('s');

% item a.

g = 1/(s^2 + 10*s + 20);
%numG=[1];
%denG=[1 10 20];

ta = 0.01;

% conversão para o domínio discreto.
gz = c2d(g, ta, 'zoh');

%[numZ, denZ] = c2dm(numG, denG, ta, 'zoh');

% item b.
%T = [20 19 17 15 9 -4 -2 0 5 10 11 12];
%stairs(T);

%rlocus(gz)


%numDz=[1 -0.3];
%denDz=[1 -1.6 0.7];
%rlocus (numDz,denDz);
%axis ([-1 1 -1 1]);
%zeta=0.4; Wn=0.3;
%zgrid (zeta,Wn)

sisotool(g)

clc;
