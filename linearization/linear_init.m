theta1=3.1;
theta2=9.5;
theta3=0.24;
theta4=0.77;
g=9.81;
l1=0.3;
l2=0.58;

A=7;
B=8;
C=1;
D=7;

%%%%%%%%%%%%
%u = [0;0];
Kp11 = 1000;
Kd11 = 100;
%%%%%%%%%%%%
Kp22 = Kp11;
Kd22 = Kd11;

Kp=[Kp11 0; 0 Kp22];
Kd=[Kd11 0; 0 Kd22];

%out=sim("lab1.slx");