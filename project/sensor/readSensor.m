function [tempo,luz] = readSensor(a, numamostra,taxa)
writePWMVoltage(a, 'D4', 0)
tic;
for i = 1:numamostra+1
    while toc < taxa*i
        luz(i) = readVoltage(a, "D15");
    end
end
writePWMVoltage(a,'D4',3.3)
for i = numamostra+1:(numamostra+1+numamostra+1)
    while toc <taxa*i
        luz(i) = readVoltage(a, "D15");
    end
end
tempo = toc;
writePWMVoltage(a, 'D4', 0)
end