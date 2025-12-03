microcontroller = arduino("COM7", "ESP32-WROOM-DevKitV1");

addpath('./motor');
addpath('./sensor');

motor = setupMotor(microcontroller);
[motor, dados] = moveMotor(motor, 90, 60); % arduino, angulo, velmax

num_amostras = 10; % TO-DO
taxa = 50; % TO-DO

[tempo, luz] = readSensor(microcontroller,num_amostras,taxa);