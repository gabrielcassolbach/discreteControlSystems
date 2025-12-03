function motorController = setupMotor(microcontroller)
    % setupMotorDC_JGA25 - Configura e retorna um objeto controlador para motor DC JGA25-370
    % Motor: JGA25-370 (12V, 60 RPM)
    % Driver: Módulo L298N
    % Placa: Arduino UNO
    % Sensor: Encoder incremental
    % Pacote: MATLAB Support Package for Arduino Hardware


    % Definir pinos do Arduino
    % Motor A (JGA25-370)
    pinIN1 = 'D5';      % Controle de direção 1
    pinIN2 = 'D6';      % Controle de direção 2
    %pinENA = 'D5';      % PWM para controle de velocidade (pino PWM)

    % Encoder - usar pinos de interrupção (D2 e D3 para Arduino UNO)
    pinEncoderA = 'D2'; % Interrupção externa 0
    pinEncoderB = 'D3'; % Interrupção externa 1

    % Parâmetros do motor e encoder
    pulsosPerVolta = 39;        % PPV do encoder (ajustar conforme seu encoder)
    reducao = 103;               % Redução da caixa de engrenagens
    pulsosEfetivos = pulsosPerVolta * reducao; % ~500 pulsos por volta do eixo

    % Criar objeto rotaryEncoder usando o pacote Arduino
    encoder = rotaryEncoder(microcontroller, pinEncoderA, pinEncoderB,  pulsosEfetivos);

    % Criar estrutura controladora
    motorController = struct();
    motorController.arduino = microcontroller;
    motorController.encoder = encoder;
    motorController.pinIN1 = pinIN1;
    motorController.pinIN2 = pinIN2;
    motorController.pulsosEfetivos = pulsosEfetivos;
    motorController.velocidadeAlvo = 0;      % RPM alvo
    motorController.posicaoAlvo = 0;         % Posição alvo em graus
    motorController.posicaoAtual = 0;        % Posição atual em graus
    motorController.Kp = 2;                  % Ganho proporcional
    motorController.Ki = 0;                % Ganho integral
    motorController.Kd = 0;                  % Ganho derivativo
    motorController.erroAnterior = 0;
    motorController.somaErro = 0;

    % Vetores para armazenar histórico
    motorController.tempoHistorico = [];
    motorController.posicaoHistorico = [];
    motorController.velocidadeHistorico = [];
    motorController.erroHistorico = [];
    motorController.saidaPIDHistorico = [];

    % Inicializar pinos do motor
    configurePin(microcontroller, motorController.pinIN1, 'PWM');
    configurePin(microcontroller, motorController.pinIN2, 'PWM');
  

    % Resetar contador do encoder
    resetCount(encoder);

    % Parar motor inicialmente
    writePWMVoltage(microcontroller, motorController.pinIN1, 0);
    writePWMVoltage(microcontroller, motorController.pinIN2, 0);
    

    disp('Motor DC JGA25-370 configurado com sucesso!');
    disp(['Pinos Motor: IN1=' motorController.pinIN1 ', IN2=' motorController.pinIN2 ]);
    disp(['Encoder: A=' pinEncoderA ', B=' pinEncoderB]);
    disp('Pacote: MATLAB Support Package for Arduino Hardware');
end

