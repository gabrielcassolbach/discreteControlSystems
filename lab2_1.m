% Laboratório de discretização - Questão 1


% pólo no plano s, definido como s1 = -2 + 2j.
% z = e^(st)

s1 = -2 + 2*j;

%Transformada Z

%t = 0.1;    % z1 = 0.8024 + 0.1627i
%t = 1;     % z1 = -0.0563 + 0.1231i

z1 = exp(s1*t);

% Backward:

z2 = 1/(1-s1*t);

%t = 0.1 =>  0.8108 + 0.1351i
%t = 1   =>  0.2308 + 0.1538i

% Tustin:

z3 = (2 + t*s1)/(2-t*s1);

%t = 0.1 =>  0.8033 + 0.1639i
%t = 1   => -0.2000 + 0.4000i

% Forward:

z4 = (1 + t*s1);

%t = 0.1 => 0.8000 + 0.2000i
%t = 1   => -1.0000 + 2.0000i

clc;
z4