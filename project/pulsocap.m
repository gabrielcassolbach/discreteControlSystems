function [tempo,vcap] = pulsocap(objarduino,numamostra,taxa )
writeDigitalPin(objarduino,'D8',1);
[tempo1,vcap1] = lecap(objarduino,numamostra,taxa );
writeDigitalPin(objarduino,'D8',0);
[tempo2,vcap2] = lecap(objarduino,numamostra,taxa );
writeDigitalPin(objarduino,'D8',1);
[tempo3,vcap3] = lecap(objarduino,numamostra,taxa );
tempo = tempo1+ tempo2+ tempo3;
vcap = [vcap1 vcap2 vcap3];
end