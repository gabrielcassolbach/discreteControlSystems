function [tempo,luz, media2a2] = readSensor(a, numamostra,taxa)
%writeDigitalPin(a, 'D13', 1)
tic;
for i = 1:numamostra+1
    while toc < taxa*i
        luz(i) = readVoltage(a, "D12");
    end
end
tempo = toc;
%writeDigitalPin(a, 'D13', 0)



% luz já deve existir antes disto
N = length(luz);
media2a2 = zeros(1, floor(N/2));

k = 1;
for i = 1:2:N-1
    media2a2(k) = (luz(i) + luz(i+1)) / 2;
    k = k + 1;
end


end