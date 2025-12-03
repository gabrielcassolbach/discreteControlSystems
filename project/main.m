


% Acionar motor no sentido horário e anti-horário.
% parar motor.
% ler sensor.

microcontroller = arduino("COM7", "ESP32-WROOM-DevKitV1");

addpath('./motor');
motor = setupMotor(microcontroller);
[motor, dados] = moveMotor(motor, 90, 60); % arduino, angulo, velmax


