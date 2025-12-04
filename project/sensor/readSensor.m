function [tempo,luz] = readSensor(a, numamostra,taxa)
read_pin = 'D12';
write_pin = 'D13'
writePWMVoltage(a, write_pin, 0)
tic;
for i = 1:numamostra+1
    while toc < taxa*i
        luz(i) = readVoltage(a, read_pin);
    end
end
writePWMVoltage(a, write_pin,3.3)
for i = numamostra+1:(numamostra+1+numamostra+1)
    while toc <taxa*i
        luz(i) = readVoltage(a, read_pin);
    end
end
tempo = toc;
writePWMVoltage(a, write_pin, 0)
end