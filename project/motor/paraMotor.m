function paraMotor(motorController)
    a = motorController.arduino;
    writePWMVoltage(a, motorController.pinIN1, 0);
    writePWMVoltage(a, motorController.pinIN2, 0);
end

