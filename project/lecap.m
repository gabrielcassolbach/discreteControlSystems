function [tempo,vcap] = lecap(objarduino,numamostra,taxa )
tic;
for i = 1:numamostra+1
while toc <taxa*i;
vcap(i) = readVoltage(objarduino, 'A2');
end
tempo = toc;
end