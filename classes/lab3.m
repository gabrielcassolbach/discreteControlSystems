z = tf("z")

% Create the transfer function
g = (z+1)/((z-1)*(z+0.5))

% Display the transfer function
rlocus(g);

K = 1;
step(feedback(K*g, 1))
hold;
K = 1.2;
step(feedback(K*g, 1))


s = tf("s")
g = 1/(s*(s+1));
gz = c2d(g, 0.1, 'zoh');

step(feedback(g, 1));
hold;
step(feedback(gz, 1));

sisotool(gz);

clc;