clear

addpath('./motor');
addpath('./sensor');

motor = setupMotorDC();
[motor, dados] = moverParaPosicao(motor, -45, 30); % arduino, angulo, velmax

num_amostras = 1; % TO-DO
taxa = 0.1; % TO-DO

% [tempo, luz] = readSensor(motor.arduino, num_amostras,taxa);

% while(1):
%     [tempo, luz] = readSensor(motor.arduino, num_amostras,taxa);
% 
%     erro = 0.8 - luz(0);
% 
%     delta_theta = p*erro;
% 
%     theta_atual = 

plot(dados.erro);