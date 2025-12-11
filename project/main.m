clear

addpath('./motor');
addpath('./sensor');

num_amostras = 10; 
taxa = 1; 
motor = setupMotorDC();
%[motor, dados] = moverParaPosicao(motor, -15, 30);
%[tempo, luz, media] = readSensor(motor.arduino, num_amostras,taxa);
%fprintf("Luz Medida: %d", sum(media) / numel(media));


ang_atual = 0;

while(1)
     [tempo, luz, media] = readSensor(motor.arduino, num_amostras,taxa);


     light_target = 0.01;
     luz_medida = sum(media) / numel(media);

     fprintf("Luz Medida: %d\n", luz_medida);

     erro = light_target - luz_medida; 

     k = 1.472;
     a = 0.45;
     b = 0.015;

     v = (a-b)/k;

     angulo = acosd(v);

     fprintf("angulo: %d\n", angulo);

     if(erro < 0)
        angulo = -angulo;
     end

     if(abs(erro) > 0.1)
        [motor, dados] = moverParaPosicao(motor, angulo, 30); % arduino, angulo, velmax
        ang_atual = ang_atual + angulo;
     end
     pause(1);
end
% 
% Figura 1 - Erro
%figure(1);
%plot(dados.tempo, dados.erro);
%xlabel('Tempo (s)');
%ylabel('Erro (graus)');
%grid on;
%title('Erro x Tempo');

% Figura 2 - Luz
figure(2);
plot(media);
xlabel('Tempo (s)');
ylabel('Intensidade da luz');
grid on;
title('Luz x Tempo');


