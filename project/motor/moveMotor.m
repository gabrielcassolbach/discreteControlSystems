function [motorController, dados] = moveMotor(motorController, posicaoAlvo, velocidadeMax)
    % moverParaPosicao - Move o motor para uma posição específica e retorna as curvas
    % Entrada:
    %   motorController: estrutura do controlador
    %   posicaoAlvo: posição desejada em graus (0-360)
    %   velocidadeMax: velocidade máxima em RPM (0-60)
    % Saída:
    %   motorController: estrutura atualizada
    %   dados: estrutura contendo tempo, posição, velocidade, erro e saída PID
me 
    if nargin < 3
        velocidadeMax = 60; % RPM padrão
    end

    motorController.posicaoAlvo = mod(posicaoAlvo, 360);
    motorController.velocidadeAlvo = velocidadeMax;
    motorController.erroAnterior = 0;
    motorController.somaErro = 0;

    % Limpar histórico anterior
    motorController.tempoHistorico = [];
    motorController.posicaoHistorico = [];
    motorController.velocidadeHistorico = [];
    motorController.erroHistorico = [];
    motorController.saidaPIDHistorico = [];

    % Resetar encoder
    resetCount(motorController.encoder);

    % Tempo de execução máximo (segundos)
    tempoMax = 3;
   % tempoInicio = tic;
    
   

    % Taxa de controle: 50ms
    taxaControle = 0.05; % segundos

    fprintf('Movendo para %.1f graus com velocidade máxima de %d RPM...\n', posicaoAlvo, velocidadeMax);
    tic;
    for i = 1:tempoMax/taxaControle+1

        % Ler posição e velocidade do encoder
        contagem = readCount(motorController.encoder);
        velocidadeRPM = readSpeed(motorController.encoder);

        % Converter contagem para graus
        motorController.posicaoAtual = mod((contagem / motorController.pulsosEfetivos) * 360, 360);

        % Converter RPM para graus/segundo
        velocidadeAtual = (velocidadeRPM / 60) * 360;

        % Calcular erro
        erro = motorController.posicaoAlvo - motorController.posicaoAtual;

        % Normalizar erro para -180 a 180
        if erro > 180
            erro = erro - 360;
        elseif erro < -180
            erro = erro + 360;
        end

        % Controlador PID
        motorController.somaErro = motorController.somaErro + erro;
        derivada = erro - motorController.erroAnterior;

        saidaPID = 1 * erro + ...
                   motorController.Ki * motorController.somaErro + ...
                   motorController.Kd * derivada;

        motorController.erroAnterior = erro;

        % Limitar saída PID
        saidaPID = max(min(saidaPID, motorController.velocidadeAlvo), -motorController.velocidadeAlvo);

        % Armazenar dados históricos
        motorController.tempoHistorico = [motorController.tempoHistorico; taxaControle*i];
        motorController.posicaoHistorico = [motorController.posicaoHistorico; motorController.posicaoAtual];
        motorController.velocidadeHistorico = [motorController.velocidadeHistorico; velocidadeAtual];
        motorController.erroHistorico = [motorController.erroHistorico; erro];
        motorController.saidaPIDHistorico = [motorController.saidaPIDHistorico; saidaPID];

        % Aplicar controle ao motor
      %  if abs(erro) <= tolerancia
            % Posição atingida
       %     pararMotor(motorController);
        %    fprintf('Posição atingida: %.1f graus\n', motorController.posicaoAtual);

            % Armazenar último ponto
          %  motorController.tempoHistorico = [motorController.tempoHistorico; toc(tempoInicio)];
            %motorController.posicaoHistorico = [motorController.posicaoHistorico; motorController.posicaoAtual];
            %motorController.velocidadeHistorico = [motorController.velocidadeHistorico; 0];
           % motorController.erroHistorico = [motorController.erroHistorico; 0];
          %  motorController.saidaPIDHistorico = [motorController.saidaPIDHistorico; 0];
         %   break;
        %else
            % Controlar velocidade e direção
            controlarMotor(motorController, saidaPID);
       % end

        % Aguardar até o próximo ciclo de controle 
       while toc <taxaControle*i;
            pause(0.001); % Sleep de 1ms para não sobrecarregar CPU
        end
     
    % Criar estrutura de dados de saída
    dados = struct();
    dados.tempo = motorController.tempoHistorico;
    dados.posicao = motorController.posicaoHistorico;
    dados.velocidade = motorController.velocidadeHistorico;
    dados.erro = motorController.erroHistorico;
    dados.saidaPID = motorController.saidaPIDHistorico;
    dados.posicaoAlvo = motorController.posicaoAlvo;
    dados.velocidadeMax = motorController.velocidadeAlvo;
    end
       pararMotor(motorController);