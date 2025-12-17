function dadosColetados = coletarDadosPulsos(motorController)
    % coletarDadosPulsos - Coleta dados para identificação em termos de pulsos/voltas
    % Saída:
    %   dadosColetados.tempo   - vetor de tempo (s)
    %   dadosColetados.u       - tensão aplicada (V)
    %   dadosColetados.pulsos  - contagem bruta do encoder
    %   dadosColetados.voltas  - número de voltas do eixo (pulsos / pulsosEfetivos)
    
    % Resetar encoder
    resetCount(motorController.encoder);

    % Parâmetros de aquisição
    Ts = 0.05;              % 50 ms
    niveisVoltagem = [0, 1.5, 0, 2.5, 0, 3.3, 0, 2.0, 0, 3.0, 0];
    duracaoDegrau = 2.0;    % s
    tempoTotal = length(niveisVoltagem) * duracaoDegrau;
    numAmostras = round(tempoTotal / Ts);

    tempo  = zeros(numAmostras,1);
    u      = zeros(numAmostras,1);
    pulsos = zeros(numAmostras,1);
    voltas = zeros(numAmostras,1);

    fprintf('Coletando dados (pulsos) com degraus de tensão...\n');

    tic;
    for k = 1:numAmostras
        t = toc;
        tempo(k) = t;

        % Seleciona nível de degrau
        idxDegrau = min(floor(t / duracaoDegrau) + 1, length(niveisVoltagem));
        voltagem = niveisVoltagem(idxDegrau);
        u(k) = voltagem;

        % Aplica tensão em malha aberta
        aplicarTensaoDireta(motorController, voltagem);

        % Lê contagem de pulsos do encoder
        contagem = readCount(motorController.encoder);   % pulsos acumulados[web:32][web:29]
        pulsos(k) = contagem;
        voltas(k) = contagem / motorController.pulsosEfetivos;  % voltas totais[web:19][web:30]

        % Espera até o próximo instante de amostragem
        while toc < k*Ts
            pause(0.001);
        end
    end

    % Para o motor ao final
    pararMotor(motorController);

    % Monta estrutura de saída
    dadosColetados = struct();
    dadosColetados.tempo  = tempo;
    dadosColetados.u      = u;
    dadosColetados.pulsos = pulsos;
    dadosColetados.voltas = voltas;
    dadosColetados.Ts     = Ts;

    % Salva em arquivo
    nomeArquivo = sprintf('dados_pulsos_%s.mat', datestr(now,'yyyymmdd_HHMMSS'));
    save(nomeArquivo, 'dadosColetados');
    fprintf('Coleta finalizada, %d amostras. Arquivo: %s\n', numAmostras, nomeArquivo);
end

function aplicarTensaoDireta(motorController, voltagem)
    % aplicarTensaoDireta - Aplica tensão diretamente ao motor (malha aberta)
    % Entrada:
    %   voltagem: tensão em Volts (0-3.3V)
    
    a = motorController.arduino;
    PWM_MIN = 1.0;  % Tensão mínima para vencer atrito
    
    pwmValue = abs(voltagem);
    
    if pwmValue > 0.1
        pwmValue = max(pwmValue, PWM_MIN);
    else
        pwmValue = 0;
    end
    
    % Aplicar apenas em uma direção (horário)
    if pwmValue > 0
        writePWMVoltage(a, motorController.pinIN1, pwmValue);
        writePWMVoltage(a, motorController.pinIN2, 0);
    else
        writePWMVoltage(a, motorController.pinIN1, 0);
        writePWMVoltage(a, motorController.pinIN2, 0);
    end
end

% function pararMotor(motorController)
%     % pararMotor - Para o motor imediatamente
% 
%     a = motorController.arduino;
%     writePWMVoltage(a, motorController.pinIN1, 0);
%     writePWMVoltage(a, motorController.pinIN2, 0);
% end

% z = iddata(dadosColetados.pulsos, dadosColetados.u, dadosColetados.Ts);

% ident (Data → Import Data → Time domain data [z])

% modelo para tf discreta

% Gz = tf(sys_d); 

% Ts = Gz.Ts;
% C0 = pid(1,1,0,'Ts',Ts,'IFormula','BackwardEuler'); % exemplo PI/PID discreto
% Cpid = pidtune(Gz, C0);

% ou

% [Cpid,info] = pidtune(Gz,'PID');