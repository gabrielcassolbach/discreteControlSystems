clear
addpath('./motor');

controller = setupMotorDC();

writePWMVoltage(controller.arduino, controller.pinIN1, 0);
writePWMVoltage(controller.arduino, controller.pinIN2, 1);

pause(3); % mantém 2 segundos ligado

% PARA
writePWMVoltage(controller.arduino, controller.pinIN1, 0);
writePWMVoltage(controller.arduino, controller.pinIN2, 0);
