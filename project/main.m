clear

addpath('./motor');
addpath('./sensor');

num_amostras = 10; 
taxa = 1; 
motor = setupMotorDC();

% calibra parâmetros
% [motor, dados] = moverParaPosicao(motor, 45, 30);
% [tempo, luz, media] = readSensor(motor.arduino, num_amostras,taxa);
% fprintf("Luz Medida: %d", sum(media) / numel(media));

ang_atual = 90;

% parâmetros para controlador proporcial da malha do controlador do sensor de luz.
a = 0.8269;
b = 0.0860;

k = (a-b)/1; %cos(0) = 1.
 
while(1)
    [tempo, luz, media] = readSensor(motor.arduino, num_amostras,taxa); 
    light_target = 0.3;
    luz_medida = sum(media) / numel(media);
 
    fprintf("Luz Medida: %d \n", luz_medida);

    erro = light_target - luz_medida; 
    angulo = acosd(cosd(ang_atual) - erro/k);

    angulo_motor = angulo - ang_atual;

    fprintf("angulo_motor: %d \n", angulo_motor);
    if(abs(erro) > 0.1 && ang_atual + angulo_motor <= 90)
        [motor, dados] = moverParaPosicao(motor, angulo_motor, 30); arduino, angulo, velmax
        ang_atual = ang_atual + angulo_motor;
    end
    fprintf("ang_atual: %d\n", ang_atual);
end

% Figura 1 - Erro
figure(1);
plot(dados.tempo, dados.erro);
xlabel('Tempo (s)');
ylabel('Erro (graus)');
grid on;
title('Erro x Tempo');

% Figura 2 - Luz
figure(2);
plot(media);
xlabel('Tempo (s)');
ylabel('Intensidade da luz');
grid on;
title('Luz x Tempo');


