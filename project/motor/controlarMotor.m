function controlarMotor(motorController, velocidade)
    % controlarMotor - Controla a velocidade e direção do motor
    % Entrada:
    %   velocidade: velocidade em RPM (-60 a +60)
    %              positivo = sentido horário, negativo = anti-horário

    a = motorController.arduino;

    % Converter RPM para voltagem PWM (0-12V)
    PWM_MIN = 1.0;

    pwmValue = abs(velocidade/60) * 3.0; % Voltagem (0-5V)

    if pwmValue > 0
        pwmValue = max(pwmValue, PWM_MIN);
    end
    

    fprintf("pwmValue: %d\n",pwmValue);


    if velocidade > 0
        % Sentido horário
        writePWMVoltage(a, motorController.pinIN1, pwmValue);
        writePWMVoltage(a, motorController.pinIN2, 0);
    elseif velocidade < 0
        % Sentido anti-horário
        writePWMVoltage(a, motorController.pinIN1, 0);
        writePWMVoltage(a, motorController.pinIN2, pwmValue);
    else
        % Parado
         writePWMVoltage(a, motorController.pinIN1, 0);
        writePWMVoltage(a, motorController.pinIN2,0);
        pwmValue = 0;
    end

  
end