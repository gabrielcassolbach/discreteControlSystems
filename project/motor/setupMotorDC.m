function motorController = setupMotorDC()
    % setupMotorDC_JGA25 - Configura e retorna um objeto controlador para motor DC JGA25-370
    % Motor: JGA25-370 (12V, 60 RPM)
    % Driver: Módulo L298N
    % Placa: Arduino UNO
    % Sensor: Encoder incremental
    % Pacote: MATLAB Support Package for Arduino Hardware

    % Criar objeto Arduino
    %a = arduino("/dev/cu.usbserial-A5069RR4","ESP32-WROOM-DevKitV1");
    a = arduino("/dev/ttyUSB0","ESP32-WROOM-DevKitV1");

    % Definir pinos do Arduino
    % Motor A (JGA25-370)
    pinIN1 = 'D23';      % Controle de direção 1
    pinIN2 = 'D22';      % Controle de direção 2
    %pinENA = 'D5';      % PWM para controle de velocidade (pino PWM)

    % Encoder - usar pinos de interrupção (D2 e D3 para Arduino UNO)
    pinEncoderA = 'D2'; % Interrupção externa 0
    pinEncoderB = 'D4'; % Interrupção externa 1

    % Parâmetros do motor e encoder
    pulsosPerVolta = 45;        % PPV do encoder (ajustar conforme seu encoder)
    reducao = 103;               % Redução da caixa de engrenagens
    pulsosEfetivos = pulsosPerVolta * reducao; % ~500 pulsos por volta do eixo

    % Criar objeto rotaryEncoder usando o pacote Arduino
    encoder = rotaryEncoder(a, pinEncoderA, pinEncoderB,  pulsosEfetivos);

    % Criar estrutura controladora
    motorController = struct();
    motorController.arduino = a;
    motorController.encoder = encoder;
    motorController.pinIN1 = pinIN1;
    motorController.pinIN2 = pinIN2;
    motorController.pulsosEfetivos = pulsosEfetivos;
    motorController.velocidadeAlvo = 0;      % RPM alvo
    motorController.posicaoAlvo = 0;         % Posição alvo em graus
    motorController.posicaoAtual = 0;        % Posição atual em graus
    motorController.Kp = 3;                  % Ganho proporcional
    motorController.Ki = 0.3;                % Ganho integral
    motorController.Kd = 0;                  % Ganho derivativo
    motorController.erroAnterior = 0;
    motorController.somaErro = 0;

    % Vetores para armazenar histórico
    motorController.tempoHistorico = [];
    motorController.posicaoHistorico = [];
    motorController.velocidadeHistorico = [];
    motorController.erroHistorico = [];
    motorController.saidaPIDHistorico = [];
  

    % Resetar contador do encoder
    resetCount(encoder);

    % Parar motor inicialmente
    writePWMVoltage(a, motorController.pinIN1, 0);
    writePWMVoltage(a, motorController.pinIN2, 0);

    disp('Motor DC JGA25-370 configurado com sucesso!');
    disp(['Pinos Motor: IN1=' motorController.pinIN1 ', IN2=' motorController.pinIN2 ]);
    disp(['Encoder: A=' pinEncoderA ', B=' pinEncoderB]);
    disp('Pacote: MATLAB Support Package for Arduino Hardware');
end